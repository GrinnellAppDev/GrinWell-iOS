//
//  StatsViewController.m
//  GrinFit
//
//  Created by Lea Marolt on 9/13/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import "StatsViewController.h"
#import <Parse/Parse.h>
#import "UIViewController+ECSlidingViewController.h"
#import "PNChart.h"

@interface StatsViewController ()

@end

@implementation StatsViewController {
    PFUser *currentUser;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    currentUser = [PFUser currentUser];
    
    NSString *username = currentUser[@"username"];
    NSArray* items = [username componentsSeparatedByString:@"@"];
    
    self.username.text = [NSString stringWithFormat:@"#%@", items[0]];
    
    currentUser = [PFUser currentUser];
    [self configureECSlidingController];

    [self chartMyStats];
}

- (void) viewWillAppear:(BOOL)animated {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - ECSLIDING

- (void)configureECSlidingController {
    // setup swipe and button gestures for the sliding view controller
    //self.slidingViewController.topViewControllerStoryboardId = @"GuideViewController";
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
    self.slidingViewController.customAnchoredGestures = @[];
    
    // TO DO: Swipe to the right to reveal menu
}

- (void) chartMyStats {
    //For LineChart
    
    // YOUR LINE CHART
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(-30, 135.0, 380, 180.0)];
    [lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    
    // MOVE
    NSArray * data01Array = @[@30, @45, @30, @60, @15];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = [UIColor colorWithRed:176.0/255.0 green:233.0/255.0 blue:119.0/255.0 alpha:1];
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // EAT
    NSArray * data02Array = @[@24, @42, @30, @12, @48];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = [UIColor colorWithRed:240.0/255.0 green:229.0/255.0 blue:128.0/255.0 alpha:1];
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };

    // SLEEP
    NSArray * data03Array = @[@34, @51, @18, @51, @44];
    PNLineChartData *data03 = [PNLineChartData new];
    data03.color = [UIColor colorWithRed:120.0/255.0 green:216.0/255.0 blue:239.0/255.0 alpha:1];
    data03.itemCount = lineChart.xLabels.count;
    data03.getData = ^(NSUInteger index) {
        CGFloat yValue = [data03Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // RESTORE
    NSArray * data04Array = @[@50, @0, @0, @50, @0];
    PNLineChartData *data04 = [PNLineChartData new];
    data04.color = [UIColor colorWithRed:240.0/255.0 green:138.0/255.0 blue:128.0/255.0 alpha:1];
    data04.itemCount = lineChart.xLabels.count;
    data04.getData = ^(NSUInteger index) {
        CGFloat yValue = [data04Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01, data02, data03, data04];
    
    
    lineChart.delegate = self;

    [lineChart strokeChart];
    [self.view addSubview:lineChart];
    
    // KINGTON LINE CHART
    PNLineChart * lineChartRK = [[PNLineChart alloc] initWithFrame:CGRectMake(-30, 370.0, 380, 180.0)];
    [lineChartRK setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    
    // MOVE
    NSArray * data01ArrayRK = @[@120, @15, @30, @45, @180];
    PNLineChartData *data01RK = [PNLineChartData new];
    data01RK.color = [UIColor colorWithRed:176.0/255.0 green:233.0/255.0 blue:119.0/255.0 alpha:1];
    data01RK.itemCount = lineChartRK.xLabels.count;
    data01RK.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01ArrayRK[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // EAT
    NSArray * data02ArrayRK = @[@4, @7, @5, @2, @8];
    PNLineChartData *data02RK = [PNLineChartData new];
    data02RK.color = [UIColor colorWithRed:240.0/255.0 green:229.0/255.0 blue:128.0/255.0 alpha:1];
    data02RK.itemCount = lineChartRK.xLabels.count;
    data02RK.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02ArrayRK[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // SLEEP
    NSArray * data03ArrayRK = @[@8, @7, @4, @7, @6];
    PNLineChartData *data03RK = [PNLineChartData new];
    data03RK.color = [UIColor colorWithRed:120.0/255.0 green:216.0/255.0 blue:239.0/255.0 alpha:1];
    data03RK.itemCount = lineChart.xLabels.count;
    data03RK.getData = ^(NSUInteger index) {
        CGFloat yValue = [data03ArrayRK[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // RESTORE
    NSArray * data04ArrayRK = @[@100, @0, @0, @100, @0];
    PNLineChartData *data04RK = [PNLineChartData new];
    data04RK.color = [UIColor colorWithRed:240.0/255.0 green:138.0/255.0 blue:128.0/255.0 alpha:1];
    data04RK.itemCount = lineChartRK.xLabels.count;
    data04RK.getData = ^(NSUInteger index) {
        CGFloat yValue = [data04ArrayRK[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChartRK.chartData = @[data01, data02, data03, data04];
    
    
    lineChartRK.delegate = self;
    
    [lineChartRK strokeChart];
    
    [self.view addSubview:lineChartRK];
    
    UIColor *bgColor = [UIColor colorWithRed:84.0/255.0 green:84.0/255.0 blue:84.0/255.0 alpha:1.0];
    
    CGRect maskBounds1 = CGRectMake(-30.0, 135.0, 30, 180);
    UIView *maskLine1 = [[UIView alloc] initWithFrame:maskBounds1];
    maskLine1.backgroundColor = bgColor;
    
    CGRect maskBounds2 = CGRectMake(-30.0, 370.0, 30, 180);
    UIView *maskLine2 = [[UIView alloc] initWithFrame:maskBounds2];
    maskLine2.backgroundColor = bgColor;
    
    [self.view insertSubview:maskLine1 aboveSubview:lineChart];
    [self.view insertSubview:maskLine2 aboveSubview:lineChartRK];

}

-(void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex andPointIndex:(NSInteger)pointIndex{
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}

-(void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}
@end
