//
//  WebServiceController.h
//  AlliantGroup
//
//  Created by Nikhil Wagh on 12/21/17.
//  Copyright © 2017 Nikhil Wagh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@class Error;
@class MultipartUploadFile;

// Enum defining HTTP Request types
typedef NS_ENUM(NSUInteger, HTTPRequestType) {
    
    HTTPRequestTypeGET,
    HTTPRequestTypePUT,
    HTTPRequestTypePOST,
    HTTPRequestTypeDELETE,
};

// Block objects for success and failure of service request
typedef void (^ServiceSuccessBlock)(NSDictionary *httpHeaders, id response);

typedef void (^ServiceFailureBlock)(NSError *error);

typedef void (^RefreshSuccessBlock)(NSString *token);

typedef void (^RefreshFailureBlock)(NSError *error);



@interface WebServiceController : AFHTTPSessionManager



{
    BOOL isHeaderContainAuthorizationToken;
    
    

}

// GENERIC HTTP REQUEST METHOD.
/*!
 * @brief  Performs a specified HTTP request for specified service path,
 * @param  httpRequestType  The type of request as defination in Enum
 * @param  servicePath      The URL service path for the GET request.
 * @param  isWithAuthHeaders  Weather the auth headers need to be added or not.
 * @param  parameters       The parameters which are to be passed with request
 * @param  successBlock     A success block which returns nothing and has a reference to the response.
 */

- (void)    performForServicePath:(NSString *)servicePath
                       ofHTTPType:(HTTPRequestType)httpRequestType
                  withAuthHeaders:(BOOL)isWithAuthHeaders
                   withParameters:(NSDictionary *)parameters
                   serviceSuccess:(ServiceSuccessBlock)successBlock
                   serviceFailure:(ServiceFailureBlock)failureBlock;


// Perform Multipart POST.
// NOTE: The service path is to contain the complete URL.
-(void) performMultipartPOSTForServicePath:(NSString*)servicePath
                       withInputParameters:(id)input
                       multipartUploadFile:(NSArray*)uploadFileArray
                           authCredentials:(NSDictionary*)credentials
                            serviceSuccess:(ServiceSuccessBlock)successBlock
                            serviceFailure:(ServiceFailureBlock)failureBlock;



@end
