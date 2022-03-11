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
    if (![_emailTextField.text  isEqual: @""] && ![_passwordTextField.text  isEqual: @""]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self navigateToDescription];
        });
    } else {
        Alert *alert = [[Alert alloc]init];
        [alert alertWithOneBtn:self title:@"Error" message:@"Email and Password fields shouldn't be empty"];
    }
}

-(void)navigateToDescription {
    DescriptionViewController *toDoList = [self.storyboard instantiateViewControllerWithIdentifier:@"DescriptionViewController"];
    [self.navigationController pushViewController:toDoList animated:true];
}
#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *password = _passwordTextField.text;
    NSString *email = _emailTextField.text;
    Alert *alert = [[Alert alloc]init];
    EmailValidation *emailvalidation = [[EmailValidation alloc] init];
    PasswordValidation *passwordValidaton = [[PasswordValidation alloc] init];
    if ([textField isEqual: _emailTextField]) {
        if ([emailvalidation validateEmailWithString:email]) {
            NSLog(@"email");
        } else {
            [alert alertWithOneBtn:self title:@"Error" message:@"Enter a valid email"];
        }
    } else {
        if ([passwordValidaton isValidPassword:password]) {
            NSLog(@"email");
        } else {
            [alert alertWithOneBtn:self title:@"Error" message:@"Please Ensure that you have at least one lower case letter, one upper case letter, one digit and one special"];
        }
    }
    
}
@end
