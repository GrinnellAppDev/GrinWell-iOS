//
//  NotificationsViewController.m
//  GrinFit
//
//  Created by Lea Marolt on 9/20/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import "NotificationsViewController.h"
#import <STTwitter/STTwitter.h>
#import "GrinWellCell.h"
#import "KILabel.h"
#import "Tweet.h"
#import "MZFormSheetController.h"

@interface NotificationsViewController ()

@end

@implementation NotificationsViewController {
    NSMutableArray *twitterStatuses;
    NSArray *sortedStatuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    MZFormSheetController *controller = self.formSheetController;
    
    controller.formSheetWindow.transparentTouchEnabled = YES;
    
    controller.presentedFormSheetSize = CGSizeMake(300, 380);
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    twitterStatuses = [NSMutableArray new];
    
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"vQCJweqLOcyuor6tYMwIIKmkv"
                                                            consumerSecret:@"EVybr7JmFpBbBViFZfh3GIDNlITJxhGfZVcvq4ysPaljtXj0WQ"];
    
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
        
        [twitter getUserTimelineWithScreenName:@"GrinWellPWC"
                                  successBlock:^(NSArray *statuses) {
                                      
                                     // NSLog(@"STATUSES: %@", statuses);
                                      for (int i = 0; i < [statuses count]; i++) {
                                          Tweet *tweet = [Tweet new];
                                          tweet.content = [statuses[i] valueForKey:@"text"];
                                          tweet.user = [NSString stringWithFormat:@"@%@", [[statuses[i] valueForKey:@"user"] valueForKey:@"screen_name"]];
                                          
                                          // TRANSFORM STRING TO DATE
                                          
                                          NSError *error = nil;
                                          NSDataDetector *dateDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate
                                                                                                         error:&error];
                                          
                                          NSString *string = [statuses[i] valueForKey:@"created_at"];
                                                              
                                          [dateDetector enumerateMatchesInString:string
                                                                         options:kNilOptions
                                                                           range:NSMakeRange(0, [string length])
                                                                      usingBlock:
                                           ^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                               NSLog(@"Match: %@", result);
                                               NSLog(@"DATE: %@", [result date]);
                                               
                                               NSDateFormatter *distanceFormatter = [NSDateFormatter new];
                                               [distanceFormatter setDateFormat:@"MMM dd"];
                                               tweet.time = [result date];
                                               
                                               [twitterStatuses addObject:tweet];
                                               
                                               }];
                                       
                                      }
                                      
                                      sortedStatuses = [twitterStatuses sortedArrayUsingComparator:^NSComparisonResult(Tweet *t1, Tweet *t2){
                                          
                                          return [t2.time compare:t1.time];
                                          
                                      }];
                                      NSLog(@"sorted array 1: %@", sortedStatuses);
                                      
                                      [self.theTableView reloadData];
                                      
                                      
                                  } errorBlock:^(NSError *error) {
                                      // ...
                                  }];
        
        } errorBlock:^(NSError *error) {
            // ...
        }];
    
        [twitter verifyCredentialsWithSuccessBlock:^(NSString *username)
         
         {
             [twitter getSearchTweetsWithQuery:@"#GrinWell"
                            successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
                                
                                NSLog(@"search metadata: %@ & STATUSES: %@", searchMetadata, statuses);
                                
                                for (int i = 0; i < [statuses count]; i++) {
                                    Tweet *tweet = [Tweet new];
                                    tweet.content = [statuses[i] valueForKey:@"text"];
                                    tweet.user = [NSString stringWithFormat:@"@%@", [[statuses[i] valueForKey:@"user"] valueForKey:@"screen_name"]];
                                    
                                    
                                    NSError *error = nil;
                                    NSDataDetector *dateDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate
                                                                                                   error:&error];
                                    
                                    NSString *string = [statuses[i] valueForKey:@"created_at"];
                                    
                                    [dateDetector enumerateMatchesInString:string
                                                                   options:kNilOptions
                                                                     range:NSMakeRange(0, [string length])
                                                                usingBlock:
                                     ^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                         NSLog(@"Match: %@", result);
                                         NSLog(@"DATE: %@", [result date]);
                                         
                                         NSDateFormatter *distanceFormatter = [NSDateFormatter new];
                                         [distanceFormatter setDateFormat:@"MMM dd"];
                                         tweet.time = [result date];
                                         
                                         [twitterStatuses addObject:tweet];
                                         
                                     }];
                                    
                                    sortedStatuses = [twitterStatuses sortedArrayUsingComparator:^NSComparisonResult(Tweet *t1, Tweet *t2){
                                        
                                        return [t2.time compare:t1.time];
                                        
                                    }];
                                    NSLog(@"sorted array 2: %@", sortedStatuses);
                                    
                                    [self.theTableView reloadData];
                                    
                                }
                                
            
                } errorBlock:^(NSError *error) {
                    NSLog(@"Error : %@",error.description);
                }];
             
         } errorBlock:^(NSError *error) {
             NSLog(@"-- error %@", error);
         }];

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

#pragma mark - tableview methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"GrinWellCell";
    GrinWellCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSLog(@"IN MY TWEET IS: %@", sortedStatuses[indexPath.row]);
    
    cell.contentLabel.text = [sortedStatuses[indexPath.row] content];
    cell.usernameLabel.text = [sortedStatuses[indexPath.row] user];
    

    // Dealing with URL clicking
    
    cell.contentLabel.linkTapHandler = ^(KILinkType linkType, NSString *string, NSRange range) {
        if ([string hasPrefix:@"#"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/hashtag/%@?src=hash", [string substringFromIndex:1]]]];
        }
        else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
        }
    };
    
    cell.usernameLabel.linkTapHandler = ^(KILinkType linkType, NSString *string, NSRange range) {
        if ([string hasPrefix:@"@"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/%@", string]]];
        }

    };
    
    // TRANSFORMING DATE INTO STRING
    
    NSDateFormatter *distanceFormatter = [NSDateFormatter new];
    [distanceFormatter setDateFormat:@"MMM dd"];
    NSString *createdAtString = [[distanceFormatter stringFromDate:[sortedStatuses[indexPath.row] time]] capitalizedString];
    
    NSString *completeCreatedAtString = [NSString stringWithFormat:@"%@", createdAtString];
    
    cell.timeLabel.text = completeCreatedAtString;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"STATUSES COUNT: %i", [twitterStatuses count]);
    return [twitterStatuses count];
}

- (IBAction)back:(id)sender {
        
    [[self navigationController] popViewControllerAnimated:YES];
    //[self loadAndPresentVCNamed:@"MainViewController" fromStoryboardNamed:@"Main"];
    
}

- (IBAction)dismiss:(id)sender {
    MZFormSheetController *controller = self.formSheetController;
    [controller mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
}

-(UIViewController*)loadAndPresentVCNamed:(NSString*)vcName
                      fromStoryboardNamed:(NSString*)sbName;
{
    // 1. Get the storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:sbName bundle:nil];
    
    // 2. Edit the vcName if necessary (optional)
    // If you don't have a separate items in your Storyboard w/ it's Storyboard ID
    // set to "<vcName>_iPhone", remove the next 2 lines.
    
    // 3. Get the controller from the storyboard.
    UIViewController *controller = (UIViewController *)
    [storyboard instantiateViewControllerWithIdentifier:vcName];
    
    // 4. Present the vc and return it.
    [self presentViewController:controller animated:YES completion:nil];
    return controller;
}
@end
