//
//  MainViewController.h
//  GrinFit
//
//  Created by Lea Marolt on 9/11/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

// OUTLETS
@property (weak, nonatomic) IBOutlet UILabel *currentDate;
@property (weak, nonatomic) IBOutlet UILabel *moveRK;
@property (weak, nonatomic) IBOutlet UILabel *eatRK;
@property (weak, nonatomic) IBOutlet UILabel *sleepRK;
@property (weak, nonatomic) IBOutlet UILabel *restoreRK;
@property (weak, nonatomic) IBOutlet UIButton *moveBtn;
@property (weak, nonatomic) IBOutlet UIButton *eatBtn;
@property (weak, nonatomic) IBOutlet UIButton *sleepBtn;
@property (weak, nonatomic) IBOutlet UIButton *restoreBtn;
@property (weak, nonatomic) IBOutlet UIImageView *eatCrown;
@property (weak, nonatomic) IBOutlet UIImageView *movementCrown;
@property (weak, nonatomic) IBOutlet UIImageView *restoreCrown;
@property (weak, nonatomic) IBOutlet UIImageView *sleepCrown;

// ACTIONS
- (IBAction)saveObj:(id)sender;

@end
