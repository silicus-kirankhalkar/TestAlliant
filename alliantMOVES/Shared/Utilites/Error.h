//
//  Error.h
//  AlliantGroup
//
//  Created by Nikhil Wagh on 12/21/17.
//  Copyright © 2017 Nikhil Wagh. All rights reserved.
//

#import <Foundation/Foundation.h>

/// constants used for Errors.
typedef enum
{
    ERROR_NONE = 1000,
    
    ERROR_BAD_REQUEST = 4000,
    ERROR_RESOURCE_NOT_FOUND,
    
    // Unauthorized, access denied, forbidden.
    ERROR_UNAUTHORIZED = 4010,
    
    // Internal Server Error.
    ERROR_SERVER = 5000,
    
    
    // General error
    ERROR_GENERAL = 10000
    
} ErrorCode;

/*!
 * @brief Class to encapsulate the error in SAwin.
 */

@interface Error : NSObject

@property (assign) ErrorCode errorCode;
@property (strong,nonatomic) NSString* errorDesc;

/*!
 * @brief Initializes a Error object with the error code and description.
 * @param  code         The error code for the error.
 * @param  desc         The description for the error.
 * @return Error*       An initialized SAwin error object.
 */
-(Error*) initWithErrorCode:(ErrorCode)code desc:(NSString*)desc;


@end
