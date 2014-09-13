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
    
    if (true) { // today's date
        [userDefaults setInteger:0 forKey:@"veggiesToday"];
        [userDefaults setInteger:0 forKey:@"fruitToday"];
    }
    else {
        
    }
    
    veggies = [userDefaults integerForKey:@"veggiesToday"];
    fruit = [userDefaults integerForKey:@"fruitToday"];
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

- (void) viewDidDisappear:(BOOL)animated {
    [userDefaults setInteger:veggies forKey:@"veggiesToday"];
    [userDefaults setInteger:fruit forKey:@"fruitToday"];
}

- (IBAction)plusFruit:(id)sender {
    fruit++;
    self.fruitLabel.text = [NSString stringWithFormat:@"Fruit: %i", fruit];
    
    if (fruit + veggies < 5) {
        self.amountSucceeded.textColor = [UIColor redColor];
    }
    else {
        self.amountSucceeded.textColor = [UIColor greenColor];
    }
    self.amountSucceeded.text = [NSString stringWithFormat:@"%i/5", fruit + veggies];
}

- (IBAction)plusVeggie:(id)sender {
    veggies++;
    self.veggieLabel.text = [NSString stringWithFormat:@"Vegetable: %i", veggies];
    
    if (fruit + veggies < 5) {
        self.amountSucceeded.textColor = [UIColor redColor];
    }
    else {
        self.amountSucceeded.textColor = [UIColor greenColor];
    }
    self.amountSucceeded.text = [NSString stringWithFormat:@"%i/5", fruit + veggies];
}

- (IBAction)back:(id)sender {
    
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
