//
//  UserRepository.m
//  Smiley
//
//  Created by Sameh Farouk on 2/15/15.
//  Copyright (c) 2015 ITSC. All rights reserved.
//

#import "UserRepository.h"

@implementation UserRepository

+(Users*) insertOrUpdateUserWithName:(NSString*) name PhoneNumber: (NSString*) phoneNumber ImagePath: (NSString*) imagePath UMD:(UIManagedDocument*)document{
    __block Users *user;
    [document.managedObjectContext performBlockAndWait:^{
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Users"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"phoneNumber = %@",phoneNumber];
    
        fetchRequest.predicate = predicate;
        fetchRequest.fetchLimit = 1;
        
        NSArray *matches = [document.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
        if(matches.count>0){
            user = [matches objectAtIndex:0];
            NSLog(@"Found");
            user.name = name;
            user.imagePath = imagePath;
        }
    }];
    
    if (! user) {
        user = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:document.managedObjectContext];
        user.name = name;
        user.phoneNumber = phoneNumber;
    }
    
    [document saveToURL:document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        if(success) {
            NSLog(@"Saved");
        }
        else
        {
            NSLog(@"error");
        }
    }];
    return user;
}


@end
