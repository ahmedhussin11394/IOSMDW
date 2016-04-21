//
//  NetworkDelegate.h
//  AFNetworkingTest
//
//  Created by JETS on 4/4/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@protocol NetworkDelegate <NSObject>
@optional
- (void)dataRecived:(NSMutableArray *) data;
- (void)setUser:(User *) user;
@end
