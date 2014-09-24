//
//  AboutAppDevViewController.h
//  GrinFit
//
//  Created by Lea Marolt on 9/23/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface AboutAppDevViewController : UIViewController <SKStoreProductViewControllerDelegate, MFMailComposeViewControllerDelegate>

- (IBAction)contactUs:(id)sender;
- (IBAction)rateOurApp:(id)sender;

@end
