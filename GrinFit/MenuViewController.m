//
//  MenuViewController.m
//  GrinFit
//
//  Created by Lea Marolt on 9/20/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import "MenuViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import <Parse/Parse.h>

@interface MenuViewController ()

@end

@implementation MenuViewController {
    PFUser *currentUser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.slidingViewController.anchorRightRevealAmount = 250.0;
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    currentUser = [PFUser currentUser];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)unwindToMenuViewController: (UIStoryboardSegue *) segue {
}

- (IBAction)logout:(id)sender {
    
    [PFUser logOut];
    // Load back the main. There might be the instance that it isn't there? Or should it always be there? Perhaps?
    [self.presentingViewController dismissViewControllerAnimated:NO completion:^{
        PFInstallation *installation = [PFInstallation currentInstallation];
        installation[@"owner"] = [NSNull null];
        [installation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Installation from logout saved");
            } else {
                NSLog(@"Not saved: %@", [error localizedDescription]);
            }
        }];
    }];
}
@end
