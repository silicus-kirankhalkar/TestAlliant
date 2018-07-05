//
//  NSDictionary+NSNull.m
//  StayNSync
//
//  Created by Kedar Inamdar on 16/04/14.
//  Copyright (c) 2014 Silicus. All rights reserved.
//

#import "NSDictionary+NSNull.h"

@implementation NSDictionary (NSNull)

/*!
    @brief: Substitute for valueForKey
*/
-(id) valueWithKey:(NSString *)key {
    
    if ([[self valueForKey:key] isEqual:[NSNull null]]) {
        return @"";
    }
    
    return [self valueForKey:key];
}

/*!
    @brief: Substitute for objectForKey
*/
-(id) objectWithKey:(NSString *)key {
    
    if ([[self objectForKey:key] isEqual:[NSNull null]]) {
        return @"";
    }
    
    return [self objectForKey:key];
}

@end

@implementation NSDictionary (Sorted)

/*!
    @brief: Returns all the keys in the dictonary in sorted order.
*/
- (NSArray *) sortedKeys {
    
    NSArray *keys = [[self allKeys] sortedArrayUsingSelector:@selector(compare:)];
    return keys;
}

@end
