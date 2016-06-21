//
//  ProgressViewController.h
//  ParkingApp
//
//  Created by Emiliano Viscarra on 6/20/16.
//  Copyright © 2016 Emiliano Viscarra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parking.h"

@interface ProgressViewController : UIViewController

@property (nonatomic, strong) Parking *parking;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressPriceLabel;

@end
