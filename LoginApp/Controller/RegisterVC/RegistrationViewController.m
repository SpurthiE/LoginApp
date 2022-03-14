//
//  RegistrationViewController.m
//  LoginApp
//
//  Created by spurthi.eshwarappa on 07/03/22.
//

#import "RegistrationViewController.h"
#import "DescriptionViewController.h"
#import "PasswordValidation.h"
#import "EmailValidation.h"
#import "Alert.h"
#import "KeychainItemWrapper.h"

@interface RegistrationViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
}
- (IBAction)registerPressed:(UIButton *)sender {
    Alert *alert = [[Alert alloc]init];
    PasswordValidation *passwordValidaton = [[PasswordValidation alloc] init];
    if (![_emailTextField.text  isEqual: @""] && ![_passwordTextField.text  isEqual: @""]) {
        if ([passwordValidaton isValidPassword:_passwordTextField.text] ) {
            dispatch_async(dispatch_get_main_queue(), ^{
                KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"YourAppLogin" accessGroup:nil];
                [keychainItem setObject:self.passwordTextField.text forKey:(__bridge id)kSecValueData];
                [keychainItem setObject:self.emailTextField.text forKey:(__bridge id)kSecAttrAccount];
                self.emailTextField.text = @"";
                self.passwordTextField.text = @"";
            });
        } else {
            [alert alertWithOneBtn:self title:@"Error" message:@"Please Ensure that you have at least one lower case letter, one upper case letter, one digit and one special"];
        }
    } else {
        [alert alertWithOneBtn:self title:@"Error" message:@"Email and Password fields shouldn't be empty"];
    }
}

-(void)navigateToDescription {
    DescriptionViewController *toDoList = [self.storyboard instantiateViewControllerWithIdentifier:@"DescriptionViewController"];
    [self.navigationController pushViewController:toDoList animated:true];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSString *password = _passwordTextField.text;
    NSString *email = _emailTextField.text;
    Alert *alert = [[Alert alloc]init];
    EmailValidation *emailvalidation = [[EmailValidation alloc] init];
    PasswordValidation *passwordValidaton = [[PasswordValidation alloc] init];
    if ([textField isEqual: _emailTextField]) {
        if (![_emailTextField.text  isEqual: @""]) {
            if ([emailvalidation validateEmailWithString:email]) {
                return true;
            } else {
                [alert alertWithOneBtn:self title:@"Error" message:@"Enter a valid email"];
                return false;
            }
        } else {
            textField.text = @"Type something";
            return false;
        }
    } else {
        if (![_passwordTextField.text  isEqual: @""]) {
            if ([passwordValidaton isValidPassword:password]) {
                return true;
            } else {
                [alert alertWithOneBtn:self title:@"Error" message:@"Please Ensure that you have at least one lower case letter, one upper case letter, one digit and one special"];
                return false;
            }
        } else {
            return false;
        }
    }
}
@end
