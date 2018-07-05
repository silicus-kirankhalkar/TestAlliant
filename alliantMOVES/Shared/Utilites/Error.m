//
//  Error.m
//  AlliantGroup
//
//  Created by Nikhil Wagh on 12/21/17.
//  Copyright © 2017 Nikhil Wagh. All rights reserved.
//

#import "Error.h"

@implementation Error

@synthesize errorCode;
@synthesize errorDesc;

// Initializer
-(Error*) initWithErrorCode:(ErrorCode)code desc:(NSString*)desc;
{
    self = [super init];
    if(self){
        self.errorCode = code;
        self.errorDesc = desc;
    }
    return self;
}

@end
