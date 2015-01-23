//
//  XZZMapViewController.h
//  World Traveler
//
//  Created by Zac on 22/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface XZZMapViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) Venue *venue;

@end
