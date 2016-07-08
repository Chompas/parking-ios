//
//  BookingViewController.h
//  ParkingApp
//
//  Created by Emiliano Viscarra on 6/20/16.
//  Copyright © 2016 Emiliano Viscarra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parking.h"
#import "Booking.h"

@interface BookingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *QRImage;
@property (nonatomic, strong) Parking *parking;
@property (nonatomic, strong) Booking *booking;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *reservationCodeLabel;

@end
