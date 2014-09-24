//
//  StatsViewController.h
//  GrinFit
//
//  Created by Lea Marolt on 9/13/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatsViewController : UIViewController

// OUTLETS
@property (weak, nonatomic) IBOutlet UILabel *move;
@property (weak, nonatomic) IBOutlet UILabel *eat;
@property (weak, nonatomic) IBOutlet UILabel *sleep;
@property (weak, nonatomic) IBOutlet UILabel *restore;
@property (weak, nonatomic) IBOutlet UILabel *moveRK;
@property (weak, nonatomic) IBOutlet UILabel *eatRK;
@property (weak, nonatomic) IBOutlet UILabel *sleepRK;
@property (weak, nonatomic) IBOutlet UILabel *restoreRK;
@property (weak, nonatomic) IBOutlet UILabel *username;

// ACTIONS
- (IBAction)back:(id)sender;


@end
