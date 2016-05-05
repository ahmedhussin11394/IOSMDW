//
//  IOSSessionDetailsView.m
//  DBProject
//
//  Created by Mahmoud El nagar on 4/15/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "IOSSessionDetailsView.h"
#import "Sessions.h"
#import "Speaker.h"
#import "MobilesOfSpeakers.h"
#import "PhonesOfSpeakers.h"
#import "CoreDataManager.h"
#import "SpeakerProfileViewController.h"

@interface IOSSessionDetailsView ()

@end

@implementation IOSSessionDetailsView{
    Boolean flag;
    NSArray *sp;
    UIButton *starBtn;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    starBtn = (UIButton *)[self.view viewWithTag:5];
    sp = [[_session speakers] allObjects];

    if (_session.like == [NSNumber numberWithInt:1]) {
        flag = true;
        starBtn.imageView.image = [UIImage imageNamed:@"sessionapproved.png"];
        printf("\n selected false\n");
    }
    else{
        flag = false;
    }
    [self htmlToUiLable:_session.name :_sessionName];
    _location.text = _session.location;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Africa/Cairo"]];

    [formatter setDateFormat:@"HH:mm"];
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"dd MMM YYYY"];
    
    
    
    NSDate *d1 = _session.startDate;
    NSString *str1 = [formatter stringFromDate:d1];
    
    NSString *str = [format stringFromDate:d1];
    
    
    NSDate *d2 = _session.endDate;
    NSString *str2 = [formatter stringFromDate:d2];
    
    NSMutableString *date = [[NSMutableString alloc]initWithFormat:@"%@ - %@",str1,str2];
    
    _dateLabel.text = str;
    _sessionTime.text = date;
    _speakersTableView.delegate = self;
    _speakersTableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return sp.count;
}
                                                             
                                                             
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"speakerInnerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }
    Speaker *s = [sp objectAtIndex:indexPath.row];
    cell.textLabel.text = [[[s fristName] stringByAppendingString:@" "]stringByAppendingString:[s lastName]];
    cell.detailTextLabel.text = [s companyName];
    cell.imageView.image = [UIImage imageWithData:s.img];
        
    
    return cell;
        
}


-(void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)favouriteBtn:(id)sender {
    
    if (flag) {
        flag = false;
        [starBtn setImage:[UIImage imageNamed:@"sessionnotadded.png"] forState:UIControlStateNormal];
    }
    else{
        [starBtn setImage:[UIImage imageNamed:@"sessionapproved.png"] forState:UIControlStateNormal];
        flag = true;
    }


    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"move"]) {
        SpeakerProfileViewController *details =  [segue destinationViewController];
        NSIndexPath *index = [self.speakersTableView indexPathForCell:sender];
        details.speaker = [sp objectAtIndex:index.row];
    }
}



-(void)htmlToUiLable: (NSString *) title : (UILabel *) titleLable
{
    
    NSString * htmlString = title;
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    titleLable.attributedText = attrStr;
    
}


@end

