//
//  XZZMenuViewController.m
//  World Traveller
//
//  Created by Zac on 25/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import "XZZMenuViewController.h"
#import "XZZListViewController.h"
#import "AppDelegate.h"

@interface XZZMenuViewController ()

@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) UINavigationController *listNavigationController;
@property (strong, nonatomic) UINavigationController *favouriteVenuewsNavigationViewController;
@property (strong, nonatomic) UINavigationController *addVenueNavigationViewController;

@end

@implementation XZZMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    if (!self.viewControllers) {
        self.viewControllers = [[NSMutableArray alloc] initWithCapacity:3];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (!self.listNavigationController) {
        MMDrawerController *drawerController = [self drawerControllerFromAppDelegate];
        self.listNavigationController = (UINavigationController *)drawerController.centerViewController;
        [self.viewControllers addObject:self.listNavigationController];
    }
    if (!self.favouriteVenuewsNavigationViewController) {
        self.favouriteVenuewsNavigationViewController = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"XZZFavouriteVenuesViewControllerID"];
        [self.viewControllers addObject:self.favouriteVenuewsNavigationViewController];
    }
    if (!self.addVenueNavigationViewController) {
        self.addVenueNavigationViewController = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"XZZAddVenueViewControllerID"];
        [self.viewControllers addObject:self.addVenueNavigationViewController];
    }
    
    [self.tableView reloadData];
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

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewControllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Home";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"Favourites";
    }
//    else if (indexPath.row == 2) {
//        cell.textLabel.text = @"Add Venue";
//    }
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMDrawerController *drawerController = [self drawerControllerFromAppDelegate];
    [drawerController setCenterViewController:self.viewControllers[indexPath.row] withCloseAnimation:YES completion:nil];
}

#pragma mark - Drawer Controller Helper

- (MMDrawerController *)drawerControllerFromAppDelegate
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.drawerController;
}

@end
