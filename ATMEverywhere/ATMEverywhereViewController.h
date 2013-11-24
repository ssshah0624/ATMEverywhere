//
//  ATMEverywhereViewController.h
//  ATMEverywhere
//
//  Created by Sunny Shah on 11/24/13.
//  Copyright (c) 2013 Sunny Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerCalls.h"

@interface ATMEverywhereViewController : UIViewController
@property IBOutlet UIImageView *pennImages;
- (IBAction)signInPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;

@end
