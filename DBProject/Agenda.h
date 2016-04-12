//
//  Agenda.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/12/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Sessions;

@interface Agenda : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSSet *agendaSessions;
@end

@interface Agenda (CoreDataGeneratedAccessors)

- (void)addAgendaSessionsObject:(Sessions *)value;
- (void)removeAgendaSessionsObject:(Sessions *)value;
- (void)addAgendaSessions:(NSSet *)values;
- (void)removeAgendaSessions:(NSSet *)values;

@end
