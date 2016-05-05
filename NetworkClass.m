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
#import "MobilesOfExhiptors.h"
#import "PhonesOfExhiptors.h"
#import "User.h"
#import "CoreDataManager.h"
#import "Speaker.h"
#import "MobilesOfSpeakers.h"
#import "PhonesOfSpeakers.h"
#import "AllSpeakers.h"
#import "AllSpeakerPhone.h"
#import "AllSpeakersMobiles.h"
#import "UIImageView+AFNetworking.h"

@implementation NetworkClass{
     NSDictionary *dictionary;
}
@synthesize managedObjectContext = _managedObjectContext;


- (void)getSpeakers{
    //1
    
    // 2
    NSString *string = @"http://www.mobiledeveloperweekend.net/service/getSpeakers?userName=eng.medhat.cs.h@gmail.com";
    dictionary=[NSDictionary new];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        printf("network");
        dictionary= (NSDictionary *)responseObject;
        NSMutableArray *arrayOfResult = [dictionary objectForKey:@"result"];
        NSMutableArray *arrayOfSpeakers=[NSMutableArray new];
        //4
        CoreDataManager *core = [CoreDataManager new];
        _managedObjectContext = core.managedObjectContext;
        [core trunkateEntity:@"AllSpeakerPhone"];
        [core trunkateEntity:@"AllSpeakersMobiles"];
        [core trunkateEntity:@"AllSpeakers"];
        for (int i=0; i<[arrayOfResult count]; i++) {
            NSMutableDictionary *speakersDict = [arrayOfResult objectAtIndex:i];
            printf("test");
            AllSpeakers *speakers = [NSEntityDescription insertNewObjectForEntityForName: @"AllSpeakers"inManagedObjectContext:_managedObjectContext];
            
            
            // [speakers setId:[[speakersDict objectForKey:@"id"] integerValue]];
            [speakers setFristName:[speakersDict objectForKey:@"firstName"]];
            [speakers setLastName:[speakersDict objectForKey:@"lastName"]];
            [speakers setCompanyName:[speakersDict objectForKey:@"companyName"]];
            [speakers setTitle:[speakersDict objectForKey:@"title"]];
            ////////phones
            NSMutableArray *phonesArray=[NSMutableArray new];
            phonesArray=[speakersDict objectForKey:@"phones"];
            
            for(int i=0;i<phonesArray.count;i++){
                AllSpeakerPhone *phones=[NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakerPhone" inManagedObjectContext:_managedObjectContext];
                NSString *phone_num=phonesArray [i];
                [core saveManagedObject];
                phones.phonenum=phone_num;
                [speakers addPhonesObject:phones];
                [core saveManagedObject];
                
            }
            /////mobiles
            NSMutableArray *mobilesArray=[NSMutableArray new];
            phonesArray=[speakersDict objectForKey:@"mobiles"];
            
            for(int i=0;i<mobilesArray.count;i++){
                AllSpeakersMobiles *mobiles=[NSEntityDescription insertNewObjectForEntityForName:@"AllSpeakersMobiles" inManagedObjectContext:_managedObjectContext];
                NSString *mobile_num=mobilesArray[i];
                [core saveManagedObject];
                mobiles.mobilenum=mobile_num;
                [speakers addMobilesObject:mobiles];
                [core saveManagedObject];
            }
            
            [speakers setMiddleName:[speakersDict objectForKey:@"middleName"]];
            [speakers setBiography:[speakersDict objectForKey:@"biography"]];
            [speakers setGender:[speakersDict objectForKey:@"gender"]];
            [speakers setImgurl:[speakersDict objectForKey:@"imageURL"]];
            
            
            NSURL *url = [NSURL URLWithString:[speakersDict objectForKey:@"imageURL"]];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                speakers.img = data;
                [core saveManagedObject];
            }];
            
            

            
            [arrayOfSpeakers addObject:speakers];
            
        }
        [core saveManagedObject];
        [_myDelegate dataRecived:arrayOfSpeakers];
        
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


