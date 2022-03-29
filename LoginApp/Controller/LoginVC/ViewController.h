//
//  ViewController.h
//  LoginApp
//
//  Created by spurthi.eshwarappa on 07/03/22.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
-(IBAction)loginPressed:(UIButton *)sender;
-(IBAction)registerPressed:(UIButton *)sender;
-(void)validateLoginDetails;

@end

