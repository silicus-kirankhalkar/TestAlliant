//
//  Utility.m
//  AlliantGroup
//
//  Created by Kushal Pathak on 28/12/17.
//  Copyright © 2017 Nikhil Wagh. All rights reserved.
//

#import "Utility.h"

#import "MultipartUploadFile.h"

#import "Constants.h"

#import <CoreLocation/CoreLocation.h>

@implementation Utility

#pragma mark  - Alert
+ (void)showAlertViewWithMessage:(NSString *)message withTitle:(NSString*)alertTitle onViewController:(id)vc {
    
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:alertTitle
                                                                  message:message
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   
                               }];
    [alert addAction:okButton];
    [vc presentViewController:alert animated:YES completion:nil];
    
}



+ (NSString *)documentDirectoryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return documentsPath;
}

+ (NSString *)documentDirectoryPathForFolder:(NSString *)folderName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:folderName];
}

+(NSString*)convertDateStringToAPIFormatWithString:(NSString*)dateString
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"dd MMM yy"];
    NSDate *stringDate = [dateformatter dateFromString:dateString];
    
    NSDateFormatter *apiDateformatter = [[NSDateFormatter alloc]init];
    [apiDateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *apiDateString = [apiDateformatter stringFromDate:stringDate];
    
    return apiDateString;

}

+(NSString*)convertResponseDateStringTorequiredDateString:(NSString*)dateString
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *stringDate = [dateformatter dateFromString:dateString];
    
    NSDateFormatter *apiDateformatter = [[NSDateFormatter alloc]init];
    [apiDateformatter setDateFormat:@"EEE, MMM dd, yyyy"];
    NSString *apiDateString = [apiDateformatter stringFromDate:stringDate];
    NSLog(@"date is %@", apiDateString);
    
    return apiDateString;
}




+(NSString*)convertResponseDateStringToString:(NSString*)dateString
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *stringDate = [dateformatter dateFromString:dateString];
    
    NSDateFormatter *apiDateformatter = [[NSDateFormatter alloc]init];
    [apiDateformatter setDateFormat:@"MMMM dd, yyyy"];
    NSString *apiDateString = [apiDateformatter stringFromDate:stringDate];
    NSLog(@"date is %@", apiDateString);
    
    return apiDateString;
}

/*
+(NSString*)convertDateStringToString:(NSString*)dateString
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *stringDate = [dateformatter dateFromString:dateString];
    
    NSDateFormatter *apiDateformatter = [[NSDateFormatter alloc]init];
    [apiDateformatter setDateFormat:@"dd MMM yyyy"];
    NSString *apiDateString = [apiDateformatter stringFromDate:stringDate];
    NSLog(@"date is %@", apiDateString);
    
    return apiDateString;
}
 */


// Returns the json object inside the 'Results' tag for the data attribute.
+(id) getResultJSONObjectFromJSONResponse:(id)jsonResponse
{
    id jsonObject = nil;
    if(jsonResponse && [jsonResponse isKindOfClass:[NSDictionary class]])
    {
        jsonObject = [(NSDictionary*)jsonResponse objectForKey:kResponseDataKey];
    }
    return jsonObject;
}

// Returns the json object inside the 'Metadata' tag for the data attribute.
+(id) getMetadataJSONObjectFromJSONResponse:(id)jsonResponse
{
    id jsonObject = nil;
    if(jsonResponse && [jsonResponse isKindOfClass:[NSDictionary class]])
    {
        jsonObject = [(NSDictionary*)jsonResponse objectForKey:kResponseStatusKey];
    }
    return jsonObject;
}

