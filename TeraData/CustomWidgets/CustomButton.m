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

@end


@implementation CustomButton

@synthesize storedGraphImage;
@synthesize isActive;
@synthesize titleLabel;
@synthesize graphImageView;
@synthesize highlightedImageView;
@synthesize delegate;

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
        //highlightedImageView.layer.cornerRadius = 7.0f;
        [self addSubview:graphImageView];
        [self addSubview:highlightedImageView];
        [self addSubview:titleLabel];
        
        //self.backgroundColor = [UIColor whiteColor];
        //self.layer.cornerRadius = 7.0f;
        // Set the colors for the gradient layer.
        /*static NSMutableArray *colors = nil;
        if (colors == nil) {
            colors = [[NSMutableArray alloc] initWithCapacity:3];
            UIColor *color = nil;
            color = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0];
            [colors addObject:(id)[color CGColor]];
            color = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0];
            [colors addObject:(id)[color CGColor]];
            color = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0];
            [colors addObject:(id)[color CGColor]];
        }
        [(CAGradientLayer *)self.layer setColors:colors];
        [(CAGradientLayer *)self.layer setLocations:[NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.48], [NSNumber numberWithFloat:1.0], nil]];*/
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
        highlightedImageView.backgroundColor = [UIColor redColor];
    }else if([theColor isEqualToString:@"Green"]){
        highlightedImageView.backgroundColor = [UIColor greenColor];
    }else if([theColor isEqualToString:@"Blue"]){
        highlightedImageView.backgroundColor = [UIColor blueColor];
    }else if([theColor isEqualToString:@"Purple"]){
        highlightedImageView.backgroundColor = [UIColor purpleColor];
    }else if([theColor isEqualToString:@"Orange"]){
        highlightedImageView.backgroundColor = [UIColor orangeColor];
    }
}


#pragma mark - Touch Methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // Do nothing.
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self buttonPressed];
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
