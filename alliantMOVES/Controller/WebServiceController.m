//
//  WebServiceController.m
//  AlliantGroup
//
//  Created by Nikhil Wagh on 12/21/17.
//  Copyright © 2017 Nikhil Wagh. All rights reserved.
//

#import "WebServiceController.h"

#import "JSONResponseSerializerWithData.h"

#import "MultipartUploadFile.h"

#import "Constants.h"

#import "Error.h"

#import "Utility.h"

#import <Photos/Photos.h>

@interface WebServiceController ()

@property(nonatomic) BOOL isErrorOccurred;

@end


@implementation WebServiceController


- (void) setHeadersWithAuth:(BOOL)isWithAuth {
    
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [self.requestSerializer setValue:@"application/json"
                  forHTTPHeaderField:@"Content-Type"];
    
    
    // CONDITION APPLICABLE TO ALL SECURE API's
    if (isWithAuth)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

        [self.requestSerializer setValue:[userDefaults valueForKey:kHeaderIV]
                      forHTTPHeaderField:kHeaderIV];
        
        [self.requestSerializer setValue:[userDefaults valueForKey:kHeaderToken]
                      forHTTPHeaderField:kHeaderToken];
        
        [self.requestSerializer setValue:[userDefaults valueForKey:kHeaderKey]
                      forHTTPHeaderField:kHeaderKey];
        
        isHeaderContainAuthorizationToken = FALSE;
    }
    

    // Use the overridden response serializer.
    self.responseSerializer = [JSONResponseSerializerWithData serializer];
    
    [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil]];
    
}



