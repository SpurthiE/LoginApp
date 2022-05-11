//
//  Alert.m
//  LoginApp
//
//  Created by spurthi.eshwarappa on 10/03/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Alert.h"
#import "Constants.h"

@implementation Alert : NSObject

- (void)alertWithOneBtn:(UIViewController *)alertController title:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [alertController presentViewController:alert animated:YES completion:nil];
    });
}

@end
