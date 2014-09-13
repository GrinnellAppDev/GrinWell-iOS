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
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;

// ACTIONS
- (IBAction)back:(id)sender;
- (IBAction)selectButton:(id)sender;



@end
