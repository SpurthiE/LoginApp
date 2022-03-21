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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginPressed:(UIButton *)sender {
    Alert *alert = [[Alert alloc]init];
    PasswordValidation *passwordValidaton = [[PasswordValidation alloc] init];
    EmailValidation *emailvalidation = [[EmailValidation alloc] init];
    if (![_emailTextField.text  isEqual: @""]) {
        if ([emailvalidation validateEmailWithString:_emailTextField.text]) {
            if (![_passwordTextField.text  isEqual: @""]) {
                if ([passwordValidaton isValidPassword:_passwordTextField.text]) {
                    [self validateLoginDetails];
                } else {
                    [alert alertWithOneBtn:self title:@"Error" message:@"Please Ensure that you have at least one lower case letter, one upper case letter, one digit and one special"];
                }
            } else {
                [alert alertWithOneBtn:self title:@"Error" message:@"password field shouldn't be empty"];
            }
        } else {
            [alert alertWithOneBtn:self title:@"Error" message:@"Enter a valid email"];
        }
    } else {
        [alert alertWithOneBtn:self title:@"Error" message:@"Email field shouldn't be empty"];
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
            [alert alertWithOneBtn:self title:@"Alert" message:@"User Not Found"];
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
