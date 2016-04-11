//
//  UserRepository.h
//  Vent
//
//  Created by Medhat Ali on 3/2/15.
//  Copyright (c) 2015 Medhat.Ali@icloud.com. All rights reserved.
//

#import "BaseRepository.h"

@interface UserRepository : BaseRepository

+ (id) sharedProfile;

@property (nonatomic, retain) User *publicUserProfile;

-(User *) addUser:(NSString*)userDeviceUUID
   userDeviceName:(NSString*)userDeviceName
  userDisplayName:(NSString*)userDisplayName
        userEmail:(NSString*)userEmail
  userPhoneNumber:(NSString*)userPhoneNumber
      userCountry:(NSString*)userCountry
 userIsRegistered:(NSNumber*)userIsRegistered
userIsSecureLogin:(NSNumber*)userIsSecureLogin
    userFirstName:(NSString*)userFirstName
     userLastName:(NSString*)userLastName
       userStatus:(NSString*)userStatus
userProfileImageName:(NSString*)userProfileImageName
userProfileImagePath:(NSString*)userProfileImagePath
         userDate:(NSString*)userDate
       userActive:(NSNumber*)userActive
 userProfileImage:(NSData*)userProfileImage
          userPin:(NSString*)userPin
  userCountryCode:(NSString*)userCountryCode
            Error:(NSError **)error;

-(void)deleteUser:(User *)user Error:(NSError **)error;
-(void)updateUser:(User *)user Error:(NSError **)error;
-(NSManagedObject*)getUserbyDeviceName:(NSString*)userDeviceName Error:(NSError **)error;
-(NSMutableArray*)getUserbyUserDeviceUUID:(NSString*)userDeviceUUID Error:(NSError **)error;
-(NSMutableArray*)getAllUser:(NSString*)username Error:(NSError **)error;

@end
