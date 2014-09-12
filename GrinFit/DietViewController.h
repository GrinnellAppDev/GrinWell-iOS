//
//  DietViewController.h
//  GrinFit
//
//  Created by Lea Marolt on 9/11/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DietViewController : UIViewController

// OUTLETS
@property (weak, nonatomic) IBOutlet UILabel *fruitLabel;
@property (weak, nonatomic) IBOutlet UILabel *veggieLabel;


// METHODS
- (IBAction)plusFruit:(id)sender;
- (IBAction)plusVeggie:(id)sender;

@end
