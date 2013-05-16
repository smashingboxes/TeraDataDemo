//
//  PopUpViewController.m
//  TeraData
//
//  Created by Michael Brodeur on 5/15/13.
//  Copyright (c) 2013 SmashingBoxes. All rights reserved.
//

#import "PopUpViewController.h"
#import "PopUpTableViewCell.h"

@interface PopUpViewController ()

@property(nonatomic)IBOutlet UITableView *theTableView;
@property(nonatomic)NSArray *cellArray;
@property(nonatomic)int rowCount;

@end

@implementation PopUpViewController

@synthesize theTableView;
@synthesize cellArray;
@synthesize delegate;
@synthesize rowCount;

-(id)init{
    if(self == [super init]){
        NSArray *items = [[NSArray alloc]initWithObjects:@"Clear-All", @"Export PDF", @"Email", nil];
        cellArray = [[NSArray alloc]initWithObjects:items, nil];
        rowCount = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    //cellArray = [[NSArray alloc]initWithObjects:@"Clear-All", @"Export PDF", @"Email", nil];
    //[theTableView reloadData];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier = @"PopUpTableViewCell";
    PopUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if(cell == nil){
        NSArray *topLevelObjects = [[NSBundle mainBundle]loadNibNamed:@"PopUpTableViewCell" owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    NSArray *currentArray = [cellArray objectAtIndex:0];
    
    NSString *theString = [currentArray objectAtIndex:rowCount];
    
    NSLog(@"Text at index %i is: %@", rowCount, theString);
    
    cell.cellLabel.text = theString;
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    rowCount += 1;
    
    return cell;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 64;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PopUpTableViewCell *cell = (PopUpTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if(delegate)
        [delegate optionSelected:cell.cellLabel.text];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
