//
//  WalkingViewController.h
//  GrinFit
//
//  Created by Lea Marolt on 9/11/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalkingViewController : UIViewController

// OUTLETS
@property (weak, nonatomic) IBOutlet UILabel *walkingTimeLabel;


// METHODS
- (IBAction)add15:(id)sender;
- (IBAction)add30:(id)sender;
- (IBAction)add1:(id)sender;
- (IBAction)add2:(id)sender;

@end
