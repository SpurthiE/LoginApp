//
//  DescriptionViewControllerTests.m
//  LoginAppTests
//
//  Created by spurthi.eshwarappa on 24/03/22.
//

#import <XCTest/XCTest.h>
#import "DescriptionViewController.h"

@interface DescriptionViewControllerTests : XCTestCase
@property (nonatomic,strong) DescriptionViewController *descVC;
@end

@implementation DescriptionViewControllerTests

- (void)setUp {
    [super setUp];
    self.descVC = [[DescriptionViewController alloc]init];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.descVC = [sb instantiateViewControllerWithIdentifier:@"DescriptionViewController"];
    [_descVC view];
    [_descVC viewDidLoad];
    XCTAssertTrue(_descVC.viewLoaded);
}

- (void)tearDown {
    [super tearDown];
}

- (void)testLogoutButtonAction {
    [_descVC logoutButtonAction];
}

-(void)testnumberOfRowsInSection {
    [_descVC.tableView numberOfRowsInSection:_descVC.dataArray.count];
}

@end
