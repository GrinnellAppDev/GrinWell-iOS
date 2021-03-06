//
//  ExerciseViewController.h
//  GrinFit
//
//  Created by Lea Marolt on 9/11/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseViewController : UIViewController

// OUTLETS
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *totalDailyHours;

// ACTIONS
- (IBAction)back:(id)sender;
- (IBAction)submit:(id)sender;


@end
