//
//  CustomButton.m
//  TeraData
//
//  Created by Michael Brodeur on 5/15/13.
//  Copyright (c) 2013 SmashingBoxes. All rights reserved.
//

#import "CustomButton.h"
#import <QuartzCore/QuartzCore.h>

@interface CustomButton()

@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)UIImageView *graphImageView;
@property(nonatomic)UIImageView *highlightedImageView;
@property(nonatomic)id<CustomButtonDelegate> delegate;
@property(nonatomic)BOOL isMoving;

@end


@implementation CustomButton

@synthesize parentView;
@synthesize storedGraphImage;
@synthesize buttonTitle;
@synthesize isActive;
@synthesize isFocus;
@synthesize titleLabel;
@synthesize graphImageView;
@synthesize highlightedImageView;
@synthesize delegate;
@synthesize isMoving;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(Class)layerClass {
    return [CAGradientLayer class];
}

-(id)initWithFrame:(CGRect)frame andGraphImage:(UIImage *)theImage andTitle:(NSString *)theTitle{
    self = [super initWithFrame:frame];
    if(self){
        isActive = NO;
        storedGraphImage = theImage;
        buttonTitle = theTitle;
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        titleLabel.center = CGPointMake(frame.size.width/2, 100);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = theTitle;
        titleLabel.textColor = [UIColor darkGrayColor];
        CGRect imageFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        graphImageView = [[UIImageView alloc]initWithFrame:imageFrame];
        graphImageView.image = [UIImage imageNamed:@"graph_off.png"];
        highlightedImageView = [[UIImageView alloc]initWithFrame:imageFrame];
        highlightedImageView.image = [UIImage imageNamed:@"graph_on_blue.png"];
        highlightedImageView.hidden = YES;
        [self addSubview:graphImageView];
        [self addSubview:highlightedImageView];
        [self addSubview:titleLabel];
        
        isFocus = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setDelegate:(id<CustomButtonDelegate>)theDelegate{
    if(!delegate)
        delegate = theDelegate;
}

-(void)setTitle:(NSString *)theTitle{
    if(titleLabel)
        titleLabel.text = theTitle;
}

-(void)setGraphImage:(UIImage *)theImage{
    storedGraphImage = theImage;
}

-(void)setHighlightedColor:(NSString *)theColor{
    if([theColor isEqualToString:@"Red"]){
        highlightedImageView.image = [UIImage imageNamed:@"graph_on_red.png"];
    }else if([theColor isEqualToString:@"Green"]){
        highlightedImageView.image = [UIImage imageNamed:@"graph_on_green.png"];
    }else if([theColor isEqualToString:@"Blue"]){
        highlightedImageView.image = [UIImage imageNamed:@"graph_on_blue.png"];
    }else if([theColor isEqualToString:@"Purple"]){
        highlightedImageView.image = [UIImage imageNamed:@"graph_on_purple.png"];
    }else if([theColor isEqualToString:@"Orange"]){
        highlightedImageView.image = [UIImage imageNamed:@"graph_on_orange.png"];
    }
}


#pragma mark - Touch Methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // Do nothing.
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!isActive){
        UITouch *touch = [[event allTouches] anyObject];
        
        if(!isFocus && delegate){
            CGPoint startingPoint = [touch locationInView:parentView];
            [delegate buttonDidBeginDragging:self withStartingPoint:startingPoint];
            isFocus = YES;
        }
        
        CGPoint pPrev = [touch previousLocationInView:self];
        CGPoint p = [touch locationInView:self];
        
        CGPoint center = self.center;
        center.x += p.x - pPrev.x;
        center.y += p.y - pPrev.y;
        self.center = center;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!isFocus){
        [self buttonPressed];
    }else{
        if(delegate)
            [delegate buttonDidLetGo:self];
        isFocus = NO;
    }
}

-(void)buttonPressed{
    if(highlightedImageView.hidden){
        highlightedImageView.hidden = NO;
        titleLabel.textColor = [UIColor whiteColor];
        if(delegate)
            [delegate buttonDidReceivePress:storedGraphImage withSender:self];
        isActive = YES;
    }else if(!highlightedImageView.hidden){
        highlightedImageView.hidden = YES;
        titleLabel.textColor = [UIColor darkGrayColor];
        if(delegate)
            [delegate buttonDidReceivePress:storedGraphImage withSender:self];
        isActive = NO;
    }
}

@end
