
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;




+ (CoreDataManager *)sharedManager;

-(void)saveManagedObject;

- (NSMutableArray *)fetchEntitiesWithClassName:(NSString *)className
                                           sortDescriptors:(NSArray *)sortDescriptors
                                                 predicate:(NSPredicate *)predicate;
- (void)deleteEntity:(NSManagedObject *)entity;

- (void)trunkateEntity:(NSString *)entityName;

@end
