//
//  DietViewController.m
//  GrinFit
//
//  Created by Lea Marolt on 9/11/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import "DietViewController.h"
#import <Parse/Parse.h>

@interface DietViewController ()

@end

@implementation DietViewController {
    int veggies;
    int fruit;
    NSUserDefaults *userDefaults;
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
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![userDefaults integerForKey:@"veggiesToday"] || ![userDefaults integerForKey:@"fruitToday"]) { // today's date
        [userDefaults setInteger:0 forKey:@"veggiesToday"];
        [userDefaults setInteger:0 forKey:@"fruitToday"];
    }
    else {
        
    }
    
    veggies = [userDefaults integerForKey:@"veggiesToday"];
    self.veggieLabel.text = [NSString stringWithFormat:@"Vegetables: %i", veggies];
    fruit = [userDefaults integerForKey:@"fruitToday"];
    self.fruitLabel.text = [NSString stringWithFormat:@"Fruit: %i", fruit];
    
    currentUser = [PFUser currentUser];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void) viewDidLayoutSubviews {
    [self updateLabel];
    
    self.carrotBtn.layer.cornerRadius = 62;
    self.carrotBtn.layer.masksToBounds = YES;
    
    self.appleBtn.layer.cornerRadius = 62;
    self.appleBtn.layer.masksToBounds = YES;
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

- (void) viewDidDisappear:(BOOL)animated {
    [userDefaults setInteger:veggies forKey:@"veggiesToday"];
    [userDefaults setInteger:fruit forKey:@"fruitToday"];
    
    PFQuery *dateQuery = [PFQuery queryWithClassName:@"Dates"];
    [dateQuery whereKey:@"createdBy" equalTo:currentUser.objectId];
    dateQuery.limit = 1;
    __block PFObject *lastDate = [PFObject objectWithClassName:@"Dates"];
    [dateQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        lastDate = object;
    }];
    
    NSNumber *veggiesNFruits = [NSNumber numberWithInt:veggies + fruit];
    
    lastDate[@"FruitsAndVegetables"] = veggiesNFruits;
    [lastDate saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            // NSLog(@"wompwomp");
        }
        else {
           // NSLog(@"WE SAVED SUCCESSFULLLYYYY!!!");
        };
    }];
    
}

- (IBAction)plusFruit:(id)sender {
    fruit++;
    self.fruitLabel.text = [NSString stringWithFormat:@"Fruit: %i", fruit];
    
    [self updateLabel];
}

- (IBAction)plusVeggie:(id)sender {
    veggies++;
    self.veggieLabel.text = [NSString stringWithFormat:@"Vegetable: %i", veggies];
    
    [self updateLabel];
}

- (IBAction)back:(id)sender {
    
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void) updateLabel {
    if (fruit + veggies < 5) {
        //self.amountSucceeded.textColor = [UIColor redColor];
    }
    else {
        //self.amountSucceeded.textColor = [UIColor greenColor];
    }
    self.amountSucceeded.text = [NSString stringWithFormat:@"%i/5", fruit + veggies];
}

@end
