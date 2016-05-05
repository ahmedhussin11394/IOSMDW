//
//  IOSSessionDetailsView.h
//  DBProject
//
//  Created by Mahmoud El nagar on 4/15/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sessions.h"

@interface IOSSessionDetailsView : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong , nonatomic) Sessions *session;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) IBOutlet UILabel *sessionName;
@property (strong, nonatomic) IBOutlet UILabel *sessionTime;
- (IBAction)favouriteBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UITableView *speakersTableView;

@end
