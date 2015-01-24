//
//  XZZDirectionsListViewController.m
//  World Traveller
//
//  Created by Zac on 25/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import "XZZDirectionsListViewController.h"

@interface XZZDirectionsListViewController ()

@end

@implementation XZZDirectionsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table View Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.steps count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MKRoute *route = self.steps[section];
    return [route.steps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    MKRoute *route = self.steps[indexPath.section];
    MKRouteStep *step = route.steps[indexPath.row];
    cell.textLabel.text = step.instructions;
    cell.detailTextLabel.text = step.notice;
    [self loadSnapShots:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    UILabel *label = [[UILabel alloc] init];
////    label.backgroundColor = [UIColor clearColor];
////    label.textColor = [UIColor blueColor];
////    label.font = [UIFont boldSystemFontOfSize:14];
//    
//    label.backgroundColor = [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0f];
//    label.text = [NSString stringWithFormat:@"Route %i", (int)section];
//    return label;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    /* Section header is in 0th index... */
//    [label setText:string];
    [label setText:[NSString stringWithFormat:@"Route %i", (int)section + 1]];
    [view addSubview:label];
    label.backgroundColor = [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0f];
    return view;
}

#pragma mark - Map SnapShots Helper

- (void)loadSnapShots:(NSIndexPath *)indexPath
{
    MKRoute *route = self.steps[indexPath.section];
    MKRouteStep *step = route.steps[indexPath.row];
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    options.scale = [UIScreen mainScreen].scale;
    MKMapRect rect;
    rect.origin = step.polyline.points[0];
    rect.size = MKMapSizeMake(0.0, 0.0);
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(rect);
    region.span.latitudeDelta = 0.001;
    region.span.longitudeDelta = 0.001;
    options.region = region;
    options.size = CGSizeMake(40.0, 40.0);
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.imageView.image = snapshot.image;
            [cell setNeedsLayout];
        }
    }];
}

@end
