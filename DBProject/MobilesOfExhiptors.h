//
//  MobilesOfExhiptors.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/4/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exhiptors;

@interface MobilesOfExhiptors : NSManagedObject

@property (nonatomic, retain) NSString * mobilenum;
@property (nonatomic, retain) Exhiptors *exhiptor;

@end
