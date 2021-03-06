//
//  ViewController.m
//  TeraData
//
//  Created by Michael Brodeur on 5/14/13.
//  Copyright (c) 2013 SmashingBoxes. All rights reserved.
//

#import "ViewController.h"
#import "SideMenuTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+HexString.h"

@interface ViewController ()

@property(nonatomic)IBOutlet UIView *sideMenuBar;
@property(nonatomic)IBOutlet UIScrollView *graphScrollView;
@property(nonatomic)IBOutlet UIView *containerGraphView;
@property(nonatomic)IBOutlet UIScrollView *buttonScrollView;
@property(nonatomic)IBOutlet UITableView *sideMenuTableView;
@property(nonatomic)IBOutlet UIImageView *topGradientView;
@property(nonatomic)IBOutlet UIImageView *bottomGradientView;
@property(nonatomic)CustomButton *clonedButton;
@property(nonatomic)NSArray *buttonArray;
@property(nonatomic)NSMutableArray *selectedArray;
@property(nonatomic)int selectedRow;
@property(nonatomic)BOOL inView;
@property(nonatomic)UIPopoverController *popoverController;
@property(nonatomic)CGPoint originalButtonPoint;

@end


@implementation ViewController

@synthesize sideMenuBar;
@synthesize graphScrollView;
@synthesize containerGraphView;
@synthesize buttonScrollView;
@synthesize sideMenuTableView;
@synthesize topGradientView;
@synthesize bottomGradientView;
@synthesize clonedButton;
@synthesize buttonArray;
@synthesize selectedArray;
@synthesize selectedRow;
@synthesize inView;
@synthesize popoverController;
@synthesize originalButtonPoint;

- (void)viewDidLoad
{
    inView = NO;
    selectedRow = NSNotFound;
    
    buttonArray = [[NSArray alloc]initWithObjects:@"Print Ads", @"Social Media", @"Email", @"In-Store", nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                UITextAttributeTextColor: [UIColor whiteColor],
                          UITextAttributeTextShadowColor: [UIColor clearColor],
                         UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 0.0f)],
                                     UITextAttributeFont: [UIFont fontWithName:@"Helvetica-Bold" size:15.0f]
     }];
    
    [self setTitleForNavigationBarWithDataType:@"Print Ads"];
    [self loadButtonsForScrollView];
    [self createMenuButtons];
    [self createSelectedStates];
    sideMenuBar.center = CGPointMake(-91, 352);
    [sideMenuTableView reloadData];
    [self setUpGraphView];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    UIColor *blueGradient = [UIColor colorFromHexString:@"0060C5"];
    [self.navigationController.navigationBar setTintColor:blueGradient];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpGraphView{
    graphScrollView.minimumZoomScale = 1.0;
    graphScrollView.maximumZoomScale = 3.0;
    graphScrollView.zoomScale = 1.0;
    graphScrollView.delegate = self;
}

-(void)setTitleForNavigationBarWithDataType:(NSString*)type{
    NSString *titleString = [[NSString alloc]initWithFormat:@"WALMART SALES (RALEIGH, NC) : %@", type];
    self.navigationItem.title = titleString;
}

-(void)createMenuButtons{
    UIBarButtonItem *buttonA = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(sideBarButtonPressed)];
    self.navigationItem.leftBarButtonItem = buttonA;
    
    UIBarButtonItem *buttonB = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(menuButtonPressed:)];
    self.navigationItem.rightBarButtonItem = buttonB;
}

-(void)createSelectedStates{
    if(!selectedArray)
        selectedArray = [[NSMutableArray alloc]init];
    
    [selectedArray addObject:[NSNumber numberWithBool:YES]];
    
    selectedRow = 0;
     
    for(int i = 0; i < [buttonArray count]-1; i++){
        [selectedArray addObject:[NSNumber numberWithBool:NO]];
    }
}


#pragma mark - Initial Loading Methods

-(void)loadButtonsForScrollView{
    [buttonScrollView setContentSize:CGSizeMake(2800, 172)];
    
    for(int i = 0; i < 20; i++){
        NSString *buttonTitleString = [[NSString alloc]initWithFormat:@"WM%i",i+1];
        
        CustomButton *aButton = [[CustomButton alloc]initWithFrame:CGRectMake(5 + (140*i), 20, 132, 133) andGraphImage:nil andTitle:buttonTitleString];
        [aButton setDelegate:self];
        aButton.parentView = self.view;
        UIImage *theImage;
        switch (i) {
            case 0:
                [aButton setHighlightedColor:@"Red"];
                theImage = [self setImageForColor:@"Red"];
                [aButton setStoredGraphImage:theImage];
                break;
            case 1:
                [aButton setHighlightedColor:@"Blue"];
                theImage = [self setImageForColor:@"Blue"];
                [aButton setStoredGraphImage:theImage];
                break;
            case 2:
                [aButton setHighlightedColor:@"Green"];
                theImage = [self setImageForColor:@"Green"];
                [aButton setStoredGraphImage:theImage];
                break;
            case 3:
                [aButton setHighlightedColor:@"Purple"];
                theImage = [self setImageForColor:@"Purple"];
                [aButton setStoredGraphImage:theImage];
                break;
            case 4:
                [aButton setHighlightedColor:@"Orange"];
                theImage = [self setImageForColor:@"Orange"];
                [aButton setStoredGraphImage:theImage];
                break;
            default:
                break;
        }
        aButton.tag = i;
        [buttonScrollView addSubview:aButton];
    }
}

