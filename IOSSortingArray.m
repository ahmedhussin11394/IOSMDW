//
//  IOSSortingArray.m
//  DBProject
//
//  Created by JETS on 5/3/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "IOSSortingArray.h"

@implementation IOSSortingArray



-(NSMutableArray *)sortingArray:(NSMutableArray *)data key:(NSString *)key endDate:(NSString*) key1{
    
    NSSortDescriptor *desc = [NSSortDescriptor sortDescriptorWithKey:key ascending:YES];
    NSSortDescriptor *desc1 = [NSSortDescriptor sortDescriptorWithKey:key1 ascending:YES];
    NSMutableArray *result = [[data sortedArrayUsingDescriptors:@[desc,desc1]] mutableCopy];
    return result;
}

@end
