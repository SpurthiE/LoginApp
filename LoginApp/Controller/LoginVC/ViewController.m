//
//  ViewController.m
//  LoginApp
//
//  Created by spurthi.eshwarappa on 07/03/22.
//

#import "ViewController.h"
#import "DescriptionViewController.h"
#import "RegistrationViewController.h"
#import "Validation.h"
#import "Alert.h"
#import "KeychainItemWrapper.h"
#import "Constants.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginPressed:(UIButton *)sender {
    Alert *alert = [[Alert alloc]init];
    Validation *passwordValidaton = [[Validation alloc] init];
    Validation *emailvalidation = [[Validation alloc] init];
    if (![_emailTextField.text  isEqual: blankString]) {
        if ([emailvalidation isValidEmail:_emailTextField.text]) {
            if (![_passwordTextField.text  isEqual: blankString]) {
                if ([passwordValidaton isValidPassword:_passwordTextField.text]) {
                    [self validateLoginDetails];
                } else {
                    [alert alertWithOneBtn:self title: error message:validate_Password_Message];
                }
            } else {
                [alert alertWithOneBtn:self title:error message:blank_Password];
            }
        } else {
            [alert alertWithOneBtn:self title:error message: validate_Email];
        }
    } else {
        [alert alertWithOneBtn:self title:error message:blank_Email];
    }
}

-(void)validateLoginDetails {
    Alert *alert = [[Alert alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"YourAppLogin" accessGroup:nil];
        NSData *password22 = [keychainItem objectForKey:(__bridge id)kSecValueData];
        NSString *emailData = [keychainItem objectForKey:(__bridge id)kSecAttrAccount];
        NSString* passwordValue = [[NSString alloc] initWithData:password22 encoding:NSUTF8StringEncoding];
        if ([self.emailTextField.text isEqual:emailData] && [self.passwordTextField.text isEqual:passwordValue]) {
            [self navigateToDescription];
        } else {
            [alert alertWithOneBtn:self title:alertMessage message:userNotFound];
        }
    });

}

- (IBAction)registerPressed:(UIButton *)sender {
    [self navigateToRegistration];
    
}
-(void)navigateToRegistration {
    RegistrationViewController *registerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationViewController"];
    [self.navigationController pushViewController:registerVC animated:true];
}

-(void)navigateToDescription {
    DescriptionViewController *toDoList = [self.storyboard instantiateViewControllerWithIdentifier:@"DescriptionViewController"];
    [self.navigationController pushViewController:toDoList animated:true];
}

@end
