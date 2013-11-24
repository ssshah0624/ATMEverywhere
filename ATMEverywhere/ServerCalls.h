//
//  ServerCalls.h
//  ATMEverywhere
//
//  Created by Sunny Shah on 11/24/13.
//  Copyright (c) 2013 Sunny Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServerCalls : UIViewController

/*
 Initialize this class to serve as a shared repo for server call functions
 */

+ (ServerCalls *)sharedServerCalls;

-(NSDictionary*)signUpUserWithUserID:(NSString*)userID
                         andPassword:(NSString*)password;

@end
