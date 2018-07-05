//
//  Validations.h
//  ios
//
//  Created by Anshuman Dahale on 6/13/17.
//  Copyright © 2017 Silicus Technologies India Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validations : NSObject

/*!
    @brief: Validates if a string is blank
    @param string : the string to validate
    @return: Boolean result
*/
+ (BOOL) isStringBlank:(NSString *)string;

/*!
    @brief: Validates if provided email is correct
    @param emailString : the email address to validate
    @return: Boolean result
*/
+ (BOOL) isValidEmail:(NSString *)emailString;

/*!
    @brief: Validates if provided password passes our criteria
    @param password : the string to validate
    @return: Boolean result
*/
+ (BOOL) isPasswordValid:(NSString *)password;

/*!
    @brief: Validates for Zip code
    @param zip : the string to validate
    @return: Boolean result
*/
+ (BOOL) isValidateZip:(NSString *)zip;

/*!
    @brief: Validates for State code
    @param stateCode : the string to validate
    @return: Boolean result
*/
+ (BOOL) isValidStateCode:(NSString *)stateCode;


/**
 *  Validate for Phone
 *
 *  @param phoneNumber the string which is to be validated
 *
 *  @return Boolean value
 */
+ (BOOL)isValidatePhone:(NSString *)phoneNumber;

@end
