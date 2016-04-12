//
//  ExhiptorsViewController.m
//  DBProject
//
//  Created by JETS on 4/11/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "ExhiptorsViewController.h"
#import "CoreDataManager.h"
#import "Exhiptors.h"
#import "PhonesOfExhiptors.h"
#import "MobilesOfExhiptors.h"

@interface ExhiptorsViewController ()

@end

@implementation ExhiptorsViewController{
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *str = [[NSString alloc] initWithFormat:@"http://www.mobiledeveloperweekend.net/service/getExhibitors?userName=monaadelrabea@gmail.com"];
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
    CoreDataManager *core = [CoreDataManager new];
    _managedObjectContext = core.managedObjectContext;
    _myData=[core fetchEntitiesWithClassName:@"Exhiptors" sortDescriptors:nil  predicate:nil];
    if (_myData == nil) {
        printf("\n result is empty in view did appear\n");
    }else{
        printf("\n result in viwe did appear\n");
        
        for (int i = 0; i<_myData.count; i++) {
            
            Exhiptors *e = (Exhiptors*)[_myData objectAtIndex:i];
            printf("\n image URL %s",[[e imgurl]UTF8String]);
            UIImage *image = [UIImage imageWithData:[e valueForKey:@"img"]];
            for (PhonesOfExhiptors *p  in e.phones) {
                printf("\n phone of exhiptor %s",[[p phonenum]UTF8String]);
            }
            
        }
        
        
    }
    
    
    
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
    
    CoreDataManager *core = [CoreDataManager new];
    _managedObjectContext = core.managedObjectContext;
    
    
    
    //trunkate tables before re filling
    
     [core trunkateEntity:@"Exhiptors"];
     [core trunkateEntity:@"PhonesOfExhiptors"];
     [core trunkateEntity:@"MobilesOfExhiptors"];
    
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:d options:NSJSONReadingAllowFragments error:&error];
    
    NSMutableArray *result = [dic objectForKey:@"result"];
    for (int i=0;i<result.count; i++) {
        NSDictionary *data = result[i];
        Exhiptors *exhiptor = [NSEntityDescription insertNewObjectForEntityForName:@"Exhiptors" inManagedObjectContext:_managedObjectContext];
        
        exhiptor.id = [[data objectForKey:@"id"]integerValue];
        exhiptor.imgurl=[data objectForKey:@"imageURL"];
        UIImage *image = [UIImage imageNamed:@"mo.png"];
        NSMutableSet* phones = [NSMutableSet set];
        NSMutableSet* mobiles = [NSMutableSet set];
        PhonesOfExhiptors *pl = [NSEntityDescription insertNewObjectForEntityForName:@"PhonesOfExhiptors" inManagedObjectContext:_managedObjectContext];
        PhonesOfExhiptors *pll = [NSEntityDescription insertNewObjectForEntityForName:@"PhonesOfExhiptors" inManagedObjectContext:_managedObjectContext];
        pl.phonenum=@"249";
        pll.phonenum=@"249";
        [phones addObject:pl];
        [phones addObject:pll];
        exhiptor.phones=phones;
        MobilesOfExhiptors *m1=[NSEntityDescription insertNewObjectForEntityForName:@"MobilesOfExhiptors" inManagedObjectContext:_managedObjectContext];
        MobilesOfExhiptors *m2 = [NSEntityDescription insertNewObjectForEntityForName:@"MobilesOfExhiptors" inManagedObjectContext:_managedObjectContext];
        m1.mobilenum=@"0101010101";
        m2.mobilenum=@"012012012";
        [mobiles addObject:m1];
        [mobiles addObject:m2];
        exhiptor.mobiles=mobiles;
        exhiptor.companyName=@"Valeo";
        exhiptor.companyAddress=@"Smart Vilage";
        exhiptor.companyAbout=@"making parts of cars";
        exhiptor.companyUrl=@"valeo@valeo.com";
        exhiptor.fax=@"shhdhhd";
        exhiptor.contactName=@"bassem adel";
        exhiptor.emailExh=@"monaadelrabea@gmail.com";
        exhiptor.countryName=@"Egypt";
        exhiptor.cityName=@"Cairo";
        exhiptor.img = [NSData dataWithData:UIImagePNGRepresentation(image)];
        printf("\n nnnnnnnnn %s ",[exhiptor.imgurl UTF8String]);
        
        NSError *error1 = nil;
        if(![_managedObjectContext save:&error1]){
            
        }
        
        
    }
    
    
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"exhiptorsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    Exhiptors *e = (Exhiptors*)[_myData objectAtIndex:indexPath.row];
    cell.textLabel.text = e.companyName;
    cell.detailTextLabel.text = e.companyUrl;
    UIImage *image = [UIImage imageWithData:[e valueForKey:@"img"]];
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
