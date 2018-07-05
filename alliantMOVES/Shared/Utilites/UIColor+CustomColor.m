//
//  UIColor+CustomColor.m
//  Restonza
//
//  Created by Nikhil Wagh on 12/21/17.
//  Copyright © 2017 Nikhil Wagh. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

+ (UIColor*)getColorWithRedValue:(float)redValue greenValue:(float)green blueValue:(float)blue
{
    return [UIColor colorWithRed:(float)(redValue/255.0) green:(float)(green/255.0) blue:(float)(blue/255.0) alpha:1.0];
}

/**
 *  Function that returns UIColor from Hex code
 *
 *  @param hexValue NSString hex value of the color to be converted to UIColor
 *
 *  @return return UIColor converted object of UIColor
 */
+ (UIColor*)colorWithHexValue:(NSString*)hexValue
{
    //Default
    UIColor *defaultResult = [UIColor blackColor];
    
    //Strip prefixed # hash
    if ([hexValue hasPrefix:@"#"] && [hexValue length] > 1) {
        hexValue = [hexValue substringFromIndex:1];
    }
    
    //Determine if 3 or 6 digits
    NSUInteger componentLength = 0;
    if ([hexValue length] == 3)
    {
        componentLength = 1;
    }
    else if ([hexValue length] == 6)
    {
        componentLength = 2;
    }
    else
    {
        return defaultResult;
    }
    
    BOOL isValid = YES;
    CGFloat components[3];
    
    //Seperate the R,G,B values
    for (NSUInteger i = 0; i < 3; i++) {
        NSString *component = [hexValue substringWithRange:NSMakeRange(componentLength * i, componentLength)];
        if (componentLength == 1) {
            component = [component stringByAppendingString:component];
        }
        NSScanner *scanner = [NSScanner scannerWithString:component];
        unsigned int value;
        isValid &= [scanner scanHexInt:&value];
        components[i] = (CGFloat)value / 256.0f;
    }
    
    if (!isValid) {
        return defaultResult;
    }
    
    return [UIColor colorWithRed:components[0]
                           green:components[1]
                            blue:components[2]
                           alpha:1.0];
}

+ (UIColor*)blueSelectionColor
{
    return [self getColorWithRedValue:0 greenValue:174 blueValue:239];
}

+ (UIColor*)graySelectionColor
{
    return [self getColorWithRedValue:141 greenValue:141 blueValue:141];
}

+ (UIColor*)textViewBorderColor
{
    return [UIColor getColorWithRedValue:220.0f greenValue:224.0f blueValue:226.0f];
}

+ (UIColor*)textViewBackgroundColor
{
    return [UIColor getColorWithRedValue:240.0f greenValue:244.0f blueValue:246.0f];
}

@end
