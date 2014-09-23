//
//  SleepViewController.m
//  GrinFit
//
//  Created by Lea Marolt on 9/11/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import "SleepViewController.h"
#import <Parse/Parse.h>

@interface SleepViewController ()

@end

@implementation SleepViewController {
    NSString *fellAsleep;
    NSString *wokeUp;
    
    int fellAsleepHour;
    int wokeUpHour;
    
    NSArray *pickerData;
    BOOL sleepSelected;
    
    NSUserDefaults *userDefaults;
    
    int militaryTimeSleepHour;
    int militaryTimeWakeHour;
    
    int sleepMinutes;
    int wakeMinutes;
    
    int totalHours;
    int totalMinutes;
    
    NSString *wokeUpText;
    NSString *fellAsleepText;
    
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
    
    currentUser = [PFUser currentUser];
        
    pickerData = @[
                    @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12],
                    @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, @21, @22, @23, @24, @25, @26, @27, @28, @29, @30, @31, @32, @33, @34, @35, @36, @37, @38, @39, @40, @41, @42, @43, @44, @45, @46, @47, @48, @49, @50, @51, @52, @53, @54, @55, @56, @57, @58, @59],
                    @[@"AM", @"PM"]
                    ];
    
    self.hourPicker.hidden = YES;
    
    UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)]; 
    self.fellAsleepField.inputView = dummyView;
    self.wokeUpField.inputView = dummyView;
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    if ([userDefaults integerForKey:@"sleepHours"]|| [userDefaults integerForKey:@"sleepMinutes"]) {
        
        
        self.fellAsleepField.enabled = NO;
        self.wokeUpField.enabled = NO;
        
        totalHours = [userDefaults integerForKey:@"sleepHours"];
        totalMinutes = [userDefaults integerForKey:@"sleepMinutes"];
        
        self.sleepTimeLabel.text = [NSString stringWithFormat:@"You slept for: %i hours and %i minutes!", totalHours, totalMinutes];
        
        self.fellAsleepField.text = [userDefaults objectForKey:@"fellAsleepString"];
        self.wokeUpField.text = [userDefaults objectForKey:@"wokeUpString"];
        
        [self updateLabel];
        
        float sleep = (([userDefaults integerForKey:@"sleepHours"] * 60) + [userDefaults integerForKey:@"sleepMinutes"]) / 60;
        
        NSNumber *sleepNum = [NSNumber numberWithFloat:sleep];
        
        PFQuery *dateQuery = [PFQuery queryWithClassName:@"Dates"];
        [dateQuery whereKey:@"createdBy" equalTo:currentUser.objectId];
        dateQuery.limit = 1;
        [dateQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                object[@"Sleep"] = sleepNum;
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (error) {
                        NSLog(@"wompwomp");
                    }
                    else {
                        NSLog(@"SLEEP: Saved!");
                    };
                }];
            }
        }];
        
    }
    else {
        totalMinutes = 0;
        totalHours = 0;
        
        self.sleepTimeLabel.text = @"";
    }
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // get rid of keyboard when you touch anywhere on the screen
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    self.hourPicker.hidden = NO;
    
    fellAsleep = self.fellAsleepField.text;
    wokeUp = self.wokeUpField.text;
    
    wokeUpHour = [wokeUp intValue];
    fellAsleepHour = [fellAsleep intValue];
    
    return NO;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.fellAsleepField) {
        [self.hourPicker selectRow:9 inComponent:0 animated:YES];
        [self.hourPicker selectRow:29 inComponent:1 animated:YES];
        [self.hourPicker selectRow:1 inComponent:2 animated:YES];
        sleepSelected = YES;
    }
    
    else {
        [self.hourPicker selectRow:7 inComponent:0 animated:YES];
        [self.hourPicker selectRow:29 inComponent:1 animated:YES];
        [self.hourPicker selectRow:0 inComponent:2 animated:YES];
        sleepSelected = NO;
    }
    self.hourPicker.hidden = NO;
    return YES;  // Hide both keyboard and blinking cursor.
}