-(UIImage*)setImageForColor:(NSString*)color{
    UIImage *theImage;
    if([color isEqualToString:@"Red"]){
        theImage = [UIImage imageNamed:@"red_Chart@2x.png"];
    }else if([color isEqualToString:@"Blue"]){
        theImage = [UIImage imageNamed:@"blue_Chart@2x.png"];
    }else if([color isEqualToString:@"Green"]){
        theImage = [UIImage imageNamed:@"green_Chart@2x.png"];
    }else if([color isEqualToString:@"Purple"]){
        theImage = [UIImage imageNamed:@"purple_Chart@2x.png"];
    }else if([color isEqualToString:@"Orange"]){
        theImage = [UIImage imageNamed:@"orange_Chart@2x.png"];
    }
    return theImage;
}


#pragma mark - Navigation Bar Button Methods

-(void)menuButtonPressed:(id)sender{
    PopUpViewController *popUpVC = [[PopUpViewController alloc]init];
    popUpVC.delegate = self;
    
    if(!popoverController){
        popoverController = [[UIPopoverController alloc]initWithContentViewController:popUpVC];
        [popoverController setPopoverContentSize:CGSizeMake(300, 190)];
        [popoverController presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }else{
        [popoverController dismissPopoverAnimated:YES];
        popoverController = nil;
    }
}

-(void)sideBarButtonPressed{
    if(!inView){
        [UIView animateWithDuration:0.5 animations:^{
            sideMenuBar.center = CGPointMake(91, 352);
        }];
        inView = YES;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            sideMenuBar.center = CGPointMake(-91, 352);
        }];
        inView = NO;
    }
}


#pragma mark - Custom Button Delegate Methods

-(void)buttonDidReceivePress:(UIImage *)graphImage withSender:(id)sender{
    CustomButton *aButton = sender;
    
    NSArray *subviews = [containerGraphView subviews];
    
    NSLog(@"%@",subviews);
    
    if(!aButton.isActive){
        // Add logic
        UIImageView *graphImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 532)];
        graphImageView.image = graphImage;
        graphImageView.alpha = 1.0;
        graphImageView.tag = aButton.tag;
        [containerGraphView addSubview:graphImageView];
        return;
    }else{
        if([subviews count] > 1){
            for(int i = 0; i < [subviews count]; i++){
                if([[subviews objectAtIndex:i] respondsToSelector:@selector(initWithImage:)]){
                    UIImageView *comparedImageView = [subviews objectAtIndex:i];
                    
                    if(comparedImageView.tag == aButton.tag){
                        [comparedImageView removeFromSuperview];
                        return;
                    }
                }
            }
        }
    }
}

-(void)buttonDidBeginDragging:(id)sender withStartingPoint:(CGPoint)startingPoint{
    buttonScrollView.userInteractionEnabled = NO;
    CustomButton *theButton = sender;
    originalButtonPoint = theButton.center;
    [theButton removeFromSuperview];
    [self.view addSubview:theButton];
    theButton.center = startingPoint;
}

-(void)buttonDidLetGo:(id)sender{
    CustomButton *theButton = sender;
    if(CGRectIntersectsRect(theButton.frame, graphScrollView.frame)){
        [theButton buttonPressed];
    }
    [theButton removeFromSuperview];
    [buttonScrollView addSubview:theButton];
    theButton.center = originalButtonPoint;
    buttonScrollView.userInteractionEnabled = YES;
}


#pragma mark - UITableView Delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}


-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if(buttonArray){
        return [buttonArray count];
    }
    return 0;
}


-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    SideMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SideMenuTableViewCell"];
    
    if(cell == nil){
        NSArray *topLevelObjects = [[NSBundle mainBundle]loadNibNamed:@"SideMenuTableViewCell" owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    cell.titleLabel.text = [buttonArray objectAtIndex:indexPath.row];
    cell.selectedView.hidden = ![[selectedArray objectAtIndex:indexPath.row]boolValue];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


/*-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
 return nil;
 }*/


-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 66;
}


-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    if(selectedRow != NSNotFound){
        SideMenuTableViewCell *previousCell = (SideMenuTableViewCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedRow inSection:0]];
        previousCell.selectedView.hidden = !previousCell.selectedView.hidden;
        [selectedArray replaceObjectAtIndex:selectedRow withObject:[NSNumber numberWithBool:NO]];
    }
    SideMenuTableViewCell *cell = (SideMenuTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    selectedRow = indexPath.row;
    [self setTitleForNavigationBarWithDataType:cell.titleLabel.text];
    cell.selectedView.hidden = !cell.selectedView.hidden;
    [selectedArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
    [self sideBarButtonPressed];
}


#pragma mark - PopUpViewController Delegate Methods

-(void)optionSelected:(NSString *)optionSelected{
    if([optionSelected isEqualToString:@"Clear-All"]){
        NSArray *graphSubviews = [containerGraphView subviews];
        if([graphSubviews count] > 1){
            for(int i = 1; i < [graphSubviews count]; i++){
                if([[graphSubviews objectAtIndex:i] respondsToSelector:@selector(initWithImage:)]){
                    UIImageView *comparedImageView = [graphSubviews objectAtIndex:i];
                    [comparedImageView removeFromSuperview];
                }
            }
        }
        
        NSArray *scrollViewSubviews = [buttonScrollView subviews];
        if([scrollViewSubviews count] > 1){
            for(int i = 0; i < [scrollViewSubviews count]; i++){
                if([[scrollViewSubviews objectAtIndex:i] respondsToSelector:@selector(buttonPressed)]){
                    CustomButton *aButton = [scrollViewSubviews objectAtIndex:i];
                    if(aButton.isActive){
                        [aButton buttonPressed];
                    }
                }
            }
        }
    }
}


#pragma mark - UIScrollView Delegate Methods

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    NSLog(@"Zooming.");
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return containerGraphView;
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale{
    NSLog(@"Done zooming.");
}

@end
