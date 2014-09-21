//
//  NotificationsViewController.h
//  GrinFit
//
//  Created by Lea Marolt on 9/20/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// OUTLETS
@property (weak, nonatomic) IBOutlet UITableView *theTableView;

// ACTIONS
- (IBAction)back:(id)sender;

@end
