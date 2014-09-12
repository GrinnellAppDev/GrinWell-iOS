//
//  SleepViewController.h
//  GrinFit
//
//  Created by Lea Marolt on 9/11/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SleepViewController : UIViewController

// OUTLETS
@property (weak, nonatomic) IBOutlet UITextField *fellAsleepField;
@property (weak, nonatomic) IBOutlet UITextField *wokeUpField;
@property (weak, nonatomic) IBOutlet UILabel *sleepTimeLabel;

@end
