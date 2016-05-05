//
//  IOSAgendaSDay.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/12/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkDelegate.h"

@interface IOSAgendaSDay : UITableViewController<NetworkDelegate>

@property(strong , nonatomic) NSMutableArray *result;

@end
