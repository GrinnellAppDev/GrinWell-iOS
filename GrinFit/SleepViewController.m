//
//  SleepViewController.m
//  GrinFit
//
//  Created by Lea Marolt on 9/11/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import "SleepViewController.h"

@interface SleepViewController ()

@end

@implementation SleepViewController {
    NSString *fellAsleep;
    NSString *wokeUp;
    
    int fellAsleepHour;
    int wokeUpHour;
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
    
    fellAsleep = self.fellAsleepField.text;
    wokeUp = self.wokeUpField.text;
    
    wokeUpHour = [wokeUp intValue];
    fellAsleepHour = [fellAsleep intValue];
    
    int totalSleep = 0;
    
    if (fellAsleepHour < wokeUpHour) {
        totalSleep = wokeUpHour - fellAsleepHour;
    }
    
    else {
        totalSleep = 24 - fellAsleepHour + wokeUpHour;
    }
    
    self.sleepTimeLabel.text = [NSString stringWithFormat:@"You slept for: %i hours!", totalSleep];
    
    return NO;
}


@end
