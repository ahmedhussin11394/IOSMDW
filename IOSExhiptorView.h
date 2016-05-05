//
//  IOSExhiptorView.h
//  DBProject
//
//  Created by JETS on 5/4/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IOSExhiptorView : UITableViewController
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) NSMutableArray *exhiptors;

@end
