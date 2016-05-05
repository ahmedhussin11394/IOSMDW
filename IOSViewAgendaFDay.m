//
//  IOSViewAgendaFDay.m
//  DBProject
//
//  Created by Mahmoud El nagar on 4/12/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "IOSViewAgendaFDay.h"
#import "Sessions.h"
#import "Speaker.h"
#import "MobilesOfSpeakers.h"
#import "PhonesOfSpeakers.h"
#import "CoreDataManager.h"
#import "Agenda.h"
#import "NetworkClass.h"
#import "NetworkManger.h"
#import "IOSSessionDetailsView.h"
#import "IOSTableViewCell.h"
#import "IOSSortingArray.h"

@interface IOSViewAgendaFDay ()

@end

@implementation IOSViewAgendaFDay{
    IOSSortingArray *sort;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    

    
    sort = [IOSSortingArray new];
    
    
        CoreDataManager *core = [CoreDataManager new];
        NSMutableArray *agendas = [core fetchEntitiesWithClassName:@"Agenda" sortDescriptors:nil predicate:nil];
        _result = [NSMutableArray new];
        if (agendas.count>0) {
            [_result addObjectsFromArray:[[agendas[0] agendaSessions] allObjects]];
            _result = [sort sortingArray:_result key:@"startDate" endDate:@"endDate"];
        }

   }


-(void)viewDidAppear:(BOOL)animated{
    
//    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MDW 2016 Mobile APP-09.png"]]];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _result.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"agendaFCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    
    Sessions *s = (Sessions*)[_result objectAtIndex:indexPath.row];
//    Speaker *sp = (Speaker *)[s.speakers anyObject];
//    NSString *str = (NSString *)[sp.phones anyObject];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Africa/Cairo"]];
    [formatter setDateFormat:@"HH:mm"];
    
    NSDate *d1 = s.startDate;
    NSString *str1 = [formatter stringFromDate:d1];
    
    
    NSDate *d2 = s.endDate;
    NSString *str2 = [formatter stringFromDate:d2];
    
    NSMutableString *date = [[NSMutableString alloc]initWithFormat:@"%@ - %@",str1,str2];
    
    UIImageView *imgv = (UIImageView*)[cell viewWithTag:4];
    UILabel *la = (UILabel*)[cell viewWithTag:5] ;
    [la setText:@"14"];
    
    if ([[s type] isEqualToString:@"Workshop"]) {
        imgv.image = [UIImage imageNamed:@"workshop.png"];
    }else if([[s type] isEqualToString:@"Break"]){
        imgv.image = [UIImage imageNamed:@"breakicon.png"];
        [la setText:@""];
    }else if([[s type] isEqualToString:@"Session"]){
        imgv.image = [UIImage imageNamed:@"session.png"];
    }else //if([[s type] isEqualToString:@"Hackathon"]){
        imgv.image = [UIImage imageNamed:@"hacathon.png"];
    
    
    [self htmlToUiLable:s.name :(UILabel*)[cell viewWithTag:1]];
    [self htmlToUiLable:s.location :(UILabel*)[cell viewWithTag:2]];
    [self htmlToUiLable:date :(UILabel*)[cell viewWithTag:3]];


    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0;
}



-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 1. Dequeue the custom header cell
    IOSTableViewCell* headerCell = [tableView dequeueReusableCellWithIdentifier:@"cellheader"];
    
    // 2. Set the various properties
    headerCell.labelName.text = @"First Day";
    [headerCell.labelName sizeToFit];
    
    headerCell.imageV.image = [UIImage imageNamed:@"agenda.png"];
    
    // 3. And return
    return headerCell;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    printf("\n slider \n");
    return YES;
}
/*
 
 
 -(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 UIView *head = [[UIView alloc] initWithFrame:CGRectMake(50, 0, tableView.frame.size.width, 100.0)];
 head.backgroundColor = [UIColor orangeColor];
 head.bounds  =CGRectMake(50, 50, 50, 50);
 
 
 //    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, tableView.frame.size.width, 25.0)];
 //    lab.backgroundColor = [UIColor clearColor];
 //    lab.font = [UIFont fontWithName:@"Verdana" size:20.0];
 //    lab.textAlignment = NSTextAlignmentCenter;
 //    lab.text = @"MDW Agenda";
 //    [head addSubview:lab];
 
 return head;
 }
 */


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"move"]) {
        IOSSessionDetailsView *details =  [segue destinationViewController];
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        details.session = [_result objectAtIndex:index.row];
    }

}

-(void)htmlToUiLable: (NSString *) title : (UILabel *) titleLable
{
    
    NSString * htmlString = title;
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    titleLable.attributedText = attrStr;
    
}

@end
