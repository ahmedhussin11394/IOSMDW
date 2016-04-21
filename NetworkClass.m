//
//  NetworkClass.m
//  AFNetworkingTest
//
//  Created by JETS on 4/3/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "NetworkClass.h"
#import "AFNetworking.h"
#import "Agenda.h"
#import "Sessions.h"
#import "Exhiptors.h"
#import "User.h"
#import "CoreDataManager.h"
#import "Speaker.h"
#import "MobilesOfSpeakers.h"
#import "PhonesOfSpeakers.h"

@implementation NetworkClass{
     NSDictionary *dictionary;
}
@synthesize managedObjectContext = _managedObjectContext;


- (NSDictionary *)getSpeakers{
    // 1
    NSString *string = @"http://www.mobiledeveloperweekend.net/MDW/service/getSpeakers?userName=moh.said511@gmail.com";
    printf("ahmed__");
    dictionary=[NSDictionary new];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
       
        dictionary= (NSDictionary *)responseObject;
        NSLog([dictionary objectForKey:@"status"]);
        [_myDelegate dataRecived:dictionary];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
    return dictionary;

}

- (void)getSessions{
    CoreDataManager *core = [CoreDataManager new];
    _managedObjectContext = core.managedObjectContext;
    
    
    
    //trunkate tables before re filling
    [core trunkateEntity:@"PhonesOfSpeakers"];
    [core trunkateEntity:@"MobilesOfSpeakers"];
    [core trunkateEntity:@"Speaker"];
    [core trunkateEntity:@"Sessions"];
    [core trunkateEntity:@"Agenda"];

    NSString *string = @"http://www.mobiledeveloperweekend.net/service/getSessions?userName=eng.medhat.cs.h@gmail.com";
    
    dictionary=[NSDictionary new];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        printf("\nkeda ahmed gab data  %d \n",2);

        dictionary= (NSDictionary *)responseObject;
        NSDictionary *dicOfResult = [dictionary objectForKey:@"result"];
        NSMutableArray *agendas=[dicOfResult objectForKey:@"agendas"];
        NSMutableArray *arrayOfAgendas=[NSMutableArray new];
        NSMutableArray *arrayOfSessions=[NSMutableArray new];


        for (int x=0; x<[agendas count]; x++) {
            
            NSMutableDictionary *agendaDict = [agendas objectAtIndex:x];
            
            Agenda *agenda= [NSEntityDescription insertNewObjectForEntityForName:@"Agenda" inManagedObjectContext:_managedObjectContext];
            
            NSString *dateString=[agendaDict objectForKey:@"date"];
            
            double getDate=[dateString doubleValue];
            NSTimeInterval seconds = getDate / 1000;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
            [agenda setDate:date];
            NSMutableArray *unParsedSessions=[NSMutableArray new];
            unParsedSessions=[agendaDict objectForKey:@"sessions"];
            

            for (int i=0; i<[unParsedSessions count]; i++) {
                NSMutableDictionary *sessionDict = [unParsedSessions objectAtIndex:i];
                
                Sessions *session= [NSEntityDescription insertNewObjectForEntityForName:@"Sessions" inManagedObjectContext:_managedObjectContext];
                
                printf("\nparse json  %d %d \n",x,i);
                
                [session setName:[sessionDict objectForKey:@"name"]];
//                [session setId:[[sessionDict objectForKey:@"id"] numberFromString:[sessionDict objectForKey:@"id"]]];
                [session setDescrption:[sessionDict objectForKey:@"description"]];
                [session setType:[sessionDict objectForKey:@"sessionType"]];
                if([[sessionDict objectForKey:@"like"] isEqualToString:@"true"])
                {
                    [session setLike:[NSNumber numberWithInt:1]];
                }
                else{
                    [session setLike:0];
                }
                
//                [session setTag:[sessionDict objectForKey:@"sessionTags"]];
                [session setLocation:[sessionDict objectForKey:@"location"]];
                dateString=[sessionDict objectForKey:@"startDate"];
                getDate=[dateString doubleValue];
                seconds = getDate / 1000;
                date = [NSDate dateWithTimeIntervalSince1970:seconds];
                [session setStartDate:date];
                dateString=[sessionDict objectForKey:@"endDate"];
                getDate=[dateString doubleValue];
                seconds = getDate / 1000;
                date = [NSDate dateWithTimeIntervalSince1970:seconds];
                [session setEndDate:date];
                
                
                NSMutableArray *speakers=[sessionDict objectForKey:@"speakers"];
                if ((id)speakers != [NSNull null]) {
                    NSMutableArray *sp = [NSMutableArray new];
                    for (int a = 0; a<speakers.count; a++) {
                        NSMutableDictionary *speakerDict = [speakers objectAtIndex:a];
                        
                        Speaker *speaker = [NSEntityDescription insertNewObjectForEntityForName:@"Speaker" inManagedObjectContext:_managedObjectContext];
//                       [speaker setId:[[speakerDict objectForKey:@"id"]numberFromString:[speakerDict objectForKey:@"id"]]];
                        [speaker setGender:(Boolean)[speakerDict objectForKey:@"gender"]];

                        speaker.imgurl = [speakerDict objectForKey:@"imageURL"];
                        speaker.middleName = [speakerDict objectForKey:@"middleName"];
                        speaker.biography = [speakerDict objectForKey:@"biography"];
                        speaker.fristName = [speakerDict objectForKey:@"firstName"];
                        speaker.lastName = [speakerDict objectForKey:@"lastName"];
                        speaker.companyName = [speakerDict objectForKey:@"companyName"];
                        speaker.title = [speakerDict objectForKey:@"title"];
                        
                        //                    MobilesOfSpeakers *m = [NSEntityDescription insertNewObjectForEntityForName:@"MobilesOfSpeakers" inManagedObjectContext:_managedObjectContext];
                        //                    [m setMobilenum:@"01203265"];
                        //
                        //                    MobilesOfSpeakers *m1 = [NSEntityDescription insertNewObjectForEntityForName:@"MobilesOfSpeakers" inManagedObjectContext:_managedObjectContext];
                        //                    [m1 setMobilenum:@"010352369"];
                        //
                        //
                        //                    PhonesOfSpeakers *p = [NSEntityDescription insertNewObjectForEntityForName:@"PhonesOfSpeakers" inManagedObjectContext:_managedObjectContext];
                        //                    [p setPhonenum:@"0456982365"];
                        //                    PhonesOfSpeakers *p1 = [NSEntityDescription insertNewObjectForEntityForName:@"PhonesOfSpeakers" inManagedObjectContext:_managedObjectContext];
                        //                    [p1 setPhonenum:@"0103265"];
                        //                    
                        //                    [speaker addMobiles:[NSSet setWithObjects:m,m1, nil]];
                        //                    [speaker addPhones:[NSSet setWithObjects:p,p1, nil]];
                        
                        [core saveManagedObject];
                        [sp addObject:speaker];
                    }
                    session.speakers = [NSSet setWithArray:sp];
                    [core saveManagedObject];
                    
                }
                
                
                
                
                
                
                
//                NSMutableArray *a = [NSMutableArray new];
//                [a addObject:speaker];
//                session.speakers = [NSSet setWithArray:a];
                [arrayOfSessions addObject:session];
                [agenda addAgendaSessionsObject:session];
                [core saveManagedObject];
                
            }
            [arrayOfAgendas addObject:agenda];
        }
//        [core saveManagedObject];

        [_myDelegate dataRecived:arrayOfAgendas];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
}


