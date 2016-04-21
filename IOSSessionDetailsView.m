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

@interface IOSSessionDetailsView ()

@end

@implementation IOSSessionDetailsView{
    Boolean flag;
    NSArray *sp;
}

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
    printf("details\n");
	// Do any additional setup after loading the view.
    sp = [[_session speakers] allObjects];
    flag = false;

    if (flag) {
        flag = false;
        _starBtn.imageView.image = [UIImage imageNamed:@"sessionapproved.png"];
    }
    else{
        flag = true;
        _starBtn.imageView.image = [UIImage imageNamed:@"sessionnotadded.png"];
    }
    _location.text = _session.location;
    _sessionName.text = _session.name;
    _sessionTime.text = @"1:30 - 2:45";
    _speakersTableView.delegate = self;
    _speakersTableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return sp.count;
}
                                                             
                                                             
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"speakerInnerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Speaker *s = [sp objectAtIndex:indexPath.row];
    cell.textLabel.text = [[[s fristName] stringByAppendingString:@" "]stringByAppendingString:[s lastName]];
    cell.detailTextLabel.text = [s companyName];
    cell.imageView.image = [UIImage imageNamed:@"defultspeaker.png"];
        
    
    return cell;
        
}


-(void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
                                                             
                                                             
                                                             

- (IBAction)favouriteBtn:(id)sender {
    
    if (flag) {
        flag = false;
        _starBtn.imageView.image = [UIImage imageNamed:@"sessionnotadded.png"];
    }
    else{
        flag = true;
        _starBtn.imageView.image = [UIImage imageNamed:@"sessionapproved.png"];
    }

    
}
@end
