//
//  PopUpViewController.h
//  TeraData
//
//  Created by Michael Brodeur on 5/15/13.
//  Copyright (c) 2013 SmashingBoxes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopUpViewControllerDelegate <NSObject>

-(void)optionSelected:(NSString*)optionSelected;

@end


@interface PopUpViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic)id<PopUpViewControllerDelegate> delegate;

@end
