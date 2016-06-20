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

@interface DetailViewController : UIViewController<CLLocationManagerDelegate>

@property(nonatomic, weak) CLLocation *location;
@property(nonatomic, strong) Parking *parking;
@property(nonatomic, strong) UIColor *primaryColor;
@property(nonatomic, strong) UIColor *secondaryColor;

@property(nonatomic, weak) IBOutlet MKMapView *mapView;


@end
