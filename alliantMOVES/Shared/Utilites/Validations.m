//
//  Validations.h
//  ios
//
//  Created by Anshuman Dahale on 6/13/17.
//  Copyright © 2017 Silicus Technologies India Pvt. Ltd. All rights reserved.
//


#import "Validations.h"

@implementation Validations

/**
 *  Validate for blank
 *
 *  @param string the string to be validated
 *
 *  @return Boolean Value
 */
+ (BOOL) isStringBlank:(NSString *)string {
    
    return (string.length > 0) ? NO : YES;
}


/**
 *  Validate for email id
 *
 *  @param emailString the string which is to be validated
 *
 *  @return Boolean value
 */
+ (BOOL) isValidEmail:(NSString *)emailString {
    
    if([Validations isStringBlank:emailString])
        return NO;
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailValidate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailValidate evaluateWithObject:emailString];
}


// validate only US Zip codes, 5 digits
+ (BOOL) isValidateZip:(NSString *)zip {
    
//    NSString *zipRegex = @"(^[0-9]{5}(-[0-9]{5})?$)";
//    NSPredicate *zipValidate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zipRegex];
//    BOOL result = [zipValidate evaluateWithObject:zip];
//    return result;
    
    if(zip.length == 5)
        return YES;
    else
        return NO;
}

+ (BOOL) isValidStateCode:(NSString *)stateCode {

    NSRange range;
    range = [stateCode rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    if ( !range.length )
        return NO;
    else
        return YES;
}

/**
 *  6 to 32 characters, with atleast 1 no. and 1 alphabet
 *
 *  @param password which is to be evaluated
 *
 *  @return Boolean value
 */

+ (BOOL) isPasswordValid:(NSString *)password {
    
   // @"^.*(?=.{8,})(?=.*[a-z])(?=.*\\d)(?=.*[A-Z]).*$"
   // Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}" options:0 error:nil];
    return [regex numberOfMatchesInString:password options:0 range:NSMakeRange(0, [password length])] > 0;
}


/**
 *  Validate for Phone
 *
 *  @param phoneNumber the string which is to be validated
 *
 *  @return Boolean value
 */

+ (BOOL)isValidatePhone:(NSString *)phoneNumber
{
    
    NSString *numberRegEx = @"[0-9]{10}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    if ([numberTest evaluateWithObject:phoneNumber] == YES)
        return TRUE;
    else
        return FALSE;
    
    /*
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    if ([numberTest evaluateWithObject:phoneNumber] == YES)
        return TRUE;
    else
        return FALSE;
    */
}

@end
