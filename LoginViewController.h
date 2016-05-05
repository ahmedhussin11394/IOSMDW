//
//  LoginViewController.h
//  DBProject
//
//  Created by JETS on 5/1/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NetworkDelegate.h"

@interface LoginViewController : UIViewController<NetworkDelegate>

- (IBAction)logInCheck:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *login_btn;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end
