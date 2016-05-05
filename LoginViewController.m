//
//  LoginViewController.m
//  DBProject
//
//  Created by JETS on 5/1/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "LoginViewController.h"
#import "NetworkClass.h"
#import "NetworkManger.h"
#import "RightMenuViewController.h"
#import "IOSViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    NetworkManger *manager;
    NetworkClass *network;
    NSUserDefaults *def;
}

- (void)viewDidLoad {
    def = [NSUserDefaults standardUserDefaults];
    NSString *email = [def objectForKey:@"userEmail"];
    
    self.navigationItem.hidesBackButton = YES;

    
    if ([email isEqualToString:@""]) {
        
    }else{
        IOSViewController *right = [self.storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
        [self.navigationController pushViewController:right animated:YES];
        network.sharedUserEmail = email;
    }
    
    
    _login_btn.layer.cornerRadius = 15;
    _login_btn.clipsToBounds = YES;
    
    self.view.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    manager = [NetworkManger new];
    network = [manager getNetworkInstance];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:true];

}- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logInCheck:(UIButton *)sender {
    NSString *userName = _userNameField.text;
    NSString *password = _passwordField.text;
    
    
    
    [def setObject:userName forKey:@"userEmail"];
    
    [network setMyDelegate:self];
    [network loginWithName:userName andPassword:password];
}

-(void)setUser:(User *)user{
    
    if (user != nil) {
        IOSViewController *right = [self.storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
        [self.navigationController pushViewController:right animated:YES];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"UserName or Password incorrect"
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}
@end
