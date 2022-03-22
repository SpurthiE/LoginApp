//
//  PasswordValidation.m
//  LoginApp
//
//  Created by spurthi.eshwarappa on 11/03/22.
//

#import <Foundation/Foundation.h>
#import "Validation.h"

@implementation Validation: NSObject
///Password Validation check
-(BOOL)isValidPassword:(NSString *)passwordString {
    NSString *stricterFilterString = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [passwordTest evaluateWithObject:passwordString];
}

/// Email Validation check
- (BOOL)isValidEmail:(NSString*)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
@end
