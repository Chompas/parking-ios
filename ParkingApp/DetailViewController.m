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
#import "BookingService.h"
#import "BookingViewController.h"

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
    
    CLLocationDistance distance = [_location distanceFromLocation:[_parking location]];
    if (distance > 999) {
        __distanceLabel.text = [NSString stringWithFormat:@"A %.1f KM", distance / 1000];
    } else {
        __distanceLabel.text = [NSString stringWithFormat:@"A %d MTS", (int) distance];
    }
    
    __nameLabel.text = _parking.name;
    __priceLabel.text = [NSString stringWithFormat:@"$%@/hora", _parking.price];
    __addressLabel.text = _parking.address;
    __occupancyLabel.text = [NSString stringWithFormat:@"%i", _parking.occupancy];
    __timeLabel.text = [NSString stringWithFormat:@"HORARIO: %@", _parking.hours];
    
    [self updateMapViewRegion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)bookParking:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Realizar Reserva"
                                                                             message:@"Desea realizar la reserva?"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancelar", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Reservar", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                                   [[[BookingService alloc] initWithDelegate:self] bookParking:_parking];
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - ParkingAvailabilityServiceDelegate

- (void)didBookParking:(Parking *)parking
{
    _parking.occupancy--;
    __occupancyLabel.text = [NSString stringWithFormat:@"%i", _parking.occupancy];
    
    [self performSegueWithIdentifier: @"bookSegue" sender: self];
}

- (void)didFailBookingParking
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry :("
                                                                   message:@"No more availability"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"Unable to book parking, something is wrong.");
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"bookSegue"]){
        BookingViewController *vc = [segue destinationViewController];
        [vc setParking:_parking];
    }
    
}

@end
