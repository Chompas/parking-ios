//
//  BaseJSONModel.m
//  ParkingApp
//
//  Created by Emiliano Viscarra on 5/26/16.
//  Copyright (c) 2016 Emiliano Viscarra. All rights reserved.
//

#import "BaseJSONModel.h"

@implementation BaseJSONModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
