//
//  Sessions.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/4/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Speaker;

@interface Sessions : NSManagedObject

@property (nonatomic) NSTimeInterval endDate;
@property (nonatomic) NSTimeInterval startDate;
@property (nonatomic) BOOL like;
@property (nonatomic, retain) NSString * descrption;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic) int16_t id;
@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) NSSet *speakers;
@end

@interface Sessions (CoreDataGeneratedAccessors)

- (void)addSpeakersObject:(Speaker *)value;
- (void)removeSpeakersObject:(Speaker *)value;
- (void)addSpeakers:(NSSet *)values;
- (void)removeSpeakers:(NSSet *)values;

@end
