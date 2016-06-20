//
//  AvailableParkings.h
//  ParkingApp
//
//  Created by Emiliano Viscarra on 6/20/16.
//  Copyright © 2016 Emiliano Viscarra. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Parking.h"

@interface AvailableParkings : JSONModel

@property(nonatomic) int count;
@property(nonatomic, retain) NSArray<Parking> *result;

@end
