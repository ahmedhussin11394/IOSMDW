//
//  PhonesOfExhiptors.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/4/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exhiptors;

@interface PhonesOfExhiptors : NSManagedObject

@property (nonatomic, retain) NSString * phonenum;
@property (nonatomic, retain) Exhiptors *exhiptor;

@end
