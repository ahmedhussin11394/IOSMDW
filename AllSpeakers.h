//
//  AllSpeakers.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/10/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AllSpeakerPhone;

@interface AllSpeakers : NSManagedObject

@property (nonatomic, retain) NSString * biography;
@property (nonatomic, retain) NSString * imgurl;
@property (nonatomic, retain) NSString * fristName;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSData * img;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * middleName;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSSet *phones;
@property (nonatomic, retain) NSSet *mobiles;
@end

@interface AllSpeakers (CoreDataGeneratedAccessors)

- (void)addPhonesObject:(AllSpeakerPhone *)value;
- (void)removePhonesObject:(AllSpeakerPhone *)value;
- (void)addPhones:(NSSet *)values;
- (void)removePhones:(NSSet *)values;

- (void)addMobilesObject:(NSManagedObject *)value;
- (void)removeMobilesObject:(NSManagedObject *)value;
- (void)addMobiles:(NSSet *)values;
- (void)removeMobiles:(NSSet *)values;

@end
