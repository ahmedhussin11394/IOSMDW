//
//  IOSProfileViewController.m
//  DBProject
//
//  Created by JETS on 4/27/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "IOSProfileViewController.h"
#import "NetworkClass.h"
#import "NetworkDelegate.h"
#import "NetworkManger.h"
#import "ZXingObjC.h"


@interface IOSProfileViewController ()

@end

@implementation IOSProfileViewController
{
    NSString *url;
    NSData *imgData;
    NSString *name;
    NSString *job;
    NSString *company;
    NSString *code;
    NSString *email;
    NSString *phone;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationItem.hidesBackButton = YES;
    
    NetworkManger *manager = [NetworkManger new];
    NetworkClass *c = [manager getNetworkInstance];
    
    [c setMyDelegate:self];
    [c loginWithName:@"eng.medhat.cs.h@gmail.com" andPassword:@"medhat123"];
    

    


}

- (void)setUser:(User *) user
{
   url = [user imgurl];
  imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
   // _userProfileImg.image = [UIImage imageWithData:imgData];
  
    
    
    name = [[ [[user firstName] stringByAppendingString:@" "] stringByAppendingString:[[user middleName] stringByAppendingString:@" " ]] stringByAppendingString:[user lastName]];
    
    job = [user title];
    
    company = [user companyName];
    
    email = [user email];
 
    if (imgData == nil) {
        _userProfileImg.image = [UIImage imageNamed:@"defultspeaker.png"];
    }
    else{
        _userProfileImg.image = [UIImage imageWithData:imgData];
    }
    _UserNameLbl.text = name;
    _UserWorkLbl.text = job;
    _UserCompanyLbl.text = company;
    
    [self.storyboard instantiateViewControllerWithIdentifier:@"first"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    printf("\n slider \n");
    return YES;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
