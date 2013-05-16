//
//  SideMenuTableViewCell.m
//  TeraData
//
//  Created by Michael Brodeur on 5/14/13.
//  Copyright (c) 2013 SmashingBoxes. All rights reserved.
//

#import "SideMenuTableViewCell.h"

@implementation SideMenuTableViewCell

@synthesize titleLabel;
@synthesize selectedView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
