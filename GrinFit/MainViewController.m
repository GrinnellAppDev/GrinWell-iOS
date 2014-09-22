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
    int move;
    int eat;
    int sleep;
    BOOL restore;
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
    
    self.movementCrown.hidden = YES;
    self.restoreCrown.hidden = YES;
    self.sleepCrown.hidden = YES;
    self.eatCrown.hidden = YES;
    
    // parse object
    // CREATE THE STATS OBJECT
    
    [self newDayStats];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];

    [self.navigationItem setHidesBackButton:YES];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self circularizeButtons];
    [self changeBtns];
    [self updateKingtonsStats];
}

- (void) viewDidLayoutSubviews {

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
        if (move < [userDefaults integerForKey:@"dailyMovement"]) {
            self.movementCrown.hidden = NO;
        }
    }
    
    if ((([userDefaults integerForKey:@"sleepHours"] * 60) + [userDefaults integerForKey:@"sleepMinutes"]) >= 480) {
        self.sleepBtn.titleLabel.textColor = [UIColor greenColor];
        self.sleepBtn.backgroundColor = [UIColor colorWithRed:120.0/255.0 green:216.0/255.0 blue:239.0/255.0 alpha:1.0];
        
        if (sleep < [userDefaults integerForKey:@"sleepHours"]) {
            self.sleepCrown.hidden = NO;
        }
    }
    
    if (([userDefaults integerForKey:@"veggiesToday"] + [userDefaults integerForKey:@"fruitToday"]) >= 5) {
        self.eatBtn.titleLabel.textColor = [UIColor greenColor];
        self.eatBtn.backgroundColor = [UIColor colorWithRed:176.0/255.0 green:233.0/255.0 blue:119.0/255.0 alpha:1.0];
        
        if (eat < ([userDefaults integerForKey:@"veggiesToday"] + [userDefaults integerForKey:@"fruitToday"])) {
            self.eatCrown.hidden = NO;
        }
    }
    
    if ([userDefaults boolForKey:@"selectedSet"]) {
        self.restoreBtn.titleLabel.textColor = [UIColor greenColor];
        self.restoreBtn.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:138.0/255.0 blue:128.0/255.0 alpha:1.0];
        
        if (restore && ![userDefaults boolForKey:@"selectedSet"]) {
            self.restoreCrown.hidden = NO;
        }
    }
}

- (void) newDayStats {
    
    NSDate *thisDay = [NSDate date];
    
    statsToday = [PFObject objectWithClassName:@"Dates"];
    PFQuery *dateQuery = [PFQuery queryWithClassName:@"Dates"];
    [dateQuery whereKey:@"createdBy" equalTo:currentUser.objectId];
    PFObject *lastDate = [dateQuery getFirstObject];
    lastDate[@"createdBy"] = currentUser.objectId;
    
    NSLog(@"what is the first object?: %@", lastDate);
    NSLog(@"What is the date of the first object? %@", lastDate[@"Date"]);
    NSLog(@"What is the current date? %@", thisDay);
    
    if ([self compareDate:lastDate[@"Date"] toDate:thisDay] == 1) {
        statsToday = lastDate;
        NSLog(@"I AM NOT CREATING A NEW DATE!");
    }
    
    else {
        NSLog(@"I AM CREATING A NEW DATE...");
    
        statsToday[@"createdBy"] = currentUser.objectId;
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
    
    UIStoryboard *initialStoryboard = [UIStoryboard storyboardWithName:@"SignUp" bundle:nil];
    UIViewController *slideViewController = [initialStoryboard instantiateInitialViewController];
    [self presentViewController:slideViewController animated:NO completion:nil];

}

#pragma mark - ECSLIDING

- (void)configureECSlidingController {
    // setup swipe and button gestures for the sliding view controller
    //self.slidingViewController.topViewControllerStoryboardId = @"MainViewController";
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
    self.slidingViewController.customAnchoredGestures = @[];
    
    // TO DO: Swipe to the right to reveal menu
}

- (int) compareDate:(NSDate *)date1 toDate: (NSDate *)date2 {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comp1 = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit) fromDate:date1];
    NSDateComponents *comp2 = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit) fromDate:date2];
    
    NSLog(@"THE COMPONENTS: %@ %@", comp1, comp2);
    
    if ((comp1.day == comp2.day) && (comp1.month == comp2.month)) {
            NSLog(@"the dates are the same!!!");
        return 1;
    }
    else {
        NSLog(@"THEY AINT THE SAME!");
        return 0;
    }
}

- (void) updateKingtonsStats {
    PFObject *kington = [PFObject objectWithClassName:@"Dates"];
    PFQuery *kingtonQuery = [PFQuery queryWithClassName:@"Dates"];
    [kingtonQuery whereKey:@"createdBy" equalTo:@"EvFCcNYqRu"];
    kington = [kingtonQuery getFirstObject];
    
    NSLog(@"kington object: %@", kington);
    
    if (kington) {
        self.moveRK.text = [NSString stringWithFormat:@"%@/30min", kington[@"MovementAmount"]];
        self.eatRK.text = [NSString stringWithFormat:@"%@/5", kington[@"FruitsAndVegetables"]];
        self.sleepRK.text = [NSString stringWithFormat:@"%@/8hrs", kington[@"Sleep"]];
        if ([kington[@"WellnessActivity"] boolValue]) {
            self.restoreRK.text = @"Complete";
        }
    }
    
    NSLog(@"what is the movement amount? %@", kington[@"MovementAmount"]);
    NSNumber *moveNS = kington[@"MovementAmount"];
    move = [moveNS intValue];
    
    NSNumber *eatNS = kington[@"FruitsAndVegetables"];
    eat = [eatNS intValue];
    
    NSNumber *sleepNS = kington[@"Sleep"];
    sleep = [sleepNS intValue];
    
    restore = [kington[@"WellnessActivity"] boolValue];
    
    if (move >= 30) {
        self.moveBgRK.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:229.0/255.0 blue:128.0/255.0 alpha:1.0];
    }
    
    if (eat >= 5) {
        self.eatBgRK.backgroundColor = [UIColor colorWithRed:176.0/255.0 green:233.0/255.0 blue:119.0/255.0 alpha:1.0];
    }
    
    if (sleep >= 8) {
        self.sleepBgRK.backgroundColor = [UIColor colorWithRed:120.0/255.0 green:216.0/255.0 blue:239.0/255.0 alpha:1.0];
    }
    
    if (restore) {
        self.restoreBgRK.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:138.0/255.0 blue:128.0/255.0 alpha:1.0];
    }
}

@end
