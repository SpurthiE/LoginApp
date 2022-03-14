//
//  ViewController.m
//  LoginApp
//
//  Created by spurthi.eshwarappa on 07/03/22.
//

#import "ViewController.h"
#import "DescriptionViewController.h"
#import "RegistrationViewController.h"
#import "PasswordValidation.h"
#import "EmailValidation.h"
#import "Alert.h"
#import "KeychainItemWrapper.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    _emailTextField.text = @"";
    _passwordTextField.text = @"";
}
- (IBAction)loginPressed:(UIButton *)sender {
    Alert *alert = [[Alert alloc]init];
    if (![_emailTextField.text  isEqual: @""] && ![_passwordTextField.text  isEqual: @""]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"YourAppLogin" accessGroup:nil];
            NSData *password22 = [keychainItem objectForKey:(__bridge id)kSecValueData];
            NSString *emailData = [keychainItem objectForKey:(__bridge id)kSecAttrAccount];
            NSString* passwordValue = [[NSString alloc] initWithData:password22 encoding:NSUTF8StringEncoding];
            if ([self.emailTextField.text isEqual:emailData] && [self.passwordTextField.text isEqual:passwordValue]) {
                [self navigateToDescription];
                self.emailTextField.text = @"";
                self.passwordTextField.text = @"";
            } else {
                [alert alertWithOneBtn:self title:@"Alert" message:@"User Not Found"];
            }
        });
    } else {
        [alert alertWithOneBtn:self title:@"Error" message:@"Email and Password fields shouldn't be empty"];
    }
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
