//
//  IOSContactViewController.h
//  DBProject
//
//  Created by JETS on 5/5/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkDelegate.h"

@interface IOSContactViewController : UIViewController<NetworkDelegate>
@property (strong, nonatomic) IBOutlet UILabel *UserEmaillbl;
@property (strong, nonatomic) IBOutlet UIImageView *UserContactQr;
@property (strong, nonatomic) IBOutlet UILabel *contactError;

@end



