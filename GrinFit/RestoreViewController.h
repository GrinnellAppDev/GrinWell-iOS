//
//  RestoreViewController.h
//  GrinFit
//
//  Created by Lea Marolt on 9/13/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestoreViewController : UIViewController

// OUTLETS
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *succeededLabel;
@property (weak, nonatomic) IBOutlet UIButton *meditationBtn;
@property (weak, nonatomic) IBOutlet UIButton *readingBtn;
@property (weak, nonatomic) IBOutlet UIButton *knittingBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *listenBtn;
@property (weak, nonatomic) IBOutlet UIButton *natureBtn;
@property (weak, nonatomic) IBOutlet UIView *BG0;
@property (weak, nonatomic) IBOutlet UIView *BG1;
@property (weak, nonatomic) IBOutlet UIView *BG2;
@property (weak, nonatomic) IBOutlet UIView *BG3;
@property (weak, nonatomic) IBOutlet UIView *BG4;
@property (weak, nonatomic) IBOutlet UIView *BG5;
@property (weak, nonatomic) IBOutlet UIButton *volunteerBtn;
@property (weak, nonatomic) IBOutlet UIButton *religionBtn;
@property (weak, nonatomic) IBOutlet UIButton *yogaBtn;
@property (weak, nonatomic) IBOutlet UIView *BG6;
@property (weak, nonatomic) IBOutlet UIView *BG7;
@property (weak, nonatomic) IBOutlet UIView *BG8;

// ACTIONS
- (IBAction)back:(id)sender;
- (IBAction)selectButton:(id)sender;



@end
