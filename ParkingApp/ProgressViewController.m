//
//  ProgressViewController.m
//  ParkingApp
//
//  Created by Emiliano Viscarra on 6/20/16.
//  Copyright © 2016 Emiliano Viscarra. All rights reserved.
//

#import "ProgressViewController.h"

@interface ProgressViewController () {
    NSDate *bookingdate;
    int seconds;
    int minutes;
}

@end

@implementation ProgressViewController

- (NSString*)getTimeStr : (int) secondsElapsed {
    seconds = secondsElapsed % 60;
    minutes = (secondsElapsed / 60) % 60;
    _progressPriceLabel.text = [NSString stringWithFormat:@"$%.02ld", [_parking.price integerValue] * minutes / 60];
    return [NSString stringWithFormat:@"%02dm %02ds", minutes, seconds];
}

- (void)timerController {
    seconds++;
    _progressTimeLabel.text = [self getTimeStr:seconds];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _nameLabel.text = _parking.name;
    _addressLabel.text = _parking.address;
    _priceLabel.text = [NSString stringWithFormat:@"$%@/hora", _parking.price];
    _progressPriceLabel.text = @"$0.00";
    
    bookingdate = [NSDate date];
    
    NSTimer *mainTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                          target:self
                                                        selector:@selector(timerController)
                                                        userInfo:nil 
                                                         repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
