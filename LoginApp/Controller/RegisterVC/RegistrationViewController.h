//
//  RegistrationViewController.h
//  LoginApp
//
//  Created by spurthi.eshwarappa on 10/03/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegistrationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
- (IBAction)registerPressed:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
