//
//  Parking.m
//  ParkingApp
//
//  Created by Emiliano Viscarra on 6/20/16.
//  Copyright © 2016 Emiliano Viscarra. All rights reserved.
//

#import "Parking.h"

@implementation Parking

- (CLLocation *)location {
    return [[CLLocation alloc] initWithLatitude:_lat longitude:_lon];
}


@end
