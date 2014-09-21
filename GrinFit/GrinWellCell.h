//
//  GrinWellCell.h
//  GrinFit
//
//  Created by Lea Marolt on 9/20/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KILabel.h"

@interface GrinWellCell : UITableViewCell

// OUTLETS
@property (weak, nonatomic) IBOutlet KILabel *contentLabel;
@property (weak, nonatomic) IBOutlet KILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end
