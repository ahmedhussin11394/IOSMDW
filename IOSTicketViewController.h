//
//  IOSTicketViewController.h
//  DBProject
//
//  Created by JETS on 5/5/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkDelegate.h"

@interface IOSTicketViewController : UIViewController <NetworkDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *UserTicketQr;

@property (strong, nonatomic) IBOutlet UILabel *ticketError;





@end
