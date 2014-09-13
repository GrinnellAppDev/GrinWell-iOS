//
//  RestoreViewController.m
//  GrinFit
//
//  Created by Lea Marolt on 9/13/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import "RestoreViewController.h"
#import <Parse/Parse.h>

@interface RestoreViewController ()

@end

@implementation RestoreViewController {
    PFUser *currentUser;
    NSArray *btnArray;
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
    
    btnArray = [NSArray arrayWithObjects:self.meditationBtn, self.readingBtn, self.listenBtn, self.playBtn, self.knittingBtn, self.otherBtn, nil];
    
    self.succeededLabel.textColor = [UIColor redColor];
    self.succeededLabel.text = @"NAY!";
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

- (IBAction)back:(id)sender {
    
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)selectButton:(id)sender {
    
    [sender setSelected:YES];
    int ignore = [btnArray indexOfObject:sender];
    
    for (int i = 0; i < [btnArray count]; i++) {
        if (i != ignore) {
            [(UIButton*)btnArray[i] setSelected:NO];
            [(UIButton*)btnArray[i] setEnabled:NO];
        }
    }
    
    self.succeededLabel.text = @"YAY";
    self.succeededLabel.textColor = [UIColor greenColor];
}

- (IBAction)listen:(id)sender {
}
@end
