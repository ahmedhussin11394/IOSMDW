//
//  IOSViewController.m
//  DBProject
//
//  Created by JETS on 4/16/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "IOSViewController.h"
#import "IOSAgenda.h"
@interface IOSViewController ()

@end

@implementation IOSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.hidesBackButton = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - SlideNavigationController Methods -



- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
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


- (void) doAction {
    IOSAgenda *myagend=[[self viewControllers] objectAtIndex:0];
    [myagend setFlag:true];
    printf("when la");
}

- (void) doActionWithReload {
    IOSAgenda *myagend=[[self viewControllers] objectAtIndex:0];
    [myagend setFlag:true];
    [myagend viewDidLoad];
    printf("when reload");
}

@end
