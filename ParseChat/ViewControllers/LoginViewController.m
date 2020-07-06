//
//  LoginViewController.m
//  ParseChat
//
//  Created by zurken on 7/6/20.
//  Copyright © 2020 FacebookUniversity. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)tappedSignUp:(id)sender {
    if ([self.usernameField.text isEqual:@""]) {
        UIAlertController *usernameAlert = [UIAlertController alertControllerWithTitle:@"Userrname Required" message:@"In order to create an account you must provide a username." preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        [usernameAlert addAction:okAction];
        
        [self presentViewController:usernameAlert animated:YES completion:^{}];
    }
    else if ([self.passwordField.text isEqual:@""]) {
        UIAlertController *passwordAlert = [UIAlertController alertControllerWithTitle:@"Psassword Required" message:@"In order to create an account you must provide a password." preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        [passwordAlert addAction:okAction];
        
        [self presentViewController:passwordAlert animated:YES completion:^{}];
    }
    else {
        [self registerUser];
    }
}

- (IBAction)tappedLogin:(id)sender {
    if ([self.usernameField.text isEqual:@""]) {
        UIAlertController *usernameAlert = [UIAlertController alertControllerWithTitle:@"Userrname Required" message:@"In order to login you must provide a username." preferredStyle:(UIAlertControllerStyleAlert)];
               
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        [usernameAlert addAction:okAction];
           
        [self presentViewController:usernameAlert animated:YES completion:^{}];
    }
    else if ([self.passwordField.text isEqual:@""]) {
        UIAlertController *passwordAlert = [UIAlertController alertControllerWithTitle:@"Psassword Required" message:@"In order to login you must provide a password." preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        [passwordAlert addAction:okAction];
        
        [self presentViewController:passwordAlert animated:YES completion:^{}];
    }
    else {
        [self loginUser];
    }
}

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            
            if (error.code == 202) { // account already exists
                UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:@"Account Error" message:@"Account already exists for this username." preferredStyle:(UIAlertControllerStyleAlert)];
                       
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
                [loginAlert addAction:okAction];
                   
                [self presentViewController:loginAlert animated:YES completion:^{}];
            }
        } else {
           // NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"ChatSegue" sender:nil];
        }
    }];
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            
            if (error.code == 101) {// incorrect username/password
                UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:@"Invalid Login" message:@"Username and password combination is invalid." preferredStyle:(UIAlertControllerStyleAlert)];
                       
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
                [loginAlert addAction:okAction];
                   
                [self presentViewController:loginAlert animated:YES completion:^{}];
            }
        } else {
            // NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"ChatSegue" sender:nil];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
