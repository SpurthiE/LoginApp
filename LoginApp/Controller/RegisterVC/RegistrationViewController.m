//
//  RegistrationViewController.m
//  LoginApp
//
//  Created by spurthi.eshwarappa on 07/03/22.
//

#import "RegistrationViewController.h"
#import "Validation.h"
#import "Alert.h"
#import "KeychainItemWrapper.h"
#import "Constants.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
}

- (IBAction)registerPressed:(UIButton *)sender {
    Alert *alert = [[Alert alloc]init];
    Validation *passwordValidaton = [[Validation alloc] init];
    Validation *emailvalidation = [[Validation alloc] init];
    if (![_emailTextField.text  isEqual: blankString]) {
        if ([emailvalidation isValidEmail:_emailTextField.text]) {
            if (![_passwordTextField.text  isEqual: blankString]) {
                if ([passwordValidaton isValidPassword:_passwordTextField.text]) {
                    [self storeRegisteredDetails];
                    [alert alertWithOneBtn:self title:sucess message:regSucess];
                } else {
                    [alert alertWithOneBtn:self title:error message:validate_Password_Message];
                }
            } else {
                [alert alertWithOneBtn:self title:error message:blank_Password];
            }
        } else {
            [alert alertWithOneBtn:self title:error message:validate_Email];
        }
    } else {
        [alert alertWithOneBtn:self title:error message:blank_Email];
    }
}

-(void)storeRegisteredDetails {
    dispatch_async(dispatch_get_main_queue(), ^{
        KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"YourAppLogin" accessGroup:nil];
        [keychainItem setObject:self.passwordTextField.text forKey:(__bridge id)kSecValueData];
        [keychainItem setObject:self.emailTextField.text forKey:(__bridge id)kSecAttrAccount];
        self.emailTextField.text = blankString;
        self.passwordTextField.text = blankString;
        self.nameTextField.text = blankString;
    });
}
@end
