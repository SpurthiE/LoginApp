//
//  PasswordValidation.m
//  LoginApp
//
//  Created by spurthi.eshwarappa on 11/03/22.
//

#import <Foundation/Foundation.h>
#import "PasswordValidation.h"
@implementation PasswordValidation: NSObject
-(BOOL)isValidPassword:(NSString *)passwordString
{
    NSString *stricterFilterString = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [passwordTest evaluateWithObject:passwordString];
}

@end
