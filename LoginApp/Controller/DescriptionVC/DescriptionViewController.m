//
//  DescriptionViewController.m
//  LoginApp
//
//  Created by spurthi.eshwarappa on 09/03/22.
//

#import "DescriptionViewController.h"
#import "KeychainItemWrapper.h"

@interface DescriptionViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureNavBar];
    self.tableView.dataSource = self;
    [self fetchData];
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
  self.navigationItem.title = @"To do list";
}

-(void) logoutButtonAction {
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"YourAppLogin" accessGroup:nil];
    [keychainItem resetKeychainItem];
    [self.navigationController popViewControllerAnimated:true];
}

-(void) fetchData {
    NSString *urlString = @"https://randomuser.me/api/?results=5";
    NSURL *url = [NSURL URLWithString:urlString];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *descJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
        if (err) {
            NSLog(@"Error: %@",err);
            return;
        }
        self.dataArray= descJson[@"results"];
        NSLog(@"Data Array: %@", self.dataArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }]resume];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    NSString *fullName = self.dataArray[indexPath.row][@"name"][@"title"];
    cell.textLabel.text = fullName;
    cell.detailTextLabel.text = self.dataArray[indexPath.row][@"gender"];
    return cell;
}
@end
