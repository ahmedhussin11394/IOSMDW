//
//  SpeakerProfileViewController.h
//  DBProject
//
//  Created by JETS on 4/19/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Speaker.h"

@interface SpeakerProfileViewController : UIViewController

@property Speaker *speaker;

@property (weak, nonatomic) IBOutlet UIImageView *speakerImage;

@property (weak, nonatomic) IBOutlet UILabel *speakerName;
@property (weak, nonatomic) IBOutlet UILabel *speakerTitle;

@property (weak, nonatomic) IBOutlet UILabel *speakerCompany;
@property (weak, nonatomic) IBOutlet UITextView *speakerBiograghy;

@end
