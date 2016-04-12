//
//  SpeakersViewController.h
//  DBProject
//
//  Created by JETS on 4/11/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeakersViewController : UITableViewController < NSURLConnectionDataDelegate , NSURLConnectionDelegate>
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) NSMutableArray *allSpeakers;
-(void) myFunctionSetter;
@end
