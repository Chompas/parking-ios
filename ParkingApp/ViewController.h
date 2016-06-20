//
//  ViewController.h
//  ParkingApp
//
//  Created by Emiliano Viscarra on 5/24/16.
//  Copyright (c) 2016 Emiliano Viscarra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkingService.h"

@interface ViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, ParkingServiceDelegate, CLLocationManagerDelegate>

@property(nonatomic, weak) IBOutlet UITableView *tableView;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
