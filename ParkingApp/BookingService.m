//
//  BookingService.m
//  ParkingApp
//
//  Created by Emiliano Viscarra on 6/20/16.
//  Copyright © 2016 Emiliano Viscarra. All rights reserved.
//

#import "BookingService.h"
#import "Booking.h"

static NSString * const kBaseURL = @"http://localhost:3000";

@implementation BookingService

+ (BookingService *)sharedManager {
    static dispatch_once_t pred;
    
    static BookingService *_sharedManager = nil;
    dispatch_once(&pred, ^{
        _sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    });
    
    return _sharedManager;
}

#pragma mark - Initialization

- (BookingService *)initWithDelegate:(id<BookingServiceDelegate>)delegate {
    if ((self = [super init])) {
        self.delegate = delegate;
    }
    return self;
}


#pragma mark - Public

- (void)bookParking:(Parking *)parking {
    
    void (^success)(AFHTTPRequestOperation *operation, id responseObject) =
    ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        Booking *booking = [[Booking alloc] initWithDictionary:responseObject[@"booking"] error:&error];
        [self.delegate didBookParking:parking withBooking:booking];
    };
    
    void (^failure)(AFHTTPRequestOperation *operation, NSError *error) =
    ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fail");
        [self.delegate didFailBookingParking];
    };
    
    NSString *path = [NSString stringWithFormat:@"/book/%@", parking._id];
    // pull hotels for current location.
    [[BookingService sharedManager] POST:path
                              parameters:nil
                                 success:success
                                 failure:failure];
    
}

@end
