//
//  NSDictionary+NSNull.h
//  StayNSync
//
//  Created by Kedar Inamdar on 16/04/14.
//  Copyright (c) 2014 Silicus. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    Interface: NSDictionary (NSNull)
    This category will filter null form the NSDictonary values.
    The return value will be nil if NULL/ NSNUll, null is encountered. 
*/

@interface NSDictionary (NSNull)
/*!
    @brief: Substitute for valueForKey
*/
-(id) valueWithKey:(NSString *)key;

/*!
    @brief: Substitute for objectForKey
*/
-(id) objectWithKey:(NSString *)key;

@end


/*
    Interface: NSDictionary (Sorted)
*/

@interface NSDictionary (Sorted)

/*!
    @brief: Returns all the keys in the dictonary in sorted order.
*/
- (NSArray *) sortedKeys;

@end
