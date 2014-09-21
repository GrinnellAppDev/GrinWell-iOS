//
//  GuideViewController.m
//  GrinFit
//
//  Created by Lea Marolt on 9/21/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import "GuideViewController.h"
#import "UIViewController+ECSlidingViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureECSlidingController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - ECSLIDING

- (void)configureECSlidingController {
    // setup swipe and button gestures for the sliding view controller
    //self.slidingViewController.topViewControllerStoryboardId = @"GuideViewController";
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
    self.slidingViewController.customAnchoredGestures = @[];
    
    // TO DO: Swipe to the right to reveal menu
}

@end
