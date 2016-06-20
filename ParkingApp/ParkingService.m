//
//  ParkingService.m
//  ParkingApp
//
//  Created by Emiliano Viscarra on 6/20/16.
//  Copyright © 2016 Emiliano Viscarra. All rights reserved.
//

#import "ParkingService.h"

static NSString * const kBaseURL = @"http://localhost:3000";

@implementation ParkingService

+ (ParkingService *)sharedManager {
    static dispatch_once_t pred;
    
    static ParkingService *_sharedManager = nil;
    dispatch_once(&pred, ^{
        _sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    });
    
    return _sharedManager;
}

#pragma mark - Initialization

- (ParkingService *)initWithDelegate:(id<ParkingServiceDelegate>)delegate {
    if ((self = [super init])) {
        self.delegate = delegate;
    }
    return self;
}


#pragma mark - Public

- (void)getParkingsNearby:(CLLocation *)currentLocation {
    // callbacks.
    void (^success)(AFHTTPRequestOperation *operation, id responseObject) =
    ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *parkingArray = [[NSMutableArray alloc] init];
        for (NSDictionary *parkingDict in responseObject) {
            NSError *error;
            Parking *parking = [[Parking alloc] initWithDictionary:parkingDict error:&error];
            [parkingArray addObject:parking];
        }
        [self.delegate didLoadParkings:parkingArray];
    };
    
    void (^failure)(AFHTTPRequestOperation *operation, NSError *error) =
    ^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate didFailLoadingParkings];
    };
    
    // pull hotels for current location.
    [[ParkingService sharedManager] GET:@"/parkings"
                             parameters:nil
                                success:success
                                failure:failure];
}

@end
