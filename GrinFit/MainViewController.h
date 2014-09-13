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

@end
