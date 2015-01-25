//
//  XZZDirectionsViewController.h
//  World Traveller
//
//  Created by Zac on 24/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"
#import "Location.h"

@interface XZZDirectionsViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *listDirectionsBarButtonItem;
@property (strong, nonatomic) IBOutlet MKMapView *directionsMapVIew;
@property (strong, nonatomic) Venue *venue;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *steps;
@property (nonatomic) int i;

- (IBAction)listDirectionsBarButtonPressed:(UIBarButtonItem *)sender;

@end
