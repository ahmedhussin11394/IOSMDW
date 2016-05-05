//
//  IOSAgenda.m
//  DBProject
//
//  Created by Mahmoud El nagar on 4/9/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "IOSAgenda.h"
#import "Sessions.h"
#import "Speaker.h"
#import "MobilesOfSpeakers.h"
#import "PhonesOfSpeakers.h"
#import "CoreDataManager.h"
#import "IOSSessionDetailsView.h"
#import "Agenda.h"
#import "NetworkClass.h"
#import "NetworkManger.h"
#import "Reachability.h"
#import "IOSTableViewCell.h"
#import "IOSSortingArray.h"

@interface IOSAgenda ()

@end

@implementation IOSAgenda{
    NSMutableArray *firstAgenda, *secondAgenda, *thirdAgenda;
    CoreDataManager *core;
    IOSSortingArray *sort;
    NSUserDefaults *def;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dataRecived:(NSMutableArray *) data{
    if (data != nil) {
        

        firstAgenda = [[[data[0] agendaSessions]allObjects]mutableCopy];
        firstAgenda = [sort sortingArray:firstAgenda key:@"startDate" endDate:@"endDate"];
        
        
        secondAgenda = [[[data[1] agendaSessions]allObjects]mutableCopy];
        secondAgenda = [sort sortingArray:secondAgenda key:@"startDate" endDate:@"endDate"];
        
        thirdAgenda = [[[data[2] agendaSessions]allObjects]mutableCopy];
        thirdAgenda = [sort sortingArray:thirdAgenda key:@"startDate" endDate:@"endDate"];
        
        [self.tableView reloadData];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationItem.hidesBackButton = YES;

    def = [NSUserDefaults standardUserDefaults];
    printf("\n User Defalts %s",[[def objectForKey:@"userEmail"] UTF8String]);
    sort = [IOSSortingArray new];
    
    firstAgenda = [NSMutableArray new];
    secondAgenda = [NSMutableArray new];
    thirdAgenda = [NSMutableArray new];
    
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus status = [reach currentReachabilityStatus];
    if (status == NotReachable) {

        core = [CoreDataManager new];
        
        
        
        NSMutableArray *agendas = [core fetchEntitiesWithClassName:@"Agenda" sortDescriptors:nil predicate:nil];
        

        if (agendas.count > 0) {
            firstAgenda = [[[agendas[0] agendaSessions] allObjects] mutableCopy];
            firstAgenda = [sort sortingArray:firstAgenda key:@"startDate" endDate:@"endDate"];
            
            secondAgenda = [[[agendas[1] agendaSessions] allObjects] mutableCopy];
            secondAgenda = [sort sortingArray:secondAgenda key:@"startDate" endDate:@"endDate"];
            
            thirdAgenda = [[[agendas[2] agendaSessions] allObjects] mutableCopy];
            thirdAgenda = [sort sortingArray:thirdAgenda key:@"startDate" endDate:@"endDate"];
            
            if(_flag == true)
            {
                
                printf("Opa el koko");
                NSMutableArray *myArray;
                for(Sessions *s in firstAgenda){
                    myArray=[NSMutableArray new];
                    
                    if(s.like==[[NSNumber alloc]initWithInt:1])
                    {
                        [myArray addObject:s];
                    }
                    
                }
                firstAgenda=myArray;
                
                for(Sessions *s in secondAgenda){
                    myArray=[NSMutableArray new];
                    
                    if(s.like==[[NSNumber alloc]initWithInt:1])
                    {
                        [myArray addObject:s];
                    }
                    
                }
                secondAgenda=myArray;
                
                for(Sessions *s in thirdAgenda){
                    myArray=[NSMutableArray new];
                    
                    if(s.like==[[NSNumber alloc]initWithInt:1])
                    {
                        [myArray addObject:s];
                    }
                    
                }
                thirdAgenda=myArray;
            }
        }
        
        
        
        
        
    } else {
        printf("\nConnected\n");
        NetworkManger *manager = [NetworkManger new];
        NetworkClass *c = [manager getNetworkInstance];
        printf("\n%s\n",[c.sharedUserEmail UTF8String]);
        [c setMyDelegate:self];
        [c getSessions];
    }
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)viewDidAppear:(BOOL)animated{
    
//    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MDW 2016 Mobile APP-09.png"]]];
    [self.tabBarController.tabBar setBackgroundColor:[UIColor redColor]];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows;
    // Return the number of rows in the section.
    if (section == 0) {
        rows = [firstAgenda count];
    }
    else if (section == 1) {
        rows = [secondAgenda count];
    }
    else {
        rows = [thirdAgenda count];
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"agendaCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    Sessions *s ;
    UIImageView *imgv = (UIImageView*)[cell viewWithTag:4];
    UILabel *la = (UILabel*)[cell viewWithTag:5] ;
    
    
    if (indexPath.section == 0) {
        s = (Sessions*)[firstAgenda objectAtIndex:indexPath.row];
        [la setText:@"14"];
    }else if (indexPath.section == 1) {
        s = (Sessions*)[secondAgenda objectAtIndex:indexPath.row];
        [la setText:@"15"];
    }else {
        s = (Sessions*)[thirdAgenda objectAtIndex:indexPath.row];
        [la setText:@"16"];
    }
    
   
    
    if ([[s type] isEqualToString:@"Workshop"]) {
        imgv.image = [UIImage imageNamed:@"workshop.png"];
    }else if([[s type] isEqualToString:@"Break"]){
        imgv.image = [UIImage imageNamed:@"breakicon.png"];
        [la setText:@""];
    }else if([[s type] isEqualToString:@"Session"]){
        imgv.image = [UIImage imageNamed:@"session.png"];
    }else
        imgv.image = [UIImage imageNamed:@"hacathon.png"];
         
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Africa/Cairo"]];
    
    NSDate *d1 = s.startDate;
    NSString *str1 = [formatter stringFromDate:d1];
    
    
    NSDate *d2 = s.endDate;
    NSString *str2 = [formatter stringFromDate:d2];
    
    NSMutableString *date = [[NSMutableString alloc]initWithFormat:@"%@ - %@",str1,str2];
    

    
    //[(UILabel*)[cell viewWithTag:1] setText:s.name];
    [self htmlToUiLable:s.name :(UILabel*)[cell viewWithTag:1]];
    [self htmlToUiLable:s.location :(UILabel*)[cell viewWithTag:2]];
    [self htmlToUiLable:date :(UILabel*)[cell viewWithTag:3]];
//    UILabel * l = (UILabel*)[cell viewWithTag:2];
//    l.font = [UIFont fontWithName:@"Arial" size:14.0f];
//    [l setText:s.location];
//    [(UILabel*)[cell viewWithTag:3] setText:date];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 45.0;
    }
    return 0.0;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 1. Dequeue the custom header cell
    IOSTableViewCell* headerCell = nil;
    
    // 2. Set the various properties
    
    if (section == 0) {
        headerCell = [tableView dequeueReusableCellWithIdentifier:@"cellheader"];
        headerCell.labelName.text = @"Agenda";
        [headerCell.labelName sizeToFit];
        
        headerCell.imageV.image = [UIImage imageNamed:@"agenda.png"];
    }
//    else if (section == 1) {
//        headerCell.labelName.text = @"Second Day";
//        [headerCell.labelName sizeToFit];
//    }
//    else {
//        headerCell.labelName.text = @"Third Day";
//        [headerCell.labelName sizeToFit];
//    }
    
    
    
    
    // 3. And return
    return headerCell;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    printf("\n slider \n");
    return YES;
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"move"]) {
        IOSSessionDetailsView *details =  [segue destinationViewController];
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        
        if (index.section == 0) {
            details.session = [firstAgenda objectAtIndex:index.row];
        }
        else if (index.section == 1) {
            details.session = [secondAgenda objectAtIndex:index.row];
        }
        else {
            details.session = [thirdAgenda objectAtIndex:index.row];
        }
        
        
    }
    
}

-(void)htmlToUiLable: (NSString *) title : (UILabel *) titleLable
{
    
    NSString * htmlString = title;
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    titleLable.attributedText = attrStr;
    
}


@end
