//
//  IOSExhiptorView.m
//  DBProject
//
//  Created by JETS on 5/4/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "IOSExhiptorView.h"
#import "NetworkClass.h"
#import "NetworkManger.h"
#import "CoreDataManager.h"
#import "NetworkManger.h"
#import "NetworkDelegate.h"
#import "IOSTableViewCell.h"
#import "Exhiptors.h"

@interface IOSExhiptorView ()

@end

@implementation IOSExhiptorView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.hidesBackButton = YES;
    
    
    
    NetworkManger *manager = [NetworkManger new];
    NetworkClass *c = [manager getNetworkInstance];
    
    [c setMyDelegate:self];
    [c getExhiptors];
    
    
    CoreDataManager *core = [CoreDataManager new];
    _managedObjectContext = core.managedObjectContext;
    _exhiptors=[core fetchEntitiesWithClassName:@"Exhiptors" sortDescriptors:nil  predicate:nil];
    if (_exhiptors== nil) {
        printf("\n result is empty in view did appear\n");
    }else
        printf("\n result in view did appear\n");
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MDW 2016 Mobile APP-09.png"]]];
    
    
}

- (void)dataRecived:(NSMutableArray *) data{
    
    if(data !=nil){
        
        _exhiptors=[NSMutableArray new];
        [_exhiptors addObjectsFromArray:data];
        [self.tableView reloadData];

    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _exhiptors.count;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return YES;
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
    headerCell.labelName.text = @"Exhiptors";
    [headerCell.labelName sizeToFit];
    
    headerCell.imageV.image = [UIImage imageNamed:@"speaker.png"];
    
    // 3. And return
    return headerCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"exhiptorCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
   
    Exhiptors *ex = (Exhiptors*)[_exhiptors objectAtIndex:indexPath.row];
    UIImageView *imgv = (UIImageView*)[cell viewWithTag:1];
    UILabel *comn = (UILabel*) [cell viewWithTag:2];
    comn.text = ex.companyName;
    
    UIImage *image = [UIImage imageWithData:ex.img];
    if(image ==nil){
        imgv.image=[UIImage imageNamed:@"exihiptors.png"];
    }else{
        imgv.image=image;
        
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected");
    
    NSString *urlString=[[_exhiptors objectAtIndex:indexPath.row] companyUrl];
    NSURL *url=[NSURL URLWithString:urlString];
        
    [[UIApplication sharedApplication]openURL:url];
    
    
    
    
    
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
