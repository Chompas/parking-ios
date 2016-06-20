//
//  BookingService.h
//  ParkingApp
//
//  Created by Emiliano Viscarra on 6/20/16.
//  Copyright © 2016 Emiliano Viscarra. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "Parking.h"

@protocol BookingServiceDelegate <NSObject>

@required
- (void)didBookParking:(Parking *)parking;
- (void)didFailBookingParking;
@end

@interface BookingService : AFHTTPRequestOperationManager

@property(nonatomic, weak) id<BookingServiceDelegate> delegate;

+ (BookingService *)sharedManager;
- (BookingService *)initWithDelegate:(id<BookingServiceDelegate>)delegate;
- (void)bookParking:(Parking *)Parking;

@end
