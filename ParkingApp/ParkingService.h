//
//  ParkingService.h
//  ParkingApp
//
//  Created by Emiliano Viscarra on 6/20/16.
//  Copyright © 2016 Emiliano Viscarra. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "AvailableParkings.h"

@protocol ParkingServiceDelegate <NSObject>

@required
- (void)didLoadParkings:(NSArray<Parking *> *)parkings;
- (void)didFailLoadingParkings;
@end


@interface ParkingService : AFHTTPRequestOperationManager

@property(nonatomic, weak) id<ParkingServiceDelegate> delegate;

+ (ParkingService *)sharedManager;
- (ParkingService *)initWithDelegate:(id<ParkingServiceDelegate>)delegate;
- (void)getParkingsNearby:(CLLocation *)currentLocation;

@end
