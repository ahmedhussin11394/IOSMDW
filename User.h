//
//  User.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/10/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UserMobiles, UserPhones;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * middleName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSData * cityName;
@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * imgurl;
@property (nonatomic, retain) NSData * img;
@property (nonatomic, retain) NSSet *mobiles;
@property (nonatomic, retain) NSSet *phones;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addMobilesObject:(UserMobiles *)value;
- (void)removeMobilesObject:(UserMobiles *)value;
- (void)addMobiles:(NSSet *)values;
- (void)removeMobiles:(NSSet *)values;

- (void)addPhonesObject:(UserPhones *)value;
- (void)removePhonesObject:(UserPhones *)value;
- (void)addPhones:(NSSet *)values;
- (void)removePhones:(NSSet *)values;

@end