+(NSString*)addPercentEscapeUsingEncodingOfURLString:(NSString*)urlString
{
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *serverpathToUse = [urlString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    //DEPRICATED METHOD
    //  NSString *serverpathToUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return serverpathToUse;
}


+(NSMutableArray*)getAttachmentArrayForInspectionId:(NSString*)internalId
{
    NSMutableArray *attachmentsArray = [[NSMutableArray alloc] init];
    
    NSArray *photos = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[Utility documentDirectoryPathForFolder:kPhotoFolderKey] error:nil];
    
    for (int i = 0; i < photos.count; i++)
    {
        NSString *imageName = [photos objectAtIndex:i];
        
        NSArray *imageArray = [imageName componentsSeparatedByString:@"_"];
        
        if ([[imageArray objectAtIndex:2] isEqualToString:[NSString stringWithFormat:@"%@",internalId]])
        {
            // Create the package to be uploaded.
            MultipartUploadFile* uploadFile = [[MultipartUploadFile alloc] init];
            
            uploadFile.filepath = [[Utility documentDirectoryPathForFolder:kPhotoFolderKey] stringByAppendingString:[NSString stringWithFormat:@"/%@",imageName]];
            uploadFile.mimeType = @"image/png";
            uploadFile.fieldName = imageName;
            
            [attachmentsArray addObject:uploadFile];
        }
    }
    
    NSArray *documents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: [Utility documentDirectoryPathForFolder:kDocumentFolderKey] error:nil];
    
    for (int i = 0; i < documents.count; i++)
    {
        NSString *imageName = [documents objectAtIndex:i];
        
        NSArray *imageArray = [imageName componentsSeparatedByString:@"_"];
        
        if ([[imageArray objectAtIndex:2] isEqualToString:[NSString stringWithFormat:@"%@",internalId]])
        {
            // Create the package to be uploaded.
            MultipartUploadFile* uploadFile = [[MultipartUploadFile alloc] init];
            
            uploadFile.filepath = [[Utility documentDirectoryPathForFolder:kDocumentFolderKey] stringByAppendingString:[NSString stringWithFormat:@"/%@",imageName]];
            uploadFile.mimeType = @"image/png";
            uploadFile.fieldName = imageName;
            
            [attachmentsArray addObject:uploadFile];
        }
    }
    
    return attachmentsArray;
}

+ (void)removeImageAtPath:(NSString *)filepath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    
    BOOL success = [fileManager removeItemAtPath:filepath error:&error];
    
    if (!success)
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}

+(void)openNativeMapsApplicationToAddress:(NSString*)toAddress
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    BOOL isGoogleMapsPresent = [[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"comgooglemaps:"]];
    
    if (isGoogleMapsPresent)
    {
        //Open in Google Maps //http://maps.google.com/maps?
        //NSString *directionsURL = [NSString stringWithFormat:@"comgooglemaps://?saddr=%f,%f&daddr=%@",[[defaults valueForKey:kNewLatitudeKey] floatValue], [[defaults valueForKey:kNewLongitudeKey] floatValue],toAddress];
    
        NSString *directionsURL = [NSString stringWithFormat:@"comgooglemaps://?saddr=%f,%f&daddr=%@",[[defaults valueForKey:kNewLatitudeKey] floatValue], [[defaults valueForKey:kNewLongitudeKey] floatValue],toAddress];
        
        
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self addPercentEscapeUsingEncodingOfURLString:directionsURL]] options:@{} completionHandler:nil];
        
    }
    else
    {
        // Open in Apple Maps
        NSString* directionsURL = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%f,%f&daddr=%@",[[defaults valueForKey:kNewLatitudeKey] floatValue], [[defaults valueForKey:kNewLongitudeKey] floatValue],toAddress];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self addPercentEscapeUsingEncodingOfURLString:directionsURL]] options:@{} completionHandler:nil];
    }
}


+(void)call:(NSString*)phone
{
    NSMutableCharacterSet *charSet = [NSMutableCharacterSet new];
    [charSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
    [charSet formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]];
    [charSet formUnionWithCharacterSet:[NSCharacterSet symbolCharacterSet]];
    NSArray *arrayWithNumbers = [phone componentsSeparatedByCharactersInSet:charSet];
    NSString *numberStr = [arrayWithNumbers componentsJoinedByString:@""];
    
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:numberStr];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber] options:@{} completionHandler:nil];
}

+(void)email:(NSString*)emailString
{
    NSString *recipients = [NSString stringWithFormat:@"mailto:%@?subject=",emailString];
    NSString *email = [NSString stringWithFormat:@"%@", recipients];
    [email stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email] options:@{} completionHandler:nil];
}

+(NSString *)localDateStringForISODateTimeString:(NSString *)dateString withTimeZone:(NSString *)timeZone

