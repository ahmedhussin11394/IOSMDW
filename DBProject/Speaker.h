//
//  Speaker.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/5/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MobilesOfSpeakers, PhonesOfSpeakers, Sessions;

@interface Speaker : NSManagedObject

@property (nonatomic, retain) NSString * biography;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSString * fristName;
@property (nonatomic) BOOL gender;
@property (nonatomic) int16_t id;
@property (nonatomic, retain) NSData * img;
@property (nonatomic, retain) NSString * imgurl;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * middleName;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *mobiles;
@property (nonatomic, retain) NSSet *phones;
@property (nonatomic, retain) NSSet *session;
@end

@interface Speaker (CoreDataGeneratedAccessors)

- (void)addMobilesObject:(MobilesOfSpeakers *)value;
- (void)removeMobilesObject:(MobilesOfSpeakers *)value;
- (void)addMobiles:(NSSet *)values;
- (void)removeMobiles:(NSSet *)values;

- (void)addPhonesObject:(PhonesOfSpeakers *)value;
- (void)removePhonesObject:(PhonesOfSpeakers *)value;
- (void)addPhones:(NSSet *)values;
- (void)removePhones:(NSSet *)values;

- (void)addSessionObject:(Sessions *)value;
- (void)removeSessionObject:(Sessions *)value;
- (void)addSession:(NSSet *)values;
- (void)removeSession:(NSSet *)values;

@end
