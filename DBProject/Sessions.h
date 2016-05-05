//
//  Sessions.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/12/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agenda, Speaker;

@interface Sessions : NSManagedObject

@property (nonatomic, retain) NSString * descrption;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * like;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *speakers;
@property (nonatomic, retain) Agenda *agendaid;
@end

@interface Sessions (CoreDataGeneratedAccessors)

- (void)addSpeakersObject:(Speaker *)value;
- (void)removeSpeakersObject:(Speaker *)value;
- (void)addSpeakers:(NSSet *)values;
- (void)removeSpeakers:(NSSet *)values;

@end
