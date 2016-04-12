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
-(void) myFunctionSetter{
    CoreDataManager *core = [CoreDataManager new];
    _managedObjectContext = core.managedObjectContext;
    //trunkate tables before re filling
    
    [core trunkateEntity:@"AllSpeakers"];
     [core trunkateEntity:@"AllSpeakerPhone"];
     [core trunkateEntity:@"AllSpeakersMobiles"];
    
    NSError *error = nil;
    /*  NSDictionary *dicc = [NSJSONSerialization JSONObjectWithData:d options:NSJSONReadingAllowFragments error:&error];*/
    
    for (int i=0;i<=7;i++) {
        AllSpeakers *speakers1 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakers" inManagedObjectContext:_managedObjectContext];
        speakers1.fristName=@"mona";
        speakers1.middleName=@"adel";
        speakers1.lastName=@"rabea";
        speakers1.imgurl=@"mammaamam";
        UIImage *image = [UIImage imageNamed:@"m.png"];
        speakers1.img = [NSData dataWithData:UIImagePNGRepresentation(image)];
        
        
        AllSpeakersMobiles *m = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakersMobiles" inManagedObjectContext:_managedObjectContext];
        [m setMobilenum:@"01203265"];
        
        AllSpeakersMobiles *m1 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakersMobiles" inManagedObjectContext:_managedObjectContext];
        [m1 setMobilenum:@"010352369"];
        
        
        AllSpeakerPhone *p = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakerPhone" inManagedObjectContext:_managedObjectContext];
        [p setPhonenum:@"0456982365"];
        AllSpeakerPhone *p1 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakerPhone" inManagedObjectContext:_managedObjectContext];
        [p1 setPhonenum:@"0103265"];
        
        [speakers1 addMobiles:[NSSet setWithObjects:m,m1, nil]];
        [speakers1 addPhones:[NSSet setWithObjects:p,p1, nil]];
        
        
         AllSpeakers *speakers2 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakers" inManagedObjectContext:_managedObjectContext];
         speakers2.fristName=@"mona";
         speakers2.middleName=@"adel";
         speakers2.lastName=@"rabea";
         speakers2.imgurl=@"mammaamam";
         UIImage *image2 = [UIImage imageNamed:@"f.png"];
         speakers2.img = [NSData dataWithData:UIImagePNGRepresentation(image2)];
         
         
         AllSpeakersMobiles *m2 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakersMobiles" inManagedObjectContext:_managedObjectContext];
         [m2 setMobilenum:@"01203265"];
         
         AllSpeakersMobiles *m3 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakersMobiles" inManagedObjectContext:_managedObjectContext];
         [m3 setMobilenum:@"010352369"];
         
         
         AllSpeakerPhone *p2 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakerPhone" inManagedObjectContext:_managedObjectContext];
         [p2 setPhonenum:@"0456982365"];
         AllSpeakerPhone *p3 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakerPhone" inManagedObjectContext:_managedObjectContext];
         [p3 setPhonenum:@"0103265"];
         
         
         [speakers2 addMobiles:[NSSet setWithObjects:m2,m3, nil]];
         [speakers2 addPhones:[NSSet setWithObjects:p2,p3, nil]];
        
        NSError *error1 = nil;
        if(![_managedObjectContext save:&error1]){
            
        }
        
    }
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myFunctionSetter;
    CoreDataManager *core = [CoreDataManager new];
    _managedObjectContext = core.managedObjectContext;
    _allSpeakers=[core fetchEntitiesWithClassName:@"AllSpeakers" sortDescriptors:nil  predicate:nil];
    if (_allSpeakers == nil) {
        printf("\n result is empty in view did appear\n");
    }else{
        printf("\n result in view did appear\n");
        
        for (int i = 0; i<_allSpeakers.count; i++) {
            
            AllSpeakers *sp = (AllSpeakers*)[_allSpeakers objectAtIndex:i];
            
            printf("\n%s \n \n%s ",[sp.fristName UTF8String],[sp.middleName UTF8String]);
            UIImage *image = [UIImage imageWithData:[sp valueForKey:@"img"]];
            for (AllSpeakerPhone *p  in sp.phones) {
                printf("\n phone of Speakers %s",[[p phonenum]UTF8String]);
            }
            
        }
        
        
    }


    NSString *str = [[NSString alloc] initWithFormat:@"http://www.mobiledeveloperweekend.net/service/getSpeakers?userName=eng. medhat.cs.h@gmail.com"];
    NSURLRequest *reqq = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:reqq delegate:self];
    [con start];
    printf("\n nnnnnnnnn %s ","mona adel");
    
    
    
  
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewDidAppear:(BOOL)animated{
//    CoreDataManager *core = [CoreDataManager new];
//    _managedObjectContext = core.managedObjectContext;
//    _allSpeakers=[core fetchEntitiesWithClassName:@"AllSpeakers" sortDescriptors:nil  predicate:nil];
//    if (_allSpeakers == nil) {
//        printf("\n result is empty in view did appear\n");
//    }else{
//        printf("\n result in view did appear\n");
//        
//        for (int i = 0; i<_allSpeakers.count; i++) {
//            
//            AllSpeakers *sp = (AllSpeakers*)[_allSpeakers objectAtIndex:i];
//            
//            printf("\n%s \n \n%s ",[sp.fristName UTF8String],[sp.middleName UTF8String]);
//            UIImage *image = [UIImage imageWithData:[sp valueForKey:@"img"]];
//            for (AllSpeakerPhone *p  in sp.phones) {
//                printf("\n phone of exhiptor %s",[[p phonenum]UTF8String]);
//            }
//            
//        }
//        
//        
//    }
//
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //    NSString *str1 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding ];
    if(d !=nil)
        [d appendData:data];
    else
        d = (NSMutableData*)data;
    
    printf("didReceiveData \n");
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
    /*CoreDataManager *core = [CoreDataManager new];
    _managedObjectContext = core.managedObjectContext;
    //trunkate tables before re filling
    
    /*[core trunkateEntity:@"AllSpeakers"];
    [core trunkateEntity:@"AllSpeakerPhone"];
    [core trunkateEntity:@"AllSpeakersMobiles"];*/

   // NSError *error = nil;
  /*  NSDictionary *dicc = [NSJSONSerialization JSONObjectWithData:d options:NSJSONReadingAllowFragments error:&error];
    
    for (int i=0;i<=7;i++) {
        AllSpeakers *speakers1 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakers" inManagedObjectContext:_managedObjectContext];
        speakers1.fristName=@"mona";
        speakers1.middleName=@"adel";
        speakers1.lastName=@"rabea";
        speakers1.imgurl=@"mammaamam";
        UIImage *image = [UIImage imageNamed:@"m.png"];
        speakers1.img = [NSData dataWithData:UIImagePNGRepresentation(image)];
        
        
        AllSpeakersMobiles *m = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakersMobiles" inManagedObjectContext:_managedObjectContext];
        [m setMobilenum:@"01203265"];
        
        AllSpeakersMobiles *m1 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakersMobiles" inManagedObjectContext:_managedObjectContext];
        [m1 setMobilenum:@"010352369"];
        
        
        AllSpeakerPhone *p = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakerPhone" inManagedObjectContext:_managedObjectContext];
        [p setPhonenum:@"0456982365"];
        AllSpeakerPhone *p1 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakerPhone" inManagedObjectContext:_managedObjectContext];
        [p1 setPhonenum:@"0103265"];
        
        [speakers1 addMobiles:[NSSet setWithObjects:m,m1, nil]];
        [speakers1 addPhones:[NSSet setWithObjects:p,p1, nil]];
        
       
        AllSpeakers *speakers2 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakers" inManagedObjectContext:_managedObjectContext];
        speakers2.fristName=@"mona";
        speakers2.middleName=@"adel";
        speakers2.lastName=@"rabea";
        speakers2.imgurl=@"mammaamam";
        UIImage *image2 = [UIImage imageNamed:@"f.png"];
        speakers2.img = [NSData dataWithData:UIImagePNGRepresentation(image2)];
        
        
        AllSpeakersMobiles *m2 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakersMobiles" inManagedObjectContext:_managedObjectContext];
        [m2 setMobilenum:@"01203265"];
        
        AllSpeakersMobiles *m3 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakersMobiles" inManagedObjectContext:_managedObjectContext];
        [m3 setMobilenum:@"010352369"];
        
        
        AllSpeakerPhone *p2 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakerPhone" inManagedObjectContext:_managedObjectContext];
        [p2 setPhonenum:@"0456982365"];
        AllSpeakerPhone *p3 = [NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakerPhone" inManagedObjectContext:_managedObjectContext];
        [p3 setPhonenum:@"0103265"];
        
        
        [speakers2 addMobiles:[NSSet setWithObjects:m2,m3, nil]];
        [speakers2 addPhones:[NSSet setWithObjects:p2,p3, nil]];
        
        NSError *error1 = nil;
        if(![_managedObjectContext save:&error1]){
            
        }
        
    }
 
    */
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _allSpeakers.count;
}


//-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *CellIdentifier = @"SpeakersCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    return cell; 
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SpeakersCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    AllSpeakers *sp = (AllSpeakers*)[_allSpeakers objectAtIndex:indexPath.row];
    printf("name %s %s\n",[sp.fristName UTF8String],[sp.lastName UTF8String]);
    cell.textLabel.text = sp.fristName;
    cell.detailTextLabel.text = sp.lastName;
    UIImage *image = [UIImage imageWithData:[sp valueForKey:@"img"]];
    cell.imageView.image=image;
    
    return cell;
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
