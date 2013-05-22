//
//  CustomButton.h
//  TeraData
//
//  Created by Michael Brodeur on 5/15/13.
//  Copyright (c) 2013 SmashingBoxes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomButtonDelegate <NSObject>

-(void)buttonDidReceivePress:(UIImage*)graphImage withSender:(id)sender;
-(void)buttonDidBeginDragging:(id)sender withStartingPoint:(CGPoint)startingPoint;
-(void)buttonDidLetGo:(id)sender;

@end


@interface CustomButton : UIView

@property(nonatomic)UIView *parentView;
@property(nonatomic)UIImage *storedGraphImage;
@property(nonatomic)NSString *buttonTitle;
@property(nonatomic)BOOL isActive;
@property(nonatomic)BOOL isFocus;

-(id)initWithFrame:(CGRect)frame andGraphImage:(UIImage*)theImage andTitle:(NSString*)theTitle;
-(void)setTitle:(NSString*)theTitle;
-(void)setDelegate:(id<CustomButtonDelegate>)theDelegate;
-(void)setHighlightedColor:(NSString*)theColor;
-(void)setGraphImage:(UIImage*)theImage;
-(void)buttonPressed;

@end
