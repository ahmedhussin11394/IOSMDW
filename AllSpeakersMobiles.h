//
//  AllSpeakersMobiles.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/10/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AllSpeakers;

@interface AllSpeakersMobiles : NSManagedObject

@property (nonatomic, retain) NSString * mobilenum;
@property (nonatomic, retain) AllSpeakers *mobilesowner;

@end
