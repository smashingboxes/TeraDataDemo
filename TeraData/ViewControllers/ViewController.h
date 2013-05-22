//
//  ViewController.h
//  TeraData
//
//  Created by Michael Brodeur on 5/14/13.
//  Copyright (c) 2013 SmashingBoxes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "PopUpViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,CustomButtonDelegate, PopUpViewControllerDelegate>

@end