{
    NSDateFormatter *isoDateFormatter = [[NSDateFormatter alloc] init];
    [isoDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *inspectionDate = [isoDateFormatter dateFromString:dateString];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm a"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:timeZone]];
    NSString *dateString1 = [dateFormatter stringFromDate:inspectionDate];
    
    return dateString1;
}

// Scale the UI Image as specified size.
+(UIImage*) imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // http://stackoverflow.com/questions/2658738/the-simplest-way-to-resize-an-uiimage
    
    // UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}


+(float)distanceBetweenlatnlong
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    CLLocation *newLoc = [[CLLocation alloc] initWithLatitude:[[userDefaults valueForKey:kNewLatitudeKey] doubleValue] longitude:[[userDefaults valueForKey:kNewLongitudeKey] doubleValue]];
    
    CLLocation *oldLoc = [[CLLocation alloc] initWithLatitude:[[userDefaults valueForKey:kOldLatitudeKey] doubleValue] longitude:[[userDefaults valueForKey:kOldLongitudeKey] doubleValue]];
    
    CLLocationDistance distance = [newLoc distanceFromLocation:oldLoc];
    
    return distance;
}

+(NSString*)convertSquareFeetToRequiredNumberFormat:(NSString *)squareFeetString
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
//    [formatter setGroupingSeparator:groupingSeparator];
//    [formatter setGroupingSize:3];
//    [formatter setAlwaysShowsDecimalSeparator:NO];
//    [formatter setUsesGroupingSeparator:YES];
    
    double latdouble = [squareFeetString doubleValue];
    NSString *formattedString = [formatter stringFromNumber:[NSNumber numberWithDouble:latdouble]];
    return formattedString;
}

# pragma mark - IMAGES TIMESTAMP CURD METHODS

// FOR SAVING THE IMAGE WITH ITS TIMESTAMP
+(void)savedImageTimeStamp:(NSString*)imageTimeStamp withPath:(NSString*)filePath
{
    NSMutableArray *photoIdentifierArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"identifierArray"]];
    
    NSMutableDictionary *identifierDict = [[NSMutableDictionary alloc] init];
    
    [identifierDict setValue:filePath forKey:@"path"];
    [identifierDict setValue:imageTimeStamp forKey:@"time"];
    
    [photoIdentifierArray addObject:identifierDict];
    
    [[NSUserDefaults standardUserDefaults] setObject:photoIdentifierArray forKey:@"identifierArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// FOR GETTING THE IMAGE WITH ITS RESPECTIVE TIMESTAMP.
+(NSString*)getImageTimeStampWithPath:(NSString*)filePath
{
    NSMutableArray *photoIdentifierArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"identifierArray"]];
    
    for (int i = 0; i < photoIdentifierArray.count; i++)
    {
        NSMutableDictionary *identifierDict = [photoIdentifierArray objectAtIndex:i];
        
        if ([filePath isEqualToString:[identifierDict valueForKey:@"path"]])
        {
            return [identifierDict valueForKey:@"time"];
            break;
        }
    }
    
    // IF NO TIMESTAMP IS AVAILABLE,THEN RETURN THE CURRENT TIMESTAMP.
    NSTimeInterval ti = [[NSDate date] timeIntervalSince1970];
    NSInteger timeStamp = [[NSNumber numberWithDouble:ti]integerValue];
    NSString *timeStampString = [[NSNumber numberWithInteger:timeStamp]stringValue];
    
    return timeStampString;
}


+(void)removedImageTimeStampWithPath:(NSString*)filePath
{
    
    NSMutableArray *photoIdentifierArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"identifierArray"]];
    
    for (int i = 0; i < photoIdentifierArray.count; i++)
    {
        NSMutableDictionary *identifierDict = [photoIdentifierArray objectAtIndex:i];
        
        if ([filePath isEqualToString:[identifierDict valueForKey:@"path"]])
        {
            [photoIdentifierArray removeObject:identifierDict];
            break;
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:photoIdentifierArray forKey:@"identifierArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)renameImageTimeStampWithOldPath:(NSString*)oldfilePath withNewFilePath:(NSString *)newFilePath
{
    NSMutableArray *photoIdentifierArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"identifierArray"]];
    
    for (int i = 0; i < photoIdentifierArray.count; i++)
    {
        NSMutableDictionary *identifierDict = [[NSMutableDictionary alloc] initWithDictionary:[photoIdentifierArray objectAtIndex:i]];
        
        if ([oldfilePath isEqualToString:[identifierDict valueForKey:@"path"]])
        {
            [identifierDict setValue:newFilePath forKey:@"path"];
            [photoIdentifierArray replaceObjectAtIndex:i withObject:identifierDict];
            break;
        }
    }
    
    NSLog(@"Image Renamed from filepath: %@",photoIdentifierArray);
    
    [[NSUserDefaults standardUserDefaults] setObject:photoIdentifierArray forKey:@"identifierArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
