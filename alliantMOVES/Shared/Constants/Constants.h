//
//  Constants.h
//  alliantMOVES
//
//  Created by Nikhil Wagh on 04/07/18.
//  Copyright © 2018 Nikhil Wagh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

FOUNDATION_EXPORT NSString* const kServerBaseURL;

FOUNDATION_EXPORT NSString* const kLoginServicePath;

FOUNDATION_EXPORT NSString* const kDocumentFolderKey;

FOUNDATION_EXPORT NSString* const kPhotoFolderKey;

// Header Keys
FOUNDATION_EXPORT NSString* const kHeaderKey;

FOUNDATION_EXPORT NSString* const kHeaderIV;

FOUNDATION_EXPORT NSString* const kHeaderToken;

// API response Keys
FOUNDATION_EXPORT NSString* const kResponseDataKey;

FOUNDATION_EXPORT NSString* const kResponseStatusKey;

FOUNDATION_EXPORT NSString* const kStatusCodeKey;

FOUNDATION_EXPORT NSString* const kStatusSuccessKey;

// General Keys

FOUNDATION_EXPORT NSString* const kOldLatitudeKey;

FOUNDATION_EXPORT NSString* const kOldLongitudeKey;

FOUNDATION_EXPORT NSString* const kNewLatitudeKey;

FOUNDATION_EXPORT NSString* const kNewLongitudeKey;

@end
