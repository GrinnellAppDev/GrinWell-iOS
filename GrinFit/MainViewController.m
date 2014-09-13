//
//  MainViewController.m
//  GrinFit
//
//  Created by Lea Marolt on 9/11/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import "MainViewController.h"
#import <Parse/Parse.h>

@interface MainViewController ()

@end

@implementation MainViewController {
    PFUser *currentUser;
    NSDate *today;
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
    
    today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd"];
    NSString *todayString = [dateFormatter stringFromDate:today];
    
    NSDate *parseDate;
    PFQuery *dateQuery = [PFUser query];
    [dateQuery whereKey:@"createdBy" equalTo:[currentUser objectId]];
    [dateQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // success
            
        }
        else {
            // we failed
        }
    }];
    
    self.currentDate.text = [todayString capitalizedString];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    NSLog(@"USER DEFAULTS: %ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"dailyMovement"]);

    [self.navigationItem setHidesBackButton:YES];
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

@end
