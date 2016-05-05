//
//  SpeakerProfileViewController.m
//  DBProject
//
//  Created by JETS on 4/19/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "SpeakerProfileViewController.h"

@interface SpeakerProfileViewController ()

@end

@implementation SpeakerProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSMutableString *str = [[NSMutableString alloc]initWithFormat:@"%@ %@ %@",_speaker.fristName,_speaker.middleName,_speaker.lastName];
    [_speaker.fristName mutableCopy];
    [str appendString:@" "];
    [str appendString:[_speaker.lastName mutableCopy]];
    
    _speakerName.text = str;
    _speakerCompany.text = _speaker.companyName;
    _speakerTitle.text = _speaker.title;
    _speakerImage.image = [UIImage imageWithData:_speaker.img];
    _speakerBiograghy.text = _speaker.biography;
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
