//
//  UIColor+CustomColor.h
//  AlliantGroup
//
//  Created by Nikhil Wagh on 12/21/17.
//  Copyright © 2017 Nikhil Wagh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CustomColor)

+ (UIColor*)getColorWithRedValue:(float)redValue greenValue:(float)green blueValue:(float)blue;

+ (UIColor*)colorWithHexValue:(NSString*)hexValue;

+ (UIColor*)blueSelectionColor;

+ (UIColor*)graySelectionColor;

+ (UIColor*)textViewBorderColor;

+ (UIColor*)textViewBackgroundColor;

@end
