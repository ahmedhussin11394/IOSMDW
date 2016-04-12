//
//  NetworkManger.m
//  AFNetworkingTest
//
//  Created by JETS on 4/4/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "NetworkManger.h"
#import "NetworkClass.h"
@implementation NetworkManger

static NetworkClass * object = nil;

-(NetworkClass *)getNetworkInstance{
    if(object==nil){
        object=[NetworkClass new];
    }
    return object;
}

@end
