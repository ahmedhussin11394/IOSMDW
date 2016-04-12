//
//  NetworkClass.h
//  AFNetworkingTest
//
//  Created by JETS on 4/3/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDelegate.h"
#import "User.h"
@interface NetworkClass : NSObject
@property id<NetworkDelegate> myDelegate;
- (NSDictionary *)getSpeakers;
- (void)getSessions;
-(void)getExhiptors;
-(void)loginWithName:(NSString *)name andPassword:(NSString *)pass;
@end
