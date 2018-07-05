//
//  MultipartUploadFile.h
//  AlliantGroup
//
//  Created by Nikhil Wagh on 12/21/17.
//  Copyright © 2017 Nikhil Wagh. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @brief Data Model class representing the file for upload using Multipart POST.
 */

@interface MultipartUploadFile : NSObject

// Location of file on disk.
@property (strong, nonatomic) NSString* filepath;
// Mime Type.
@property (strong, nonatomic) NSString* mimeType;
// The name(key) which is to be associated with the file while being uploaded.
@property (strong, nonatomic) NSString* fieldName;

@end
