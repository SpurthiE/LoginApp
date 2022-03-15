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

@interface RegistrationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
}
- (IBAction)registerPressed:(UIButton *)sender {
    Alert *alert = [[Alert alloc]init];
    PasswordValidation *passwordValidaton = [[PasswordValidation alloc] init];
    EmailValidation *emailvalidation = [[EmailValidation alloc] init];
    if (![_emailTextField.text  isEqual: @""]) {
        if ([emailvalidation validateEmailWithString:_emailTextField.text]) {
            if (![_passwordTextField.text  isEqual: @""]) {
                if ([passwordValidaton isValidPassword:_passwordTextField.text]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [alert alertWithOneBtn:self title:@"Error" message:@"Registration Successful"];
                        KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"YourAppLogin" accessGroup:nil];
                        [keychainItem setObject:self.passwordTextField.text forKey:(__bridge id)kSecValueData];
                        [keychainItem setObject:self.emailTextField.text forKey:(__bridge id)kSecAttrAccount];
                        self.emailTextField.text = @"";
                        self.passwordTextField.text = @"";
                        self.nameTextField.text = @"";
                    });
                } else {
                    [alert alertWithOneBtn:self title:@"Error" message:@"Please Ensure that you have at least one lower case letter, one upper case letter, one digit and one special charcter"];
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

-(void)navigateToDescription {
    DescriptionViewController *toDoList = [self.storyboard instantiateViewControllerWithIdentifier:@"DescriptionViewController"];
    [self.navigationController pushViewController:toDoList animated:true];
}

@end
