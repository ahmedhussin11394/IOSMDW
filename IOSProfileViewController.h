//
//  IOSProfileViewController.h
//  DBProject
//
//  Created by JETS on 4/27/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkDelegate.h"

@interface IOSProfileViewController : UIViewController < NetworkDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *userProfileImg;
@property (strong, nonatomic) IBOutlet UILabel *UserNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *UserWorkLbl;

@property (strong, nonatomic) IBOutlet UILabel *UserCompanyLbl;



@end
