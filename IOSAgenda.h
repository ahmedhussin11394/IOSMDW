//
//  IOSAgenda.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/9/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkDelegate.h"

@interface IOSAgenda : UITableViewController<NetworkDelegate>

@property(strong , nonatomic) NSMutableArray *result;
@property(strong , nonatomic) NSMutableArray *icons;

@end
