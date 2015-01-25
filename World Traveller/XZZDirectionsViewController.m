//
//  XZZDirectionsViewController.m
//  World Traveller
//
//  Created by Zac on 24/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import "XZZDirectionsViewController.h"
#import "XZZDirectionsListViewController.h"

@interface XZZDirectionsViewController ()

@end

@implementation XZZDirectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listDirectionsBarButtonItem.enabled = false;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    self.directionsMapVIew.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[XZZDirectionsListViewController class]]) {
        XZZDirectionsListViewController *directionsListVC = segue.destinationViewController;
        directionsListVC.steps = self.steps;
    }
}

- (IBAction)listDirectionsBarButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"directionTolistSegue" sender:nil];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [manager stopUpdatingLocation];
    self.directionsMapVIew.showsUserLocation = YES;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000);
    [self.directionsMapVIew setRegion:[self.directionsMapVIew regionThatFits:region] animated:YES];
    float latitude = [self.venue.location.lat floatValue];
    float longitude = [self.venue.location.lng floatValue];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) addressDictionary:nil];
    MKMapItem *destinationMapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    [self getDirections:destinationMapItem];
}

#pragma mark - Directions Helper

- (void)getDirections:(MKMapItem *)destination
{
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = destination;
    request.requestsAlternateRoutes = YES;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else {
            //Do somthing with directions here
            [self showRoute:response];
            self.listDirectionsBarButtonItem.enabled = YES;

        }
    }];
}

#pragma mark - Route Helper

- (void)showRoute:(MKDirectionsResponse *)response
{
//    self.steps = response.routes;
//    for (MKRoute *route in self.steps) {
//        for (MKRouteStep *step in route.steps) {
//            NSLog(@"Step instructions: %@", step.instructions);
//        }
//        [self.directionsMapVIew addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
//    }
    self.steps = response.routes;
    NSLog(@"route count is %i", (unsigned int)[response.routes count]);
    for (self.i = (int)[response.routes count] - 1; self.i >= 0; self.i --) {
        NSLog(@"i is %i", self.i);
        MKRoute *route = self.steps[self.i];
        for (MKRouteStep *step in route.steps) {
            [self.directionsMapVIew addOverlay:step.polyline level:MKOverlayLevelAboveRoads];
            NSLog(@"this is step %@", step);
        }
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    if (self.i == 0)
        renderer.strokeColor = [UIColor redColor];
    else if (self.i == 1)
        renderer.strokeColor = [UIColor blueColor];
    else if (self.i == 2)
        renderer.strokeColor = [UIColor greenColor];
    renderer.lineWidth = 5.0;
    return renderer;
}

@end