- (void)getSessions{
 

    NSString *string = @"http://www.mobiledeveloperweekend.net/service/getSessions?userName=eng.medhat.cs.h@gmail.com";
    
    dictionary=[NSDictionary new];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3

        dictionary= (NSDictionary *)responseObject;
        NSDictionary *dicOfResult = [dictionary objectForKey:@"result"];
        NSMutableArray *agendas=[dicOfResult objectForKey:@"agendas"];
        NSMutableArray *arrayOfAgendas=[NSMutableArray new];
        NSMutableArray *arrayOfSessions=[NSMutableArray new];
        
        CoreDataManager *core = [CoreDataManager new];
        _managedObjectContext = core.managedObjectContext;
        
        
        
        //trunkate tables before re filling
        [core trunkateEntity:@"PhonesOfSpeakers"];
        [core trunkateEntity:@"MobilesOfSpeakers"];
        [core trunkateEntity:@"Speaker"];
        [core trunkateEntity:@"Sessions"];
        [core trunkateEntity:@"Agenda"];

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
                        
                        NSURL *url = [NSURL URLWithString:[speakerDict objectForKey:@"imageURL"]];
                        NSURLRequest *request = [NSURLRequest requestWithURL:url];
                        
                        
                        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                            speaker.img = data;
                            [core saveManagedObject];
                        }];
                        
                        NSMutableArray *phonesArray=[NSMutableArray new];
                        phonesArray=[speakerDict objectForKey:@"phones"];
                        
                        for(int i=0;i<phonesArray.count;i++){
                            PhonesOfSpeakers *phones=[NSEntityDescription insertNewObjectForEntityForName:@"PhonesOfSpeakers" inManagedObjectContext:_managedObjectContext];
                            NSString *phone_num=phonesArray [i];
                            [core saveManagedObject];
                            phones.phonenum=phone_num;
                            [speaker addPhonesObject:phones];
                            [core saveManagedObject];
                            
                        }
                        /////mobiles
                        NSMutableArray *mobilesArray=[NSMutableArray new];
                        phonesArray=[speakerDict objectForKey:@"mobiles"];
                        
                        for(int i=0;i<mobilesArray.count;i++){
                            MobilesOfSpeakers *mobiles=[NSEntityDescription insertNewObjectForEntityForName:@"MobilesOfSpeakers" inManagedObjectContext:_managedObjectContext];
                            NSString *mobile_num=mobilesArray[i];
                            [core saveManagedObject];
                            mobiles.mobilenum=mobile_num;
                            [speaker addMobilesObject:mobiles];
                            [core saveManagedObject];
                        }
                        
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
        printf("network");
        dictionary= (NSDictionary *)responseObject;
        NSMutableArray *arrayOfResult = [dictionary objectForKey:@"result"];
        NSMutableArray *arrayOfExhiptors=[NSMutableArray new];
        CoreDataManager *core = [CoreDataManager new];
        _managedObjectContext = core.managedObjectContext;

        [core trunkateEntity:@"MobilesOfExhiptors"];
        [core trunkateEntity:@"PhonesOfExhiptors"];
        [core trunkateEntity:@"Exhiptors"];
        

        
        for (int i=0; i<[arrayOfResult count]; i++) {
            
            NSMutableDictionary *exhiptorDict = [arrayOfResult objectAtIndex:i];
            printf("test");
            
            Exhiptors *exhiptor = [NSEntityDescription insertNewObjectForEntityForName: @"Exhiptors"inManagedObjectContext:_managedObjectContext];
            
            
            //Exhiptors *exhiptor=[NSManagedObject new];
            [exhiptor setId:[[exhiptorDict objectForKey:@"id"] integerValue]];
            [exhiptor setImgurl:[exhiptorDict objectForKey:@"imageURL"]];
            
            
            
            NSURL *url = [NSURL URLWithString:[exhiptorDict objectForKey:@"imageURL"]];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                exhiptor.img = data;
                [core saveManagedObject];
            }];

            [exhiptor setCompanyAddress:[exhiptorDict objectForKey:@"companyAddress"]];
            [exhiptor setEmailExh:[exhiptorDict objectForKey:@"email"]];
            [exhiptor setCountryName:[exhiptorDict objectForKey:@"countryName"]];
            [exhiptor setCityName:[exhiptorDict objectForKey:@"cityName"]];
            [exhiptor setCompanyName:[exhiptorDict objectForKey:@"companyName"]];
            // [exhiptor setPhones:[exhiptorDict objectForKey:@"phones"]];
            // [exhiptor setMobiles:[exhiptorDict objectForKey:@"mobiles"]];
            [exhiptor setCompanyAbout:[exhiptorDict objectForKey:@"companyAbout"]];
            [exhiptor setFax:[exhiptorDict objectForKey:@"fax"]];
            [exhiptor setContactName:[exhiptorDict objectForKey:@"contactName"]];
            [exhiptor setCompanyUrl:[exhiptorDict objectForKey:@"companyUrl"]];
            
            NSMutableArray *phonesArray=[NSMutableArray new];
            phonesArray=[exhiptorDict objectForKey:@"phones"];
            
            for(int i=0;i<phonesArray.count;i++){
                PhonesOfExhiptors *phones=[NSEntityDescription insertNewObjectForEntityForName:@"PhonesOfExhiptors" inManagedObjectContext:_managedObjectContext];
                NSString *phone_num=phonesArray [i];
                NSError *error=nil;
                phones.phonenum=phone_num;
                [exhiptor addPhonesObject:phones];
                 [core saveManagedObject];
                
            }
            
            
            NSMutableArray *mobilesArray=[NSMutableArray new];
            phonesArray=[exhiptorDict objectForKey:@"mobiles"];
            
            for(int i=0;i<mobilesArray.count;i++){
                MobilesOfExhiptors *mobiles=[NSEntityDescription insertNewObjectForEntityForName:@"MobilesOfExhiptors" inManagedObjectContext:_managedObjectContext];
                NSString *mobile_num=mobilesArray[i];
                NSError *error=nil;
                mobiles.mobilenum=mobile_num;
                [exhiptor addMobilesObject:mobiles];
                 [core saveManagedObject];
                
            }
            
            [arrayOfExhiptors addObject:exhiptor];
            [core saveManagedObject];
            
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
    
    
    CoreDataManager *core = [CoreDataManager new];
    _managedObjectContext = core.managedObjectContext;
    
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
        User *user= [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:_managedObjectContext];
        
        [user setCode:[userDic objectForKey:@"code"]];
        [user setTitle:[userDic objectForKey:@"title"]];
        [user setMiddleName:[userDic objectForKey:@"middleName"]];
        [user setCompanyName:[userDic objectForKey:@"companyName"]];
       // [user setPhones:[NSSet setWithArray:[userDic objectForKey:@"phones"]]];
       //[user setMobiles:[NSSet setWithArray:[userDic objectForKey:@"mobiles"]]];
        [user setEmail:[userDic objectForKey:@"email"]];
        [user setFirstName:[userDic objectForKey:@"firstName"]];
        [user setLastName:[userDic objectForKey:@"lastName"]];
        [user setImgurl:[userDic objectForKey:@"imageURL"]];
        [core saveManagedObject];
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
