//
//  ServerCalls.m
//  ATMEverywhere
//
//  Created by Sunny Shah on 11/24/13.
//  Copyright (c) 2013 Sunny Shah. All rights reserved.
//

#import "ServerCalls.h"

@interface ServerCalls ()

@end

@implementation ServerCalls

/*
 Initialize this class to serve as a shared repo for server call functions
 */
static ServerCalls * _sharedInstance = nil;
+ (ServerCalls *)sharedServerCalls
{
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

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
}

-(NSDictionary*)signUpUserWithUserID:(NSString*)userID
                         andPassword:(NSString*)password
{
    NSError *error;
    NSString *email = userID;
    NSString *pass = password;
    
    NSDictionary *loginUser =  [[NSDictionary alloc] initWithObjectsAndKeys:
                                email, @"email",
                                pass, @"password",
                                nil];
    NSData *jsonData1 = [NSJSONSerialization dataWithJSONObject:loginUser
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:&error];
    if (!jsonData1) {
        NSLog(@"Got an error: %@", error);
    }else {
        NSString *jsonString1 = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        NSLog(@"json information: %@",jsonString1);
    }
    
    NSURL *yourURL1 = [NSURL URLWithString:@"http://ec2-54-221-23-146.compute-1.amazonaws.com:8000/login"];
    NSMutableURLRequest *yourRequest1 = [NSMutableURLRequest requestWithURL:yourURL1
                                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:5.0];
    [yourRequest1 setHTTPMethod:@"POST"];
    [yourRequest1 setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [yourRequest1 setHTTPBody:jsonData1];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *response = [NSURLConnection sendSynchronousRequest:yourRequest1 returningResponse:&urlResponse error:&requestError];
    if (response == nil) {
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"Sign up failure!", @"errors", nil];
        return dict;
    }
    NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    if (responseString == nil) {
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"Network not found!", @"errors", nil];
        return dict;
    }
    NSLog(@"response string: %@",responseString);
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    /*
     NSString* loginResult = [dictionary objectForKey:@"login"];
     if([loginResult isEqualToString:@"success!"]){
     NSLog(@"Login successful!");
     return TRUE;
     }else{
     NSLog(@"Login not successful!");
     return FALSE;
     }
     NSLog(@"Login Result: %@",loginResult);
     */
    return dictionary;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