- (void)    performForServicePath:(NSString *)servicePath
                       ofHTTPType:(HTTPRequestType)httpRequestType
                  withAuthHeaders:(BOOL)isWithAuthHeaders
                   withParameters:(NSDictionary *)parameters
                   serviceSuccess:(ServiceSuccessBlock)successBlock
                   serviceFailure:(ServiceFailureBlock)failureBlock
{
    
    //Set standard headers for the request
    [self setHeadersWithAuth:isWithAuthHeaders];
    
    switch (httpRequestType)
    {
            
        case HTTPRequestTypeGET:
        {
            
            [self GET:servicePath parameters:parameters
             progress:^(NSProgress * _Nonnull downloadProgress) {
                 
             } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 
                 NSLog(@"GET Success: %@",servicePath);
                 NSDictionary *responseHeaders = [self getResponseHeadersFromTask:task];
                 successBlock(responseHeaders, responseObject);
                 
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 
                // NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)task.response;
                 NSLog(@"GET Failure: %@ with error: %@", servicePath, error.localizedDescription);
                 failureBlock(error);
                 
             }];
        }
            break;
            
        case HTTPRequestTypePUT:
        {
            
            [self PUT:servicePath parameters:parameters
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  
                  NSDictionary *responseHeaders = [self getResponseHeadersFromTask:task];
                  successBlock(responseHeaders, responseObject);
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
              //    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)task.response;
                  NSLog(@"PUT Failure: %@ with error: %@", servicePath, error.localizedDescription);
                  failureBlock(error);
              }];
        }
            break;
            
        case HTTPRequestTypePOST:
        {
            
            [self POST:servicePath parameters:parameters
              progress:^(NSProgress * _Nonnull uploadProgress) {
                  
              } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  
                  NSDictionary *responseHeaders = [self getResponseHeadersFromTask:task];
                  successBlock(responseHeaders, responseObject);
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
               //   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)task.response;
                  NSLog(@"POST Failure: %@ with error: %@", servicePath, error.localizedDescription);
                  failureBlock(error);
              }];
        }
            break;
            
        case HTTPRequestTypeDELETE:
        {
            
            [self DELETE:servicePath parameters:parameters
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     NSDictionary *responseHeaders = [self getResponseHeadersFromTask:task];
                     successBlock(responseHeaders, responseObject);
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                //     NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)task.response;
                     NSLog(@"DELETE Failure: %@ with error: %@", servicePath, error.localizedDescription);
                     failureBlock(error);
                 }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Private Methods

// Updated function with code optimisation and toast functionality showing upload progress.
// Perform Multipart POST.
// NOTE: The service path is to contain the complete URL.
-(void) performMultipartPOSTForServicePath:(NSString*)servicePath
                       withInputParameters:(id)input
                       multipartUploadFile:(NSArray*)uploadFileArray
                           authCredentials:(NSDictionary*)credentials
                            serviceSuccess:(ServiceSuccessBlock)successBlock
                            serviceFailure:(ServiceFailureBlock)failureBlock

{
  //   UIViewController *topVC = [[[[UIApplication sharedApplication] delegate] window]rootViewController];
    
  //   [topVC.view makeToast:[NSString stringWithFormat:@"Uploading %d of %lu",0,(unsigned long)[uploadFileArray count]]];
    
    NSLog(@"Multipart POST: %@",servicePath);
    
    [self setHeadersWithAuth:true];
    
    // Set Auth credentials for Current Request.
    AFHTTPRequestSerializer* requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    [requestSerializer setValue:[userDefaults valueForKey:kHeaderIV]
             forHTTPHeaderField:kHeaderIV];
    
    [requestSerializer setValue:[userDefaults valueForKey:kHeaderToken]
             forHTTPHeaderField:kHeaderToken];
    
    [requestSerializer setValue:[userDefaults valueForKey:kHeaderKey]
             forHTTPHeaderField:kHeaderKey];
    
    __block int sucessCount = 0;

    for (int i = 0; i < uploadFileArray.count; i++)
    {
        MultipartUploadFile* uploadFile = [uploadFileArray objectAtIndex:i];
        
       
            // Set up the Request.
        NSMutableURLRequest *request = [requestSerializer multipartFormRequestWithMethod:@"POST"
                                                                               URLString:[servicePath stringByAppendingString:[NSString stringWithFormat:@"&TimeStamp=%@",[Utility getImageTimeStampWithPath:uploadFile.filepath]]]
                                                                              parameters:input
                                                             constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
            {
                
                
                                                                    MultipartUploadFile* uploadFile = [uploadFileArray objectAtIndex:i];

                                                                       NSLog(@"Count is:%d",i);
                                                                       NSLog(@"name is:%@",[Utility addPercentEscapeUsingEncodingOfURLString:uploadFile.fieldName]);
                                                                      NSLog(@"fieldName is:%@",[Utility addPercentEscapeUsingEncodingOfURLString:[uploadFile.filepath lastPathComponent]]);

                
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:uploadFile.filepath]
                                           name:[Utility addPercentEscapeUsingEncodingOfURLString:uploadFile.fieldName]
                                       fileName:[Utility addPercentEscapeUsingEncodingOfURLString:[uploadFile.filepath lastPathComponent]]
                                       mimeType:uploadFile.mimeType
                                          error:nil];
                /*
                                                                       [formData appendPartWithFileURL:[NSURL fileURLWithPath:uploadFile.filepath]
                                                                                                  name:uploadFile.fieldName
                                                                                              fileName:[uploadFile.filepath lastPathComponent]
                                                                            mimeType:uploadFile.mimeType
                                                                                                 error:nil];
                 */
                
                                                                   } error:nil];
            
            NSLog(@"RequestHeaders:\n%@",[request allHTTPHeaderFields]);
            
            [request setTimeoutInterval:3600];
            
            NSURLSessionUploadTask *uploadTask;
            uploadTask = [self uploadTaskWithStreamedRequest:request
                                                    progress:^(NSProgress * _Nonnull uploadProgress) {
                                                       
                                                    }
                                           completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                               // failure.
                                               if (error)
                                               {
                                                   NSLog(@"Error: %@",error.localizedDescription);
                                                   
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                   
                                                       self.isErrorOccurred = true;
                                                       
                                                       // [topVC.view hideToastActivity];
                                                      // [topVC.view hideToasts];
                                                    
                                                   });
                                                   
                                                   if(failureBlock)
                                                   {
                                                       
                                                       failureBlock(error);
                                                      
                                                   }
                                                   return;
                                               }
                                               else
                                               {
                                                   // success.
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                       
                                                       sucessCount ++;
                                                       NSLog(@"Success Count is: %d",sucessCount);
                                                       
                                                       if(!(self.isErrorOccurred))
                                                       {
                                                         //  [topVC.view makeToast:[NSString stringWithFormat:@"Uploading %d of %lu",sucessCount,(unsigned long)[uploadFileArray count]]];
                                                       }
                                                       
                                                       if(sucessCount == [uploadFileArray count])
                                                       {
                                                           NSDictionary* headerFields = nil;
                                                           
                                                           if(response && [response isKindOfClass:[NSHTTPURLResponse class]])
                                                           {
                                                               NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                                                               headerFields = [httpResponse allHeaderFields];
                                                           }
                                                           
                                                           if(successBlock)
                                                           {
                                                               successBlock(headerFields, responseObject);
                                                           }
                                                           return;
                                                           
                                                       }
                                                     
                                                   });
                                               }
                                           }];
            
            // Start upload.
            [uploadTask resume];
    }
}

