//
//  IOSContactViewController.m
//  DBProject
//
//  Created by JETS on 5/5/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "IOSContactViewController.h"
#import "NetworkClass.h"
#import "NetworkDelegate.h"
#import "NetworkManger.h"
#import "ZXingObjC.h"

@interface IOSContactViewController ()

@end

@implementation IOSContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.storyboard instantiateViewControllerWithIdentifier:@"third"];
    
    self.navigationItem.hidesBackButton = YES;
    
    NetworkManger *manager = [NetworkManger new];
    NetworkClass *c = [manager getNetworkInstance];
    
    [c setMyDelegate:self];
    [c loginWithName:@"eng.medhat.cs.h@gmail.com" andPassword:@"medhat123"];
    
   
}


- (void)setUser:(User *) user
{
    
    
    _UserEmaillbl.text= [user email];
    
    [self QRGenrator:[user email] :_UserContactQr:_contactError];
    
    
    
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

-(void) QRGenrator: (NSString *) token : (UIImageView *) MyQRImage :(UILabel *) errorLbl
{
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix * result = [writer encode:token
                                   format:kBarcodeFormatQRCode
                                    width:MyQRImage.frame.size.width
                                   height:MyQRImage.frame.size.height
                                    error:&error];
    if (result) {
        
        ZXImage *zximage = [ZXImage imageWithMatrix:result];
        MyQRImage.image = [UIImage imageWithCGImage:zximage.cgimage];
        
        
        
        // CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        
        //   MyQRImage = [[UIImage alloc] initWithCGImage:[[ZXImage.imageWithMatrix:result] image]]
        
        //   [MyQRImage initWithCGImage:image];
        
        // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
    } else {
        NSString *errorMessage = [error localizedDescription];
        errorLbl.text = errorMessage;
    }
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
