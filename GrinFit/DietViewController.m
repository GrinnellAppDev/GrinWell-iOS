//
//  DietViewController.m
//  GrinFit
//
//  Created by Lea Marolt on 9/11/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import "DietViewController.h"

@interface DietViewController ()

@end

@implementation DietViewController {
    int veggies;
    int fruit;
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
    
    veggies = 0;
    fruit = 0;
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

- (IBAction)plusFruit:(id)sender {
    fruit++;
    self.fruitLabel.text = [NSString stringWithFormat:@"Fruit: %i", fruit];
}

- (IBAction)plusVeggie:(id)sender {
    veggies++;
    self.veggieLabel.text = [NSString stringWithFormat:@"Vegetable: %i", veggies];
}

@end
