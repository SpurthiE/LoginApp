//
//  LoginAppTests.m
//  LoginAppTests
//
//  Created by spurthi.eshwarappa on 07/03/22.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "Validation.h"

@interface LoginAppTests : XCTestCase
@property (nonatomic,strong) ViewController *loginVC;
@end

@implementation LoginAppTests
- (void)setUp {
    [super setUp];
    self.loginVC = [[ViewController alloc]init];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.loginVC = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.loginVC view];
    [_loginVC viewDidLoad];
    XCTAssertTrue(self.loginVC.viewLoaded);
}

- (void)tearDown {
    [super tearDown];
}

- (void)testLoginPressed {
    [_loginVC loginPressed:(_loginVC.loginButton)];
    _loginVC.emailTextField.text = @"spu@gmail.com";
    [_loginVC loginPressed:(_loginVC.loginButton)];
    _loginVC.emailTextField.text = @"com";
    [_loginVC loginPressed:(_loginVC.loginButton)];
    Validation *passwordValidaton = [[Validation alloc] init];
    _loginVC.emailTextField.text = @"spu@gmail.com";
    _loginVC.passwordTextField.text = @"abc";
    [passwordValidaton isValidPassword:_loginVC.passwordTextField.text];
    [_loginVC loginPressed:(_loginVC.loginButton)];
    _loginVC.emailTextField.text = @"spu@gmail.com";
    _loginVC.passwordTextField.text = @"Spu*15678xyz";
    [passwordValidaton isValidPassword:_loginVC.passwordTextField.text];
    [_loginVC loginPressed:(_loginVC.loginButton)];
}

- (void)testRegisterPressed {
    [_loginVC registerPressed:(_loginVC.registerButton)];
}
- (void)testValidateLoginDetails {
    [_loginVC validateLoginDetails];
}

@end
