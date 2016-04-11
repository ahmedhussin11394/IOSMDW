//
//  Exhiptors.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/4/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Exhiptors : NSManagedObject

@property (nonatomic) int16_t id;
@property (nonatomic, retain) NSString * imgurl;
@property (nonatomic, retain) NSData * img;
@property (nonatomic, retain) NSString * companyAddress;
@property (nonatomic, retain) NSString * companyAbout;
@property (nonatomic, retain) NSString * contactName;
@property (nonatomic, retain) NSString * fax;
@property (nonatomic, retain) NSString * companyUrl;
@property (nonatomic, retain) NSString * emailExh;
@property (nonatomic, retain) NSString * countryName;
@property (nonatomic, retain) NSString * cityName;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSSet *phones;
@property (nonatomic, retain) NSSet *mobiles;
@end

@interface Exhiptors (CoreDataGeneratedAccessors)

- (void)addPhonesObject:(NSManagedObject *)value;
- (void)removePhonesObject:(NSManagedObject *)value;
- (void)addPhones:(NSSet *)values;
- (void)removePhones:(NSSet *)values;

- (void)addMobilesObject:(NSManagedObject *)value;
- (void)removeMobilesObject:(NSManagedObject *)value;
- (void)addMobiles:(NSSet *)values;
- (void)removeMobiles:(NSSet *)values;

@end
