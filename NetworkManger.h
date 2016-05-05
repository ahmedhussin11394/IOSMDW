//
//  NetworkManger.h
//  AFNetworkingTest
//
//  Created by JETS on 4/4/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkClass.h"
@interface NetworkManger : NSObject
@property NetworkClass *object;
-(NetworkClass *)getNetworkInstance;
@end
