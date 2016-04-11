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

@interface IOSAgenda ()

@end

@implementation IOSAgenda

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
    
    
    
    CoreDataManager *core = [CoreDataManager new];
    _result = [core fetchEntitiesWithClassName:@"Sessions" sortDescriptors:nil predicate:nil];
    
    
    for (int i = 0; i<_result.count; i++) {
        
        Sessions *s1 = (Sessions*)[_result objectAtIndex:i];
        
        printf("\n%s \n%d \n%s \n%s \n%s \n%c",[s1.name UTF8String],s1.id,[s1.descrption UTF8String],[s1.type UTF8String],[s1.location UTF8String],s1.like);
    }

    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)viewDidAppear:(BOOL)animated{
//    
//    for (int i = 0; i<_result.count; i++) {
//        
//        Sessions *s1 = (Sessions*)[_result objectAtIndex:i];
//        
//        printf("\n%s \n%d \n%s \n%s \n%s \n%c",[s1.name UTF8String],s1.id,[s1.descrption UTF8String],[s1.type UTF8String],[s1.location UTF8String],s1.like);
//    }
//
    
    


    
//            for (Speaker *sp  in s.speakers) {
//                printf("\nuser speaker name %s %s",[[sp fristName]UTF8String],[[sp lastName]UTF8String]);
//                
//                for (MobilesOfSpeakers *mobile in sp.mobiles) {
//                    printf("\nuser mobiles num %s ",[[mobile mobilenum] UTF8String]);
//                }
//                
//                for (PhonesOfSpeakers *phone in sp.phones) {
//                    printf("\nuser phones num %s ",[[phone phonenum] UTF8String]);
//                }
//            }
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
    static NSString *CellIdentifier = @"agendaCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    Sessions *s = (Sessions*)[_result objectAtIndex:indexPath.row];
    NSMutableString *date = [[NSMutableString alloc]initWithFormat:@"%f -",s.startDate];
    [date appendString:[[NSMutableString alloc]initWithFormat:@" %f",s.endDate]];
    
    printf("\n%s \n%d of %d \n%s \n%s \n%s \n%c",[s.name UTF8String],indexPath.row,_result.count,[s.descrption UTF8String],[s.type UTF8String],[s.location UTF8String],s.like);
    
    [(UILabel*)[cell viewWithTag:1] setText:s.name];
    [(UILabel*)[cell viewWithTag:2] setText:s.location];
    [(UILabel*)[cell viewWithTag:3] setText:date];
    [(UIImageView*)[cell viewWithTag:4] setImage:[UIImage imageNamed:@"m.png"]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    printf("didSelectRowAtIndexPath");
}

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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
