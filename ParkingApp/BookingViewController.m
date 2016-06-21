//
//  BookingViewController.m
//  ParkingApp
//
//  Created by Emiliano Viscarra on 6/20/16.
//  Copyright © 2016 Emiliano Viscarra. All rights reserved.
//

#import "BookingViewController.h"
#import "QRCodeGenerator.h"
#import <Mapkit/Mapkit.h>
#import "ProgressViewController.h"

@implementation BookingViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _nameLabel.text = _parking.name;
    _addressLabel.text = _parking.address;
    _QRImage.image = [QRCodeGenerator qrImageForString:_parking._id imageSize:_QRImage.bounds.size.width];
}

#pragma mark - IBActions

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelAction:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Cancelar Reserva"
                                                                             message:@"Desea cancelar la reserva?"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancelar", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Mantener", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)mapDirections:(id)sender {
    
    CLLocationCoordinate2D coordinate = [_parking location].coordinate;
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                   addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    [mapItem setName:_parking.name];
    // Pass the map item to the Maps app
    [mapItem openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
}

- (IBAction)showProgress:(id)sender {
    [self performSegueWithIdentifier: @"progressSegue" sender: self];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"progressSegue"]){
        ProgressViewController *vc = [segue destinationViewController];
        [vc setParking:_parking];
    }
    
}

@end
