//
//  DescriptionViewController.m
//  LoginApp
//
//  Created by spurthi.eshwarappa on 09/03/22.
//

#import "DescriptionViewController.h"
#import "KeychainItemWrapper.h"
#import "NetworkApi.h"

@interface DescriptionViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavBar];
    self.tableView.dataSource = self;
    [self fetchDataFromModel];
}

- (void)configureNavBar {
  // 1. create an image for the bar button item
  UIImage *image = [UIImage systemImageNamed:@"plus"];
  
  // 2. create bar button item
  UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithImage:image  style:UIBarButtonItemStylePlain target: self action:@selector(addItem)];
    UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutButtonAction)];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:plusButton,logout, nil] animated:false];
  // 3. set the "plusButton" as the right bar button item
  self.navigationItem.rightBarButtonItem = plusButton;
  self.navigationItem.title = @"User Details";
}

-(void) logoutButtonAction {
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"YourAppLogin" accessGroup:nil];
    [keychainItem resetKeychainItem];
    [self.navigationController popViewControllerAnimated:true];
}

-(void) fetchDataFromModel {
    NetworkApi *dataObj = [[NetworkApi alloc]init];
    [dataObj fetchdata:^(NSMutableArray * results, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            self.dataArray = results;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    NSString *fullName = self.dataArray[indexPath.row][@"name"][@"first"];
    cell.textLabel.text = fullName;
    cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle2];
    cell.detailTextLabel.text = self.dataArray[indexPath.row][@"gender"];
    return cell;
}
@end
