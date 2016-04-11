//
//  AllSpeakerPhone.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/10/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AllSpeakers;

@interface AllSpeakerPhone : NSManagedObject

@property (nonatomic, retain) NSString * phonenum;
@property (nonatomic, retain) AllSpeakers *phonessowner;

@end
