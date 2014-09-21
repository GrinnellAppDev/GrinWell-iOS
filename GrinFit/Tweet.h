//
//  Tweet.h
//  GrinFit
//
//  Created by Lea Marolt on 9/21/14.
//  Copyright (c) 2014 Grinnell AppDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSDate *time;

@end
