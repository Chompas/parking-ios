//
//  ColorUtils.h
//  ParkingApp
//
//  Created by Emiliano Viscarra on 2/11/16.
//  Copyright (c) 2016 Emiliano Viscarra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorUtils : NSObject

+ (NSArray *)generateGradientColors;
+ (NSArray *)generateGradientColorsAndExclude:(NSArray *)excludedColors;
+ (NSArray *)generateGradientFromColor:(UIColor *)fromColor
                               toColor:(UIColor *)toColor
                             withSteps:(NSInteger)steps;

@end
