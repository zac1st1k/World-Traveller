//
//  ViewController.m
//  World Traveler
//
//  Created by Zac on 22/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import "XZZListViewController.h"
#import "XZZFourSquareSessionManager.h"
#import "AFMMRecordResponseSerializationMapper.h"
#import "AFMMRecordResponseSerializer.h"
#import "CoreData+MagicalRecord.h"
#import "Venue.h"
#import "Location.h"
#import "XZZMapViewController.h"
#import "AppDelegate.h"

#define latitudeOffset 0.01
#define longitudeOffset 0.01

static NSString *const kCLIENTID = @"ILDHWOBLICIZAGB2IIYMMSRLVMSSFCK2Q15PQWHQSEX4QYYN";
static NSString *const kCLIENTSECRET = @"0B33HRK4NKSSLGBRQKDQYYQERFGLGAQSBF3BB24HRN4HOSEB";

@interface XZZListViewController () <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) NSArray *venues;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation XZZListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.menuBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"Helvetica-Bold" size:25.0], NSFontAttributeName,
                                        nil]
                              forState:UIControlStateNormal];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 10.0;
    [self.locationManager requestAlwaysAuthorization];
    
    XZZFourSquareSessionManager *sessionManager = [XZZFourSquareSessionManager sharedClient];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    AFHTTPResponseSerializer *HTTPResponsSerializer = [AFJSONResponseSerializer serializer];
    AFMMRecordResponseSerializationMapper *mapper = [[AFMMRecordResponseSerializationMapper alloc] init];
    [mapper registerEntityName:@"Venue" forEndpointPathComponent:@"venues/search?"];
    AFMMRecordResponseSerializer *serializer = [AFMMRecordResponseSerializer serializerWithManagedObjectContext:context responseObjectSerializer:HTTPResponsSerializer entityMapper:mapper];
    sessionManager.responseSerializer = serializer;
    self.tableView.dataSource = self;
    self.tableView.delegate  = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = sender;
    XZZMapViewController *mapVC = segue.destinationViewController;
    mapVC.venue = self.venues[indexPath.row];
}

#pragma mark - IBActions

- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self.locationManager startUpdatingLocation];
}

- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender {
    [[self drawerControllerFromAppDelegate] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - CLLocation Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [self.locationManager stopUpdatingLocation];
    [[XZZFourSquareSessionManager sharedClient] GET:[NSString stringWithFormat:@"venues/search?ll=%f,%f", location.coordinate.latitude + latitudeOffset, location.coordinate.longitude + longitudeOffset] parameters:@{@"client_id":kCLIENTID, @"client_secret":kCLIENTSECRET, @"v":@"20140416"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        self.venues = responseObject;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];

}

#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.venues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    Venue *venue = self.venues[indexPath.row];
    cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.location.address;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"listToMapSegue" sender:indexPath];
}

#pragma mark - Drawer Controller

- (MMDrawerController *)drawerControllerFromAppDelegate
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.drawerController;
}

@end
