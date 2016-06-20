//
//  DetailViewController.m
//  ParkingApp
//
//  Created by Emiliano Viscarra on 2/13/16.
//  Copyright (c) 2016 Emiliano Viscarra. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Colours.h"

@implementation DetailViewController

#pragma mark - Private

- (void)updateMapViewRegion {
    MKMapPoint annotationPoint = MKMapPointForCoordinate(_location.coordinate);
    
    MKMapRect zoomRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
    for (id <MKAnnotation> annotation in _mapView.annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    
    [_mapView setVisibleMapRect:zoomRect
                    edgePadding:UIEdgeInsetsMake(100, 100, 100, 100)
                       animated:NO];
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Info";
    
    // show location in map.
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(_parking.lat, _parking.lon);
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = location;
    annotation.title = _parking.name;
    annotation.subtitle = _parking.address;
    [_mapView addAnnotation:annotation];
    [_mapView selectAnnotation:annotation animated:YES];
    
    [self updateMapViewRegion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
