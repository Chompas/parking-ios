//
//  Parking.h
//  ParkingApp
//
//  Created by Emiliano Viscarra on 6/20/16.
//  Copyright © 2016 Emiliano Viscarra. All rights reserved.
//

#import "BaseJSONModel.h"

@protocol Parking
@end

@interface Parking : BaseJSONModel

- (CLLocation *)location;

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *neighborhood;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, strong) NSString *price;
@property(nonatomic, strong) NSString *hours;
@property(nonatomic) int occupancy;
@property(nonatomic) double lat;
@property(nonatomic) double lon;

@end
