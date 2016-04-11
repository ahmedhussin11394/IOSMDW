//
//  IOSMainMenu.m
//  DBProject
//
//  Created by Mahmoud El nagar on 4/9/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "IOSMainMenu.h"
#import "IOSAgenda.h"
#import "Sessions.h"
#import "Speaker.h"
#import "MobilesOfSpeakers.h"
#import "PhonesOfSpeakers.h"
#import "CoreDataManager.h"

@interface IOSMainMenu ()

@end

@implementation IOSMainMenu{
    NSArray *menu;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    menu = [[NSMutableArray alloc]initWithObjects:@"Agenda",@"My Agenda",@"Speakers",@"Exhiptors",@"Profile",@"LogOut",nil];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}





-(void)viewWillAppear:(BOOL)animated{
    
    CoreDataManager *core = [CoreDataManager new];
    _managedObjectContext = core.managedObjectContext;
    
    
    
    //trunkate tables before re filling
    
    [core trunkateEntity:@"Sessions"];
    [core trunkateEntity:@"PhonesOfSpeakers"];
    [core trunkateEntity:@"MobilesOfSpeakers"];
    [core trunkateEntity:@"Speaker"];
    
    
    
    //refilling tables with data
    
    for (int i = 0; i<5; i++) {
        
    Sessions *session = [NSEntityDescription insertNewObjectForEntityForName:@"Sessions" inManagedObjectContext:_managedObjectContext];
    
    session.name = @"mahmoud";
    session.location = @"Alex";
    session.id = 1200;
    session.descrption = @"inter net of things";;
    session.type = @"Sicntific";
    session.like = true;
    session.tag = @"good";
    
    
    Speaker *speaker = [NSEntityDescription insertNewObjectForEntityForName:@"Speaker" inManagedObjectContext:_managedObjectContext];
    speaker.id = i+1;
    speaker.gender = true;
    speaker.imgurl = @"http";
    speaker.middleName = @"mahmoud";
    speaker.biography = @"speaker";
    speaker.fristName = @"ahmed";
    speaker.lastName = @"elnagar";
    speaker.companyName = @"oracle";
    speaker.title = @"intro";
    
    MobilesOfSpeakers *m = [NSEntityDescription insertNewObjectForEntityForName:@"MobilesOfSpeakers" inManagedObjectContext:_managedObjectContext];
    [m setMobilenum:@"01203265"];
    
    MobilesOfSpeakers *m1 = [NSEntityDescription insertNewObjectForEntityForName:@"MobilesOfSpeakers" inManagedObjectContext:_managedObjectContext];
    [m1 setMobilenum:@"010352369"];
    
    
    PhonesOfSpeakers *p = [NSEntityDescription insertNewObjectForEntityForName:@"PhonesOfSpeakers" inManagedObjectContext:_managedObjectContext];
    [p setPhonenum:@"0456982365"];
    PhonesOfSpeakers *p1 = [NSEntityDescription insertNewObjectForEntityForName:@"PhonesOfSpeakers" inManagedObjectContext:_managedObjectContext];
    [p1 setPhonenum:@"0103265"];
    
    [speaker addMobiles:[NSSet setWithObjects:m,m1, nil]];
    [speaker addPhones:[NSSet setWithObjects:p,p1, nil]];
    
    
    
    
    
    
    
    
    
    
    
    
    Speaker *speaker1 = [NSEntityDescription insertNewObjectForEntityForName:@"Speaker" inManagedObjectContext:_managedObjectContext];
    speaker1.id = i+1;
    speaker1.gender = true;
    speaker1.imgurl = @"http";
    speaker1.middleName = @"adel";
    speaker1.biography = @"speaker";
    speaker1.fristName = @"mona";
    speaker1.lastName = @"rabe3";
    speaker1.companyName = @"oracle";
    speaker1.title = @"intro";
    
    MobilesOfSpeakers *m2 = [NSEntityDescription insertNewObjectForEntityForName:@"MobilesOfSpeakers" inManagedObjectContext:_managedObjectContext];
    [m2 setMobilenum:@"01203265"];
    
    MobilesOfSpeakers *m3 = [NSEntityDescription insertNewObjectForEntityForName:@"MobilesOfSpeakers" inManagedObjectContext:_managedObjectContext];
    [m3 setMobilenum:@"010352369"];
    
    
    PhonesOfSpeakers *p2 = [NSEntityDescription insertNewObjectForEntityForName:@"PhonesOfSpeakers" inManagedObjectContext:_managedObjectContext];
    [p2 setPhonenum:@"0456982365"];
    PhonesOfSpeakers *p3 = [NSEntityDescription insertNewObjectForEntityForName:@"PhonesOfSpeakers" inManagedObjectContext:_managedObjectContext];
    [p3 setPhonenum:@"0103265"];
    
    [speaker1 addMobiles:[NSSet setWithObjects:m2,m3, nil]];
    [speaker1 addPhones:[NSSet setWithObjects:p2,p3, nil]];
    
    [session addSpeakers:[NSSet setWithObjects:speaker1,speaker, nil]];
    
    NSError *error = nil;
    [core insertModelError:&error];
    }
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
    return menu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = menu[indexPath.row];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        IOSAgenda *second = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBar"];
        [self.navigationController pushViewController:second animated:true];
    }
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
