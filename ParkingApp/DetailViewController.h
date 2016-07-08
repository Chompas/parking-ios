//
//  DetailViewController.h
//  ParkingApp
//
//  Created by Emiliano Viscarra on 2/13/16.
//  Copyright (c) 2016 Emiliano Viscarra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Parking.h"
#import "Booking.h"
#import "BookingService.h"

@interface DetailViewController : UIViewController<CLLocationManagerDelegate, BookingServiceDelegate>

@property(nonatomic, weak) CLLocation *location;
@property(nonatomic, strong) Parking *parking;
@property(nonatomic, strong) Booking *booking;
@property(nonatomic, strong) UIColor *primaryColor;
@property(nonatomic, strong) UIColor *secondaryColor;

@property (weak, nonatomic) IBOutlet UILabel *_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *_addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *_priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *_distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *_occupancyLabel;
@property (weak, nonatomic) IBOutlet UILabel *_timeLabel;

@property(nonatomic, weak) IBOutlet MKMapView *mapView;


@end
