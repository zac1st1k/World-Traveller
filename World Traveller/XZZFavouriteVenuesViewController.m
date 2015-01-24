//
//  XZZFavouriteVenuesViewController.m
//  World Traveller
//
//  Created by Zac on 25/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import "XZZFavouriteVenuesViewController.h"
#import "AppDelegate.h"
#import "Venue.h"

@interface XZZFavouriteVenuesViewController ()

@property (strong, nonatomic) NSMutableArray *favourites;

@end

@implementation XZZFavouriteVenuesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.menuBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Helvetica-Bold" size:25.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    if (!self.favourites) {
        self.favourites = [[NSMutableArray alloc] init];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSPredicate *predicateForFavourites = [NSPredicate predicateWithFormat:@"favourite == %@", [NSNumber numberWithBool:YES]];
    self.favourites = [[Venue MR_findAllWithPredicate:predicateForFavourites] mutableCopy];
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

- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender {
    [[self drawerControllerFromAppDelegate] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.favourites count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Venue *venue = self.favourites[indexPath.row];
    cell.textLabel.text = venue.name;
    return cell;
}

#pragma mark - Drawer Controller

- (MMDrawerController *)drawerControllerFromAppDelegate
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.drawerController;
}

@end
