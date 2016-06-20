//
//  ViewController.m
//  ParkingApp
//
//  Created by Emiliano Viscarra on 5/24/16.
//  Copyright (c) 2016 Emiliano Viscarra. All rights reserved.
//

#import "ViewController.h"
#import "ParkingCell.h"
#import "Colours.h"
#import "ColorUtils.h"
#import "DetailViewController.h"
#import "NyanView.h"
#import "Parking.h"

@implementation ViewController {
    CLLocationManager *locationManager;
    CLLocation *location;
    CLHeading *heading;
    NSArray *parkings;
    NSArray *primaryGradient;
    NSArray *secondaryColors;
    NSArray *secondaryGradient;
    UIView *nyanView;
}

#pragma mark - Private

- (void)startUpdatingLocation
{
    locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];
	[locationManager startUpdatingHeading];
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Estacionamientos";
    
    parkings = [NSArray array];
    
    // nyan nyan nyan.
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    nyanView = [[NyanView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    [_tableView setContentInset:UIEdgeInsetsMake(-[UIScreen mainScreen].bounds.size.height, 0, 0, 0)];
    
    // setup layout.
    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor blackColor];
    _tableView.separatorColor = [UIColor blackColor];
    
    [self startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *controller = [segue destinationViewController];
    
    NSInteger row = [_tableView indexPathForSelectedRow].row - 1;
    controller.location = location;
    controller.parking = [parkings objectAtIndex:row];
    controller.primaryColor = [primaryGradient objectAtIndex:row];
    controller.secondaryColor = [secondaryGradient objectAtIndex:row];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.row == 0) {
        UITableViewCell *nyanCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:nil];
        nyanCell.selectionStyle = UITableViewCellSelectionStyleNone;
        nyanCell.backgroundColor = [UIColor clearColor];
        [nyanCell addSubview:nyanView];
        
        cell = nyanCell;
    } else {
        ParkingCell *parkingCell = [tableView dequeueReusableCellWithIdentifier:@"ParkingCell"];
        
        NSUInteger row = indexPath.row - 1;
        
        // content.
        parkingCell.parking = [parkings objectAtIndex:row];
        parkingCell.location = location;
        parkingCell.heading = heading;
        
        cell = parkingCell;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [parkings count] + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Change the selected background view of the cell.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [[UIScreen mainScreen] bounds].size.height;
    }
    
    return 122.0;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if ([parkings count] == 0 && location == nil) {
        [[[ParkingService alloc] initWithDelegate:self] getParkingsNearby:newLocation];
    }
    location = newLocation;
    
    NSDictionary *info = [NSDictionary dictionaryWithObject:location forKey:@"location"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationUpdatedNotification
                                                        object:nil
                                                      userInfo:info];
}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading
{
    heading = newHeading;
    
    NSDictionary *info = [NSDictionary dictionaryWithObject:heading forKey:@"heading"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kHeadingUpdatedNotification
                                                        object:nil
                                                      userInfo:info];
}

#pragma mark - HotelAvailabilityServiceDelegate

- (void)didLoadParkings:(NSArray *)parkingList
{
    // sort results by distance.
    parkings = [parkingList sortedArrayUsingComparator:^NSComparisonResult(id o1, id o2) {
        CLLocation *l1 = [(Parking *)o1 location], *l2 = [(Parking *)o2 location];
        
        CLLocationDistance d1 = [l1 distanceFromLocation:location];
        CLLocationDistance d2 = [l2 distanceFromLocation:location];
        
        return d1 < d2 ? NSOrderedAscending : d1 > d2 ? NSOrderedDescending : NSOrderedSame;
    }];
    
    // we're done.
    [_activityIndicator stopAnimating];
    [_tableView reloadData];
}

- (void)didFailLoadingParkings
{
    NSLog(@"Unable to load parkings, something is wrong.");
}

@end
