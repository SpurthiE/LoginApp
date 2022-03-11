//
//  EmailValidation.m
//  LoginApp
//
//  Created by spurthi.eshwarappa on 11/03/22.
//

#import <Foundation/Foundation.h>
#import "EmailValidation.h"

@implementation EmailValidation: NSObject
/// Email validation check
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
@end
