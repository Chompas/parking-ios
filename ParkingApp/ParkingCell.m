//
//  ParkingCell.m
//  ParkingApp
//
//  Created by Emiliano Viscarra on 6/20/16.
//  Copyright © 2016 Emiliano Viscarra. All rights reserved.
//

#import "ParkingCell.h"
#import "Colours.h"

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation ParkingCell

#pragma mark - Private

- (double)calculateAngleFromCurrentLocation:(CLLocationCoordinate2D)current
                                 toLocation:(CLLocationCoordinate2D)fixed
{
    double longitude = fixed.longitude - current.longitude;
    
    double y = sin(longitude) * cos(fixed.latitude);
    double x = cos(current.latitude) * sin(fixed.latitude) -
    sin(current.latitude) * cos(fixed.latitude) * cos(longitude);
    
    double degrees = RADIANS_TO_DEGREES(atan2(y, x));
    return degrees < 0 ? degrees = -degrees : 360 - degrees;
}

- (void)updateLocation:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    if ([info objectForKey:@"location"] != nil) {
        self.location = (CLLocation *)[info objectForKey:@"location"];
    }
}

- (void)updateHeading:(NSNotification *)notification
{
    
    // make sure we've a location already since it's required to calculate heading direction.
    NSDictionary *info = notification.userInfo;
    if (_location != nil && [info objectForKey:@"heading"] != nil) {
        self.heading = (CLHeading *)[info objectForKey:@"heading"];
    }
}

#pragma mark - NSObject

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateLocation:)
                                                     name:kLocationUpdatedNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateHeading:)
                                                     name:kHeadingUpdatedNotification
                                                   object:nil];
    }
    
    return self;
}

#pragma mark - Overriden Properties

- (void)setParking:(Parking *)parking
{
    _parking = parking;
    
    _nameLabel.text = parking.name;
    _addressLabel.text = parking.address;
}

- (void)setLocation:(CLLocation *)location
{
    _location = location;
    
    CLLocationDistance distance = [_location distanceFromLocation:[_parking location]];
    if (distance > 999) {
        _distanceLabel.text = [NSString stringWithFormat:@"%.1f kms", distance / 1000];
    } else {
        _distanceLabel.text = [NSString stringWithFormat:@"%d mts", (int) distance];
    }
}

- (void)setHeading:(CLHeading *)heading
{
    CLLocationCoordinate2D toLocation = { _parking.lat, _parking.lon };
    double degrees = [self calculateAngleFromCurrentLocation:_location.coordinate
                                                  toLocation:toLocation];
    double rads = DEGREES_TO_RADIANS(degrees - heading.trueHeading);
    
    // rotate compass.
    [UIView animateWithDuration:1.0 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationBeginsFromCurrentState:YES];
        _compassView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
    }];
}

@end
