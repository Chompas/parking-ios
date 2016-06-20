//
//  ParkingCell.h
//  ParkingApp
//
//  Created by Emiliano Viscarra on 6/20/16.
//  Copyright © 2016 Emiliano Viscarra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompassView.h"
#import "Parking.h"

static NSString * const kLocationUpdatedNotification = @"LOCATION_UPDATED_NOTIF";
static NSString * const kHeadingUpdatedNotification = @"HEADING_UPDATED_NOTIF";

@interface ParkingCell : UITableViewCell

@property(nonatomic, weak) IBOutlet CompassView *compassView;
@property(nonatomic, weak) IBOutlet UILabel *nameLabel;
@property(nonatomic, weak) IBOutlet UILabel *addressLabel;
@property(nonatomic, weak) IBOutlet UILabel *distanceLabel;

@property(nonatomic, strong) Parking *parking;
@property(nonatomic, strong) CLLocation *location;
@property(nonatomic, strong) CLHeading *heading;

@end
