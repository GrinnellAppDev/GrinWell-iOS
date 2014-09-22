//
//  ExerciseViewController.m
//  GrinFit
//
//  Created by Lea Marolt on 9/11/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import "ExerciseViewController.h"
#import <Parse/Parse.h>

@interface ExerciseViewController ()

@end

@implementation ExerciseViewController {
    PFUser *currentUser;
    int totalMovement;
    NSUserDefaults *userDefaults;
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
        
    if (![userDefaults integerForKey:@"dailyMovement"]) { // if it's the next day
        [userDefaults setInteger:0 forKey:@"dailyMovement"];
    }
    else {
        // get the number from parse for total daily movement
    }

    totalMovement = [userDefaults integerForKey:@"dailyMovement"];
    [self updateLabel];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    
    [userDefaults setInteger:totalMovement forKey:@"dailyMovement"];
    
    PFQuery *dateQuery = [PFQuery queryWithClassName:@"Dates"];
    [dateQuery whereKey:@"createdBy" equalTo:currentUser.objectId];
    dateQuery.limit = 1;
    __block PFObject *lastDate = [PFObject objectWithClassName:@"Dates"];
    [dateQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        lastDate = object;
    }];
    
    NSNumber *movementNum = [NSNumber numberWithInt:[userDefaults integerForKey:@"dailyMovement"]];
    lastDate[@"MovementAmount"] = movementNum;
    
    lastDate[@"MovementAmount"] = movementNum;
    [lastDate saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            // NSLog(@"wompwomp");
        }
        else {
            // NSLog(@"MOVEMENT: Saved!");
        };
    }];
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
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit:(id)sender {
}

- (IBAction)add15:(id)sender {
    // NSLog(@"Pressed 15!");
    totalMovement = totalMovement + 15;
    
    [self updateLabel];
}

- (IBAction)add30:(id)sender {
    // NSLog(@"Pressed 30!");
    totalMovement = totalMovement + 30;
    
    [self updateLabel];
}

- (void) updateLabel {
    if (totalMovement < 60) {
        self.totalDailyHours.text = [NSString stringWithFormat:@"%i min", totalMovement];
    }
    else {
        self.totalDailyHours.text = [NSString stringWithFormat:@"%.02f hrs", totalMovement/60.0];
    }
}
@end