-(void)getExhiptors{
    // 1
    NSString *string = @"http://www.mobiledeveloperweekend.net/service/getExhibitors?userName=eng.medhat.cs.h@gmail.com";
    printf("ahmed__");
    dictionary=[NSDictionary new];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        
        dictionary= (NSDictionary *)responseObject;
        NSMutableArray *arrayOfResult = [dictionary objectForKey:@"result"];
        NSMutableArray *arrayOfExhiptors=[NSMutableArray new];
        
        for (int i=0; i<[arrayOfResult count]; i++) {
            
            NSMutableDictionary *exhiptorDict = [arrayOfResult objectAtIndex:i];
            Exhiptors *exhiptor=[Exhiptors new];
            [exhiptor setId:[[exhiptorDict objectForKey:@"id"] integerValue]];
            [exhiptor setImgurl:[exhiptorDict objectForKey:@"imageURL"]];
            [exhiptor setCompanyAddress:[exhiptorDict objectForKey:@"companyAddress"]];
            [exhiptor setEmailExh:[exhiptorDict objectForKey:@"email"]];
            [exhiptor setCountryName:[exhiptorDict objectForKey:@"countryName"]];
            [exhiptor setCityName:[exhiptorDict objectForKey:@"cityName"]];
            [exhiptor setCompanyName:[exhiptorDict objectForKey:@"companyName"]];
            [exhiptor setPhones:[exhiptorDict objectForKey:@"phones"]];
            [exhiptor setMobiles:[exhiptorDict objectForKey:@"mobiles"]];
            [exhiptor setCompanyAbout:[exhiptorDict objectForKey:@"companyAbout"]];
            [exhiptor setFax:[exhiptorDict objectForKey:@"fax"]];
            [exhiptor setContactName:[exhiptorDict objectForKey:@"contactName"]];
            [exhiptor setCompanyUrl:[exhiptorDict objectForKey:@"companyUrl"]];
            [arrayOfExhiptors addObject:exhiptor];
        }

        [_myDelegate dataRecived:arrayOfExhiptors];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
}


-(void)loginWithName:(NSString *)name andPassword:(NSString *)pass{
    // 1
    NSString *string =[NSString stringWithFormat:@"http://www.mobiledeveloperweekend.net/service/login?userName=%@&password=%@",name,pass];
    dictionary=[NSDictionary new];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        
        dictionary= (NSDictionary *)responseObject;
         NSMutableDictionary *userDic = [responseObject objectForKey:@"result"];
        User *user=[User new];
        [user setId:[[userDic objectForKey:@"id"] numberFromString:[userDic objectForKey:@"id"]]];
        [user setCode:[userDic objectForKey:@"code"]];
        [user setTitle:[userDic objectForKey:@"title"]];
        [user setMiddleName:[userDic objectForKey:@"middleName"]];
        [user setCityName:[userDic objectForKey:@"cityName"]];
        [user setCompanyName:[userDic objectForKey:@"companyName"]];
        [user setPhones:[userDic objectForKey:@"phones"]];
        [user setMobiles:[userDic objectForKey:@"mobiles"]];
        [user setEmail:[userDic objectForKey:@"email"]];
        [user setFirstName:[userDic objectForKey:@"firstName"]];
        [user setLastName:[userDic objectForKey:@"lastName"]];
        [user setImgurl:[userDic objectForKey:@"imageURL"]];
       NSString* dateString=[userDic objectForKey:@"birthDate"];
        double getDate=[dateString doubleValue];
        double seconds = getDate / 1000;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
        [_myDelegate setUser:user];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
}
@end
