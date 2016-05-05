//
//  CoreDataManager.m
//  Vent
//
//  Created by Medhat Ali on 3/2/15.
//  Copyright (c) 2015 Medhat.Ali@icloud.com. All rights reserved.
//

#import "CoreDataManager.h"
#import "Sessions.h"
#import "IOSAppDelegate.h"


@interface CoreDataManager ()

- (void)setupManagedObjectContext;

@end

@implementation CoreDataManager{
    NSString *sProjectName;
}

static CoreDataManager *coreDataManager;

+ (CoreDataManager *)sharedManager
{
    if (!coreDataManager) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    coreDataManager = [[CoreDataManager alloc] init];
    });
        
    }
    
    return coreDataManager;
}

#pragma mark - setup

- (id)init
{
    self = [super init];
    sProjectName = @"DBProject";
    if (self) {
    [self setupManagedObjectContext];
    }
    
    return self;
}

- (void)setupManagedObjectContext
{
    IOSAppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    _managedObjectContext = app.managedObjectContext;
    _managedObjectModel = app.managedObjectModel;
    _persistentStoreCoordinator = app.persistentStoreCoordinator;
    
}

-(void)saveManagedObject
{
    // Save the context.
    NSError *error = nil;
    if(![_managedObjectContext save:&error]){
        
    }
    
}

- (NSMutableArray *)fetchEntitiesWithClassName:(NSString *)className
    sortDescriptors:(NSArray *)sortDescriptors
    predicate:(NSPredicate *)predicate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:className
    inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.sortDescriptors = sortDescriptors;
    fetchRequest.predicate = predicate;
    
    NSError *error =nil;
    NSMutableArray *result = [[_managedObjectContext executeFetchRequest:fetchRequest error:&error]mutableCopy];
    return result;
}


- (void)deleteEntity:(NSManagedObject *)entity
{
    [self.managedObjectContext deleteObject:entity];
}


-(void)trunkateEntity:(NSString *)entityName{
    
    NSMutableArray *result = [self fetchEntitiesWithClassName:entityName sortDescriptors:nil predicate:nil];
    if (result != nil) {
        
        for (int i = 0; i<result.count; i++) {
            NSManagedObject *s = (NSManagedObject*)[result objectAtIndex:i];
            [self.managedObjectContext deleteObject:s];
            NSError *error = nil;
            if(![_managedObjectContext save:&error]){
                    
            }
        }

    }
    
}


@end