//ORIGINAL CODE
/*
{
    NSLog(@"Multipart POST: %@",servicePath);
    
    [self setHeadersWithAuth:true];
    
    // Set Auth credentials for Current Request.
    AFHTTPRequestSerializer* requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    
    [requestSerializer setValue:[userDefaults valueForKey:kHeaderIV]
                  forHTTPHeaderField:kHeaderIV];

    [requestSerializer setValue:[userDefaults valueForKey:kHeaderToken]
                  forHTTPHeaderField:kHeaderToken];

    [requestSerializer setValue:[userDefaults valueForKey:kHeaderKey]
                  forHTTPHeaderField:kHeaderKey];
    
  
    // Set up the Request.
    NSMutableURLRequest *request = [requestSerializer multipartFormRequestWithMethod:@"POST"
                                                                           URLString:servicePath
                                                                          parameters:input
                                                           constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                              
                                                               for (int i = 0; i < uploadFileArray.count; i++)
                                                               {
                                                                   MultipartUploadFile* uploadFile = [uploadFileArray objectAtIndex:i];

                                                                   NSLog(@"Upload File name: %@", uploadFile.fieldName);
                                                                   
                                                                   [formData appendPartWithFileURL:[NSURL fileURLWithPath:uploadFile.filepath]
                                                                                              name:uploadFile.fieldName
                                                                                          fileName:[uploadFile.filepath lastPathComponent]
                                                                                          mimeType:uploadFile.mimeType
                                                                                             error:nil];
                                                               }
                                                               
                                                           } error:nil];
    
    NSLog(@"RequestHeaders:\n%@",[request allHTTPHeaderFields]);
    
    [request setTimeoutInterval:7200.0];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [self uploadTaskWithStreamedRequest:request
                                            progress:^(NSProgress * _Nonnull uploadProgress) {
                                                // This is not called back on the main queue.
                                                // You are responsible for dispatching to the main queue for UI updates
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    // Logging Upload progress.
                                                    NSLog(@"File Upload Progress: %f",uploadProgress.fractionCompleted * 100);
                                                });
                                            }
                                   completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                       // failure.
                                       if (error) {
                                           NSLog(@"Error: %@",error);
                                           if(failureBlock) {
                                               failureBlock(error);
                                           }
                                           return;
                                       }
                                       else {
                                           // success.
                                           NSLog(@"%@ %@",response, responseObject);
                                           NSDictionary* headerFields = nil;
                                           if(response && [response isKindOfClass:[NSHTTPURLResponse class]]) {
                                               NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                                               headerFields = [httpResponse allHeaderFields];
                                           }
                                           if(successBlock) {
                                               successBlock(headerFields, responseObject);
                                           }
                                           return;
                                       }
                                   }];
    
    // Start upload.
    [uploadTask resume];
}
*/


// Returns the response headers.
- (NSDictionary*) getResponseHeadersFromTask:(NSURLSessionTask*)task {
    
    NSDictionary* responseHeaders = nil;
    if([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        responseHeaders = [(NSHTTPURLResponse*)task.response allHeaderFields];
    }
    return responseHeaders;
}

@end
