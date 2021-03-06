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

- (void)addItem {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"ActionSheet"
        message:@"Action Sheet example using UIAlertController "
        preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                    style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Cancel button tapped");
        [self dismissViewControllerAnimated:YES
                                 completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"To Do List"style:UIAlertActionStyleDestructive
                                                  handler:^(UIAlertAction
                                                            *action) {
        NSLog(@"To Do List button tapped");
        [self dismissViewControllerAnimated:YES
                                 completion:^{
        }];
    }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
    
    
    
//    // 1. initialize an alert controller
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add a new to do list item" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//
//    // 2. add two text fields to the alert controller
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        // code here
//    }];
//
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        // code here
//    }];
//
//    // 3. add placeholder text to the text fields
//    alertController.textFields[0].placeholder = @"Enter the name of the item";
//    alertController.textFields[1].placeholder = @"Enter the topic";
//
//    // 4. define action items "Cancel" and "Save"
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        // handler code here
//    }];
//
//    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        // handler code here
//        // 1. insert the new item
//        NSString *name = alertController.textFields[0].text;
//        NSString *topic = alertController.textFields[1].text;
//        Item *newItem = [[Item alloc] initWithName:name andWithTopic:topic];
//        [self.items addObject:newItem];
//
//        // 2. create an indexpath a the end of items array
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.items.count - 1 inSection:0];
//
//        // 3. insert indexpath into table view
//        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }];
//    // 5. add actions to the alert controller
//    [alertController addAction:cancelAction];
//    [alertController addAction:saveAction];
//    [self presentViewController:alertController animated:true completion:nil];
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
