//
//  MainViewController.m
//  GrinFit
//
//  Created by Lea Marolt on 9/11/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import "MainViewController.h"
#import <Parse/Parse.h>
#import "UIViewController+ECSlidingViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController {
    PFUser *currentUser;
    NSDate *today;
    NSUserDefaults *userDefaults;
    PFObject *statsToday;
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
    userDefaults = [NSUserDefaults standardUserDefaults];
    [self configureECSlidingController];
    //[self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
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
    
    PFQuery *userQuery = [PFUser query];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (int i = 0; i < [objects count]; i++) {
            PFUser *user = objects[i];
            if ([user.objectId isEqual:@"EvFCcNYqRu"]) {
                NSLog(@"WE FOUND KINGTON!!");
            }
        }
    }];
    
    // CREATE THE STATS OBJECT
    statsToday = [PFObject objectWithClassName:@"Dates"];
    statsToday[@"createdBy"] = currentUser.objectId;
    
    self.movementCrown.hidden = YES;
    self.restoreCrown.hidden = YES;
    self.sleepCrown.hidden = YES;
    self.eatCrown.hidden = YES;
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];

    [self.navigationItem setHidesBackButton:YES];
    [self changeBtns];
    [self newDayStats];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self circularizeButtons];
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

- (void) changeBtns {
    
    // do whatever needs to be done to the buttons to indicate that the challenge has been completed!
    
    if ([userDefaults integerForKey:@"dailyMovement"] >= 30) {
        self.moveBtn.titleLabel.textColor = [UIColor greenColor];
        self.moveBtn.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:229.0/255.0 blue:128.0/255.0 alpha:1.0];
        self.movementCrown.hidden = NO;
    }
    
    if ((([userDefaults integerForKey:@"sleepHours"] * 60) + [userDefaults integerForKey:@"sleepMinutes"]) >= 480) {
        self.sleepBtn.titleLabel.textColor = [UIColor greenColor];
        self.sleepBtn.backgroundColor = [UIColor colorWithRed:120.0/255.0 green:216.0/255.0 blue:239.0/255.0 alpha:1.0];
    }
    
    if (([userDefaults integerForKey:@"veggiesToday"] + [userDefaults integerForKey:@"fruitToday"]) >= 5) {
        self.eatBtn.titleLabel.textColor = [UIColor greenColor];
        self.eatBtn.backgroundColor = [UIColor colorWithRed:176.0/255.0 green:233.0/255.0 blue:119.0/255.0 alpha:1.0];
        self.eatCrown.hidden = NO;
    }
    
    if ([userDefaults boolForKey:@"selectedSet"]) {
        self.restoreBtn.titleLabel.textColor = [UIColor greenColor];
        self.restoreBtn.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:138.0/255.0 blue:128.0/255.0 alpha:1.0];
    }
}

- (void) newDayStats {
    NSDate *thisDay = [NSDate date];
    statsToday[@"Date"] = thisDay;
    int veggies = [userDefaults integerForKey:@"veggiesToday"];
    int fruit = [userDefaults integerForKey:@"fruitToday"];
    
    NSNumber *fruitNVeggies = [NSNumber numberWithInt:veggies + fruit];
    statsToday[@"FruitsAndVegetables"] = fruitNVeggies;
    
    float sleep = (([userDefaults integerForKey:@"sleepHours"] * 60) + [userDefaults integerForKey:@"sleepMinutes"]) / 60;
    
    NSNumber *sleepNum = [NSNumber numberWithFloat:sleep];
    statsToday[@"Sleep"] = sleepNum;
    
    
    NSNumber *movementNum = [NSNumber numberWithInt:[userDefaults integerForKey:@"dailyMovement"]];
    statsToday[@"MovementAmount"] = movementNum;

    
    BOOL wellnessCompleted = [userDefaults boolForKey:@"selectedSet"];
    
    statsToday[@"WellnessActivity"] = [NSNumber numberWithBool:wellnessCompleted];
    
    [statsToday saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"MY OBJECT: %@", statsToday);
        }
    }];
}

- (void) circularizeButtons {
    self.eatBtn.layer.cornerRadius = 30;
    self.eatBtn.layer.masksToBounds = YES;
    
    self.moveBtn.layer.cornerRadius = 30;
    self.moveBtn.layer.masksToBounds = YES;
    
    self.restoreBtn.layer.cornerRadius = 30;
    self.restoreBtn.layer.masksToBounds = YES;
    
    self.sleepBtn.layer.cornerRadius = 30;
    self.sleepBtn.layer.masksToBounds = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (IBAction)logOut:(id)sender {
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    NSLog(@"WE ARE DOING STUFF.");
    [PFUser logOut];
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}

#pragma mark - ECSLIDING

- (void)configureECSlidingController {
    // setup swipe and button gestures for the sliding view controller
    //self.slidingViewController.topViewControllerStoryboardId = @"MainViewController";
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
    self.slidingViewController.customAnchoredGestures = @[];
    
    // TO DO: Swipe to the right to reveal menu
}

@end
