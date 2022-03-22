//
//  PasswordValidation.h
//  LoginApp
//
//  Created by spurthi.eshwarappa on 11/03/22.
//

@interface Validation: NSObject
-(BOOL)isValidPassword:(NSString *)passwordString;
-(BOOL)isValidEmail:(NSString*)email;
@end
