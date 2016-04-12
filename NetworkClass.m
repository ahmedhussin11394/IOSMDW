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
@implementation NetworkClass{
     NSDictionary *dictionary;
}

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
    NSString *string = @"http://www.mobiledeveloperweekend.net/MDW/service/getSessions?userName=eng.medhat.cs.h@gmail.com";
    
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
       
        for (int i=0; i<[agendas count]; i++) {
            
            NSMutableDictionary *agendaDict = [agendas objectAtIndex:i];
            Agenda *agenda=[Agenda new];
            NSString *dateString=[agendaDict objectForKey:@"date"];
            double getDate=[dateString doubleValue];
            NSTimeInterval seconds = getDate / 1000;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
            [agenda setDate:date];
            NSMutableArray *unParsedSessions=[NSMutableArray new];
            unParsedSessions=[agendaDict objectForKey:@"sessions"];
            NSMutableArray *arrayOfSessions=[NSMutableArray new];
            for (int i=0; i<[unParsedSessions count]; i++) {
                NSMutableDictionary *sessionDict = [unParsedSessions objectAtIndex:i];
                Sessions *session=[Sessions new];
                [session setName:[sessionDict objectForKey:@"name"]];
                [session setId:[[sessionDict objectForKey:@"id"] numberFromString:[sessionDict objectForKey:@"id"]]];
                [session setDescrption:[sessionDict objectForKey:@"description"]];
                [session setType:[sessionDict objectForKey:@"sessionType"]];
                if([[sessionDict objectForKey:@"like"] isEqualToString:@"true"])
                {
                    [session setLike:[NSNumber numberWithInt:1]];
                }
                else{
                    [session setLike:0];
                }
                
                [session setTag:[sessionDict objectForKey:@"sessionTags"]];
                [session setSpeakers:[sessionDict objectForKey:@"speakers"]];
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
                [arrayOfSessions addObject:session];
            }
            
            [agenda setAgendaSessions:arrayOfSessions];
            [arrayOfAgendas addObject:agenda];
        }
        
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
    NSString *string = @"http://www.mobiledeveloperweekend.net/MDW/service/getExhibitors?userName=eng.medhat.cs.h@gmail.com";
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
