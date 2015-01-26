//
//  XZZAddVenueViewController.m
//  World Traveller
//
//  Created by Zac on 25/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import "XZZAddVenueViewController.h"
#import "AppDelegate.h"
#import "Venue.h"
#import "FSCategory.h"
#import "Contact.h"

@interface XZZAddVenueViewController ()

@end

@implementation XZZAddVenueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.menuBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Helvetica-Bold" size:25.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
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

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender {
    if ([self.venueNameTextField.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Blank Field" message:@"Please Enter a Venue Name" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        Venue *venue = [Venue MR_createEntity];
        venue.name = self.venueNameTextField.text;
        Contact *contact = [Contact MR_createEntity];
        contact.phone = self.phoneNumberTextField.text;
        venue.contact = contact;
        FSCategory *category = [FSCategory MR_createEntity];
        category.name = self.typeOfFoodTextField.text;
        venue.categories = category;
        venue.favourite = [NSNumber numberWithBool:YES];
        [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
    }
}

- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender {
    [[self drawerControllerFromAppDelegate] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

#pragma mark - Drawer Controller

- (MMDrawerController *)drawerControllerFromAppDelegate
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.drawerController;
}

@end
