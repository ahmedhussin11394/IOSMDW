//
//  RightMenuViewController.m
//  TesterMenu
//
//  Created by JETS on 4/6/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "RightMenuViewController.h"

@implementation RightMenuViewController
{
    NSArray *images;
}


#pragma mark - UIViewController Methods -

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    
    images=@[@"agenda.png",@"myagenda.png",@"speaker.png",@"exihiptors.png",@"profile.png",@"logout.png"];
	
	self.tableView.separatorColor = [UIColor grayColor];
	
	/*UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MDW 2016 Mobile APP-07.png"]];
	//self.tableView.backgroundView = imageView;
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    [imageView reloadInputViews];*/
   
    
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
	view.backgroundColor = [UIColor clearColor];
	return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightMenuCell"];
    cell.imageView.image=[UIImage imageNamed:[images objectAtIndex:indexPath.row]];
    //UIImageView *cellimage = cell.imageView;
    //CGRect frame = cellimage.frame;
    //frame.origin.x = -20;
    //frame.origin.y = 4
   // cellimage.frame = CGRectMake(-500, 20, 65 , 65);
    
	switch (indexPath.row)
	{
		case 0:
			cell.textLabel.text = @"Agenda";
           
			break;
			
		case 1:
			cell.textLabel.text = @"MyAgenda";
			break;
			
		case 2:
			cell.textLabel.text = @"Speakers";
			break;
			
		case 3:
			cell.textLabel.text = @"Exhibitors";
			break;
			
		case 4:
			cell.textLabel.text = @"Profile";
			break;
			
		case 5:
			cell.textLabel.text = @"LogOut";
			break;
	}
	
	cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.transform = CGAffineTransformMakeScale(-1,1);
    cell.contentView.transform = CGAffineTransformMakeScale(-1,1);
    cell.textLabel.transform = CGAffineTransformMakeScale(-1,1);
	
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard"
                                                             bundle: nil];
    
    UIViewController *vc ;
    
    switch (indexPath.row)
    {
        case 0:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"IOSAgenda"];
            break;
            
        case 1:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"IOSAgenda"];
            break;
            
        case 2:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"IOSAgenda"];
            break;
            
        case 3:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"IOSAgenda"];
            break;
            
        case 4:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"IOSAgenda"];
            break;
            
        case 5:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"IOSAgenda"];
            break;
    }
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc withSlideOutAnimation:YES andCompletion:nil];
    
}

- (IBAction)urllink:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://jets.iti.gov.eg/pageView/4371"]];
}
@end
