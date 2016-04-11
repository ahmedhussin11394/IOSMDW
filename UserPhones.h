//
//  UserPhones.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/10/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserPhones : NSManagedObject

@property (nonatomic, retain) NSString * userPhoneNum;
@property (nonatomic, retain) NSManagedObject *phoneOwner;

@end
