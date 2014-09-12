//
//  WalkingViewController.m
//  GrinFit
//
//  Created by Lea Marolt on 9/11/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import "WalkingViewController.h"

@interface WalkingViewController ()

@end

@implementation WalkingViewController {
    int walkingTime;
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
    
    walkingTime = 0;
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

- (IBAction)add15:(id)sender {
    walkingTime = walkingTime + 15;
    if (walkingTime < 60) {
        self.walkingTimeLabel.text = [NSString stringWithFormat:@"You've walked %i minutes today!", walkingTime];
    }
    else {
        self.walkingTimeLabel.text = [NSString stringWithFormat:@"You've walked %.02f hours today!", walkingTime * 1.0f /60];
    }
}

- (IBAction)add30:(id)sender {
    walkingTime = walkingTime + 30;
    
    if (walkingTime < 60) {
        self.walkingTimeLabel.text = [NSString stringWithFormat:@"You've walked %i minutes today!", walkingTime];
    }
    else {
        self.walkingTimeLabel.text = [NSString stringWithFormat:@"You've walked %.02f hours today!", walkingTime * 1.0f /60];
    }
}

- (IBAction)add1:(id)sender {
    walkingTime = walkingTime + 60;
    
    if (walkingTime < 60) {
        self.walkingTimeLabel.text = [NSString stringWithFormat:@"You've walked %i minutes today!", walkingTime];
    }
    else {
        self.walkingTimeLabel.text = [NSString stringWithFormat:@"You've walked %.02f hours today!", walkingTime * 1.0f /60];
    }
}

- (IBAction)add2:(id)sender {
    walkingTime = walkingTime + 120;
    
    if (walkingTime < 60) {
        self.walkingTimeLabel.text = [NSString stringWithFormat:@"You've walked %i minutes today!", walkingTime];
    }
    else {
        self.walkingTimeLabel.text = [NSString stringWithFormat:@"You've walked %.02f hours today!", walkingTime * 1.0f /60];
    }
}
@end
