//
//  ATMEverywhereViewController.m
//  ATMEverywhere
//
//  Created by Sunny Shah on 11/24/13.
//  Copyright (c) 2013 Sunny Shah. All rights reserved.
//

#import "ATMEverywhereViewController.h"

@interface ATMEverywhereViewController ()

@end

@implementation ATMEverywhereViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.email.delegate=self;
    self.password.delegate=self;
    
    self.pennImages = [[UIImageView alloc] initWithFrame:CGRectMake(20,100, 280, 200)];
    self.pennImages.image = [UIImage imageNamed:@"logo.png"];
    [self.pennImages setAlpha:0.0f];
    CALayer * layer = [self.pennImages layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:5.0];
    [self.view addSubview:self.pennImages];
    [UIView animateWithDuration:5.0 animations:^{
        self.pennImages.alpha = 0.7f;
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInPressed:(id)sender {
    if(self.email.text.length<=0){
        [self wrongEmail];
    }else{
        self.email.layer.borderColor = [[UIColor clearColor] CGColor];
        self.email.layer.borderWidth = 0.0;
    }
    
    if(self.password.text.length<=0){
        [self wrongPassword];
    }else{
        self.password.layer.borderColor = [[UIColor clearColor] CGColor];
        self.password.layer.borderWidth = 0.0;
    }

    if(self.email.text.length>0 && self.password.text.length>0){
        NSDictionary* dict = [[ServerCalls sharedServerCalls]signUpUserWithUserID:self.email.text andPassword:self.password.text];
        
        if(dict==NULL){
            NSLog(@"Null dictionary returned on login");
        }
        NSLog(@"DICTIONARY: %@",dict);
    }
    
}

-(void)wrongEmail{
    self.email.layer.borderColor = [[UIColor redColor] CGColor];
    self.email.layer.borderWidth = 3.0;
}

-(void)wrongPassword{
    self.password.layer.borderColor = [[UIColor redColor] CGColor];
    self.password.layer.borderWidth = 3.0;
}

//Textfield editing
#pragma mark TextFieldDelegates
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    if (textField==self.email) {
        [self performAnimations:160];
    }else if (textField==self.password) {
        [self performAnimations:210];
    }else{
        NSLog(@"ERROR");
    }
}

-(void)performAnimations:(float)bywhat
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame=CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y -bywhat), self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(textField==self.email){
        [self.password becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}


@end
