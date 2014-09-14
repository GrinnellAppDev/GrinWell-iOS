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
    NSArray *BGArray;
    NSArray *colorSet;
    NSArray *textColorSet;
    NSMutableArray *selectedArray;
    NSUserDefaults *userDefaults;
    int ignore;
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
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    btnArray = [NSArray arrayWithObjects:self.meditationBtn, self.readingBtn, self.listenBtn, self.playBtn, self.knittingBtn, self.otherBtn, nil];
    BGArray = [NSArray arrayWithObjects:self.BG0, self.BG1, self.BG2, self.BG3, self.BG4, self.BG5, nil];
    colorSet = [NSArray arrayWithObjects:[UIColor colorWithRed:147.0/255.0 green:70.0/255.0 blue:63.0/255.0 alpha:1.0], [UIColor colorWithRed:195.0/255.0 green:93.0/255.0 blue:83.0/255.0 alpha:1.0], [UIColor colorWithRed:225.0/255.0 green:113.0/255.0 blue:102.0/255.0 alpha:1.0], [UIColor colorWithRed:240.0/255.0 green:138.0/255.0 blue:128.0/255.0 alpha:1.0], [UIColor colorWithRed:247.0/255.0 green:171.0/255.0 blue:164.0/255.0 alpha:1.0], [UIColor colorWithRed:255.0/255.0 green:207.0/255.0 blue:203.0/255.0 alpha:1.0], nil];
    textColorSet = [NSArray arrayWithObjects:[UIColor colorWithRed:255.0/255.0 green:207.0/255.0 blue:203.0/255.0 alpha:1.0], [UIColor colorWithRed:247.0/255.0 green:171.0/255.0 blue:164.0/255.0 alpha:1.0], [UIColor colorWithRed:240.0/255.0 green:138.0/255.0 blue:128.0/255.0 alpha:1.0], [UIColor colorWithRed:225.0/255.0 green:113.0/255.0 blue:102.0/255.0 alpha:1.0], [UIColor colorWithRed:195.0/255.0 green:93.0/255.0 blue:83.0/255.0 alpha:1.0], [UIColor colorWithRed:147.0/255.0 green:70.0/255.0 blue:63.0/255.0 alpha:1.0], nil];
    
    //self.succeededLabel.textColor = [UIColor redColor];
    //self.succeededLabel.text = @"NAY!";
    
    selectedArray = [NSMutableArray new];
    
    if ([userDefaults boolForKey:@"selectedSet"]) {
        if ([userDefaults objectForKey:@"selectedButtons"]) {
            selectedArray = [userDefaults objectForKey:@"selectedButtons"];
        }
        [self selectedSet];
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

- (IBAction)back:(id)sender {
    
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)selectButton:(id)sender {
    
    //[sender setSelected:YES];
    ignore = [btnArray indexOfObject:sender];
    
    [selectedArray addObject:[NSNumber numberWithInt:ignore]];
    
    //[(UIButton*)sender setSelected:YES];
    UIButton *myBtn = (UIButton*)sender;
    myBtn.titleLabel.textColor = textColorSet[ignore];
    [BGArray[ignore] setBackgroundColor:colorSet[ignore]];
    
    [userDefaults setBool:YES forKey:@"selectedSet"];
    [userDefaults setObject:selectedArray forKey:@"selectedButtons"];
}

- (void) selectedSet {
    for (int i = 0; i < [selectedArray count]; i++) {
        int selectedNum = [selectedArray[i] intValue];
        UIButton *currentBtn = (UIButton*)btnArray[selectedNum];
        currentBtn.titleLabel.textColor = textColorSet[selectedNum];
        [BGArray[selectedNum] setBackgroundColor:colorSet[selectedNum]];
        
        [(UIButton*)btnArray[selectedNum] setEnabled:NO];
    }

    //self.succeededLabel.text = @"YAY";
    //self.succeededLabel.textColor = [UIColor greenColor];
}
@end
