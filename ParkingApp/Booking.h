//
//  Booking.h
//  ParkingApp
//
//  Created by Emiliano Viscarra on 7/8/16.
//  Copyright © 2016 Emiliano Viscarra. All rights reserved.
//

#import "BaseJSONModel.h"

@interface Booking : BaseJSONModel

@property(nonatomic, strong) NSString *_id;
@property(nonatomic, strong) NSString *parking;
@property(nonatomic, strong) NSString *code;

@end
