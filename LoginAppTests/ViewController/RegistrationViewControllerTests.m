//
//  RegistrationViewControllerTests.m
//  LoginAppTests
//
//  Created by spurthi.eshwarappa on 24/03/22.
//

#import <XCTest/XCTest.h>
#import "RegistrationViewController.h"
#import "Validation.h"

@interface RegistrationViewControllerTests : XCTestCase
@property (nonatomic,strong) RegistrationViewController *regVC;
@end

@implementation RegistrationViewControllerTests

- (void)setUp {
    [super setUp];
    self.regVC = [[RegistrationViewController alloc]init];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.regVC = [sb instantiateViewControllerWithIdentifier:@"RegistrationViewController"];
    [self.regVC view];
    [_regVC viewDidLoad];
    XCTAssertTrue(self.regVC.viewLoaded);
}

- (void)tearDown {
    [super tearDown];
}

- (void)testRegisterPressed {
    [_regVC registerPressed:(_regVC.registerBtn)];
    _regVC.emailTextField.text = @"spu@gmail.com";
    [_regVC registerPressed:(_regVC.registerBtn)];
    _regVC.emailTextField.text = @"com";
    [_regVC registerPressed:(_regVC.registerBtn)];
    Validation *passwordValidaton = [[Validation alloc] init];
    _regVC.emailTextField.text = @"spu@gmail.com";
    _regVC.passwordTextField.text = @"abc";
    [passwordValidaton isValidPassword:_regVC.passwordTextField.text];
    [_regVC registerPressed:(_regVC.registerBtn)];
    _regVC.emailTextField.text = @"spu@gmail.com";
    _regVC.passwordTextField.text = @"Spu*15678xyz";
    [passwordValidaton isValidPassword:_regVC.passwordTextField.text];
    [_regVC registerPressed:(_regVC.registerBtn)];    
}

@end
