//
//  IOSUserView.m
//  DBProject
//
//  Created by Mahmoud El nagar on 4/4/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "IOSUserView.h"
#import "IOSAppDelegate.h"
#import "Sessions.h"
#import "Speaker.h"
#import "MobilesOfSpeakers.h"
#import "PhonesOfSpeakers.h"
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"



@interface IOSUserView ()

@end

@implementation IOSUserView{
    NSMutableData *d;
}




@synthesize managedObjectContext = _managedObjectContext;
//@synthesize managedObjectModel = _managedObjectModel;
//@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

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
	// Do any additional setup after loading the view.
    
    d = [NSMutableData new];

    printf("viewDidLoad \n");
    
    NSString *str = [[NSString alloc] initWithFormat:@"http://www.mobiledeveloperweekend.net/service/getSessions?userName=eng.medhat.cs.h@gmail.com"];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    [con start];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    if(d !=nil)
        [d appendData:data];
    else
        d = (NSMutableData*)data;
    
    printf("didReceiveData \n");
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
//
//    IOSAppDelegate *app =(IOSAppDelegate*) [[UIApplication sharedApplication] delegate];
//    _managedObjectContext =[app managedObjectContext];
    
    
    CoreDataManager *core = [CoreDataManager new];
    _managedObjectContext = core.managedObjectContext;
    
    
    
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:d options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *result = [dic objectForKey:@"result"];
//    NSDate *date = [result objectForKey:@"date"];
//    int maxSession = [[result objectForKey:@"maxSession"]integerValue];
    NSArray *agendas = [result objectForKey:@"agendas"];

    for (int i = 0; i<agendas.count; i++) {
        NSDictionary *mydic = agendas[i];
//        NSDate *sDate = [mydic objectForKey:@"date"];
        NSArray *sessions = [mydic objectForKey:@"sessions"];
        
        for (int x = 0; x<sessions.count; x++) {
        
            NSDictionary *s = [sessions objectAtIndex:x];
            
            Sessions *session = [NSEntityDescription insertNewObjectForEntityForName:@"Sessions" inManagedObjectContext:_managedObjectContext];
            
            session.name = [s objectForKey:@"name"];
//            if([s objectForKey:@"location"] != nil)
//                session.location = [s objectForKey:@"location"];
            session.id = [[s objectForKey:@"id"]integerValue];
            session.descrption = [s objectForKey:@"description"];
            session.type = [s objectForKey:@"sessionType"];
            session.like = [[s objectForKey:@"liked"]boolValue];
            
//            if([s objectForKey:@"sessionTags"] != nil)
//                session.tag = [s objectForKey:@"sessionTags"];
            
            
            
            
            
            
            
            if([s objectForKey:@"speakers"] != nil){
                
                NSArray *speakers = [s objectForKey:@"speakers"];
//
//                for (int y = 0; y<speakers.count; y++) {
//                    NSDictionary *sp = [speakers objectAtIndex:y];
//
//                    Speaker *speaker = [NSEntityDescription insertNewObjectForEntityForName:@"Speaker" inManagedObjectContext:_managedObjectContext];
//                    
//                    speaker.id = [[sp objectForKey:@"id"]integerValue];
//                    speaker.gender = [[sp objectForKey:@"genre"]boolValue];
//                    speaker.imgurl = [sp objectForKey:@"imageURL"];
//                    speaker.middleName = [sp objectForKey:@"middleName"];
//                    speaker.biography = [sp objectForKey:@"biography"];
//                    speaker.fristName = [sp objectForKey:@"firstName"];
//                    speaker.lastName = [sp objectForKey:@"lastName"];
//                    speaker.companyName = [sp objectForKey:@"companyName"];
//                    speaker.title = [sp objectForKey:@"title"];
//                    speaker.mobiles = nil;
//                    speaker.phones = nil;
//
//                    printf("\nSPEAKER NAME %s\n",[speaker.fristName UTF8String]);
//                    
//                    [session addSpeakersObject:speaker];
//
//                }

                
                
                //another way
                
                
                
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
                

            }

            
            
            
//            session.startDate = (NSDate*)[[s objectForKey:@"startDate"]];
//            session.endDate= (NSDate*)[[s objectForKey:@"endDate"]];
                            
                            
                            printf("\n%s \n%d \n%s \n%s \n%s \n%c",[session.name UTF8String],session.id,[session.descrption UTF8String],[session.type UTF8String],[session.location UTF8String],session.like);
        
            NSError *error = nil;
            [core insertModelError:&error];
            
            
            
            
            
            
            
            
            
            
            
            //insert static data
            
            
            
            
            
                            
                
        }

    }
}



@end

