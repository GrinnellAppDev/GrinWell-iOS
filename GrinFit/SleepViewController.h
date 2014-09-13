//
//  SleepViewController.h
//  GrinFit
//
//  Created by Lea Marolt on 9/11/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SleepViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

// OUTLETS
@property (weak, nonatomic) IBOutlet UITextField *fellAsleepField;
@property (weak, nonatomic) IBOutlet UITextField *wokeUpField;
@property (weak, nonatomic) IBOutlet UILabel *sleepTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIPickerView *hourPicker;

// ACTION
- (IBAction)back:(id)sender;
- (IBAction)done:(id)sender;


@end
