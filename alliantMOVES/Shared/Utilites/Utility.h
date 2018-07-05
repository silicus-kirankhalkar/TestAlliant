//
//  AllientGroupUtility.h
//  AlliantGroup
//
//  Created by Kushal Pathak on 28/12/17.
//  Copyright © 2017 Nikhil Wagh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject

+ (void)showAlertViewWithMessage:(NSString *)message withTitle:(NSString*)alertTitle onViewController:(id)vc;

+ (NSString *)documentDirectoryPath;

+ (NSString *)documentDirectoryPathForFolder:(NSString *)folderName;

+(NSString*)convertDateStringToAPIFormatWithString:(NSString*)dateString;

+(NSString*)convertResponseDateStringTorequiredDateString:(NSString*)dateString;

// Returns the json object inside the 'Metadata' tag for the data attribute.
+(id) getMetadataJSONObjectFromJSONResponse:(id)jsonResponse;

// Returns the json object inside the 'Results' tag for the data attribute.
+(id) getResultJSONObjectFromJSONResponse:(id)jsonResponse;

+(NSString*)addPercentEscapeUsingEncodingOfURLString:(NSString*)urlString;

+(NSString*)convertResponseDateStringToString:(NSString*)dateString;

//+(NSString*)convertDateStringToString:(NSString*)dateString;

+(NSMutableArray*)getAttachmentArrayForInspectionId:(NSString*)inspectionId;

+ (void)removeImageAtPath:(NSString *)filepath;

+(void)openNativeMapsApplicationToAddress:(NSString*)toAddress;

+(void)email:(NSString*)emailString;

+(void)call:(NSString*)phone;

// Returns the converted NSDate with the required timezone.
+(NSString *)localDateStringForISODateTimeString:(NSString *)dateString withTimeZone:(NSString *)timeZone;

// Scale the UI Image as specified size.
+(UIImage*) imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+(float)distanceBetweenlatnlong;

// Convert the API response for Square Feet to Required Format.
+(NSString*)convertSquareFeetToRequiredNumberFormat:(NSString *)squareFeetString;


// METHOD: IMAGES TIMESTAMP

+(void)savedImageTimeStamp:(NSString*)imageTimeStamp withPath:(NSString*)filePath;

+(NSString*)getImageTimeStampWithPath:(NSString*)filePath;

+(void)removedImageTimeStampWithPath:(NSString*)filePath;

+(void)renameImageTimeStampWithOldPath:(NSString*)oldfilePath withNewFilePath:(NSString *)newFilePath;
@end