- (IBAction)back:(id)sender {
    
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)done:(id)sender {
    
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *rowString = [NSString stringWithFormat:@"%@", pickerData[component][row]];
    return rowString;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 12;
    }
    else if (component == 1) {
        return 59;
    }
    else {
        return 2;
    }

}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSNumber *hour = pickerData[0][[self.hourPicker selectedRowInComponent:0]];
    NSNumber *minute = pickerData[1][[self.hourPicker selectedRowInComponent:1]];
    NSString *timeOfDay = pickerData[2][[self.hourPicker selectedRowInComponent:2]];
    
    
    if (sleepSelected) {
        self.fellAsleepField.text = [NSString stringWithFormat:@"%@:%@ %@", hour, minute, timeOfDay];
        fellAsleepText = [NSString stringWithFormat:@"%@:%@ %@", hour, minute, timeOfDay];
        
        NSLog(@"UP - Fell asleep text: %@", fellAsleepText);
        
        if ([timeOfDay isEqual:@"PM"]) {
            militaryTimeSleepHour = [hour intValue] + 12;
        }
        else {
            militaryTimeSleepHour = [hour intValue];
        }
        
        sleepMinutes = [minute intValue];
        [userDefaults setObject:fellAsleepText forKey:@"fellAsleepString"];
    }
    else {
        self.wokeUpField.text = [NSString stringWithFormat:@"%@:%@ %@", hour, minute, timeOfDay];
        wokeUpText = [NSString stringWithFormat:@"%@:%@ %@", hour, minute, timeOfDay];
        
        NSLog(@"UP - Woke up text: %@", wokeUpText);
        
        if ([timeOfDay isEqual:@"PM"]) {
            militaryTimeWakeHour = [hour intValue] + 12;
        }
        else {
            militaryTimeWakeHour = [hour intValue];
        }
        
        wakeMinutes = [minute intValue];
        
        [userDefaults setObject:wokeUpText forKey:@"wokeUpString"];
        [self updateLabel];
        
    }
    
}

- (void) updateLabel {
    
        if (militaryTimeSleepHour < militaryTimeWakeHour) {
            totalHours = militaryTimeWakeHour - militaryTimeSleepHour;
        }
    
        else {
            totalHours = 24 - militaryTimeSleepHour + militaryTimeWakeHour;
        }
    
        if (sleepMinutes < wakeMinutes) {
            totalMinutes = wakeMinutes - sleepMinutes;
        }
        else {
            totalMinutes = 60 - sleepMinutes + wakeMinutes;
        }
    
    if (![userDefaults objectForKey:@"sleepHours"] || ![userDefaults objectForKey:@"sleepMinutes"]) {
        [userDefaults setInteger:totalHours forKey:@"sleepHours"];
        [userDefaults setInteger:totalMinutes forKey:@"sleepMinutes"];
        
        self.sleepTimeLabel.text = [NSString stringWithFormat:@"You slept for: %i hours and %i minutes!", totalHours, totalMinutes];
        
        PFQuery *dateQuery = [PFQuery queryWithClassName:@"Dates"];
        [dateQuery whereKey:@"createdBy" equalTo:currentUser.objectId];
        dateQuery.limit = 1;
        [dateQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                
                float sleep = (([userDefaults integerForKey:@"sleepHours"] * 60) + [userDefaults integerForKey:@"sleepMinutes"]) / 60;
                
                NSNumber *sleepNum = [NSNumber numberWithFloat:sleep];
                
                object[@"Sleep"] = sleepNum;
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (error) {
                        NSLog(@"wompwomp");
                    }
                    else {
                        NSLog(@"SLEEP: Saved!");
                    };
                }];
            }
        }];
    }
    
    else {
        self.sleepTimeLabel.text = [NSString stringWithFormat:@"You slept for: %i hours and %i minutes!", [userDefaults integerForKey:@"sleepHours"], [userDefaults integerForKey:@"sleepMinutes"]];
        
        PFQuery *dateQuery = [PFQuery queryWithClassName:@"Dates"];
        [dateQuery whereKey:@"createdBy" equalTo:currentUser.objectId];
        dateQuery.limit = 1;
        [dateQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                
                float sleep = (([userDefaults integerForKey:@"sleepHours"] * 60) + [userDefaults integerForKey:@"sleepMinutes"]) / 60;
                
                NSNumber *sleepNum = [NSNumber numberWithFloat:sleep];
                
                object[@"Sleep"] = sleepNum;
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (error) {
                        NSLog(@"wompwomp");
                    }
                    else {
                        NSLog(@"SLEEP: Saved!");
                    };
                }];
            }
        }];
    }
    
}


@end
