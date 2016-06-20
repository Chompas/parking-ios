//
//  CompassView.h
//  ParkingApp
//
//  Created by Emiliano Viscarra on 5/24/16.
//  Copyright (c) 2016 Emiliano Viscarra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompassView : UIView {
    CGPoint center;
    float width, height;
}

@property(nonatomic, strong) UIColor *schemeColor;

@end
