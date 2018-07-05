//
//  Constants.m
//  alliantMOVES
//
//  Created by Nikhil Wagh on 04/07/18.
//  Copyright © 2018 Nikhil Wagh. All rights reserved.
//

#import "Constants.h"

@implementation Constants

// ALLAINT URL
NSString* const kServerBaseURL                                =  @"http://fipprod.alliantgroup.com";   //@"http://fipdev.alliantgroup.com";

//SILICUS URL
//NSString* const kServerBaseURL                               = @"http://testspconnects.azurewebsites.net/";


#pragma mark - Keys

NSString* const kDocumentFolderKey                           = @"AlliantDocuments";

NSString* const kPhotoFolderKey                              = @"AlliantPhotos";

// Header Keys
NSString* const kHeaderKey                                  = @"Key";

NSString* const kHeaderIV                                   = @"IV";

NSString* const kHeaderToken                                = @"Token";

// API response Keys
NSString* const kResponseDataKey                            = @"responseData";

NSString* const kResponseStatusKey                          = @"responseStatus";

NSString* const kStatusCodeKey                              = @"StatusCode";

NSString* const kStatusSuccessKey                           = @"OK";

// General Keys
NSString* const kOldLatitudeKey                                = @"oldLatitude";

NSString* const kOldLongitudeKey                               = @"oldLongitude";

NSString* const kNewLatitudeKey                                = @"newLatitude";

NSString* const kNewLongitudeKey                               = @"newLongitude";


#pragma mark - LOGIN

NSString* const kLoginServicePath                           = @"/api/User/Login";


@end
