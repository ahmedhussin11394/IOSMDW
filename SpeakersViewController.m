//
//  SpeakersViewController.m
//  DBProject
//
//  Created by JETS on 4/11/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "SpeakersViewController.h"
#import "CoreDataManager.h"
#import "AllSpeakerPhone.h"
#import "AllSpeakers.h"
#import "AllSpeakersMobiles.h"
#import "NetworkClass.h"
#import "NetworkManger.h"
#import "SpeakerProfileViewController.h"
#import "NetworkDelegate.h"
#import "IOSTableViewCell.h"

@interface SpeakersViewController ()

@end

@implementation SpeakersViewController{
    
    NSMutableData *d;
    
    
}

    

@synthesize managedObjectContext = _managedObjectContext;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dataRecived:(NSMutableArray *) data{
     printf("%s \n",[@"in data recirved" UTF8String]);
  
   if(data !=nil){
       
        _allSpeakers=[NSMutableArray new];
       [_allSpeakers addObjectsFromArray:data];
       
   }
    

    if(data !=nil){
        [self.tableView reloadData];
       // [self insertFunction:_allSpeakers];
       
    }
}


-(void)viewDidAppear:(BOOL)animated{
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MDW 2016 Mobile APP-09.png"]]];

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"f.png"]];
    
    self.navigationItem.hidesBackButton = YES;

    
    
    NetworkManger *manager = [NetworkManger new];
    NetworkClass *c = [manager getNetworkInstance];

    [c setMyDelegate:self];
    [c getSpeakers];
    

    CoreDataManager *core = [CoreDataManager new];
    _managedObjectContext = core.managedObjectContext;
    _allSpeakers=[core fetchEntitiesWithClassName:@"AllSpeakers" sortDescriptors:nil  predicate:nil];
    if (_allSpeakers == nil) {
        printf("\n result is empty in view did appear\n");
    }else
        printf("\n result in view did appear\n");
    
  
    
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
    return _allSpeakers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"speakerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    UIImageView *imageV = (UIImageView*)[cell viewWithTag:1];
    UILabel *speakerName = (UILabel*) [cell viewWithTag:2];
    UILabel *companyName = (UILabel*) [cell viewWithTag:3];
    
    AllSpeakers *sp = (AllSpeakers*)[_allSpeakers objectAtIndex:indexPath.row];
    if(sp.middleName != nil ){
        speakerName.text = [[[[sp.fristName  stringByAppendingString:@" " ]stringByAppendingString:sp.middleName] stringByAppendingString:@" "] stringByAppendingString:sp.lastName ] ;
    }
    else{
       speakerName.text = [[sp.fristName  stringByAppendingString:@" " ] stringByAppendingString:sp.lastName ];
        
    }
    

    if(sp.img ==nil){
        imageV.image=[UIImage imageNamed:@"defultspeaker.png"];
    }else{
        imageV.image=[UIImage imageWithData:sp.img];

    }
    companyName.text = sp.companyName;
    return cell;
}


- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return YES;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(50, 0, tableView.frame.size.width, 100.0)];
//    head.backgroundColor = [UIColor orangeColor];
//    head.bounds  =CGRectMake(50, 50, 50, 50);
//    
//    
//      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, tableView.frame.size.width, 25.0)];
//   UIImage *image = [UIImage imageNamed:@"defultspeaker.png"];
//    lab.backgroundColor = [UIColor clearColor];
//    lab.font = [UIFont fontWithName:@"Verdana" size:20.0];
//    
//        lab.textAlignment = NSTextAlignmentCenter;
//        lab.text = @"Speakers";
// 
//    
//    return head;
//}

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



 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
     if ([segue.identifier isEqualToString:@"move"]) {
         SpeakerProfileViewController *details =  [segue destinationViewController];
         NSIndexPath *index = [self.tableView indexPathForCell:sender];
         details.speaker = [_allSpeakers objectAtIndex:index.row];
 }
 
     
     
     
     
 }

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 68.0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 1. Dequeue the custom header cell
    IOSTableViewCell* headerCell = [tableView dequeueReusableCellWithIdentifier:@"cellheader"];
    
    // 2. Set the various properties
    headerCell.labelName.text = @"Speakers";
    [headerCell.labelName sizeToFit];
    
    headerCell.imageV.image = [UIImage imageNamed:@"speaker.png"];
    
    // 3. And return
    return headerCell;
}






@end
