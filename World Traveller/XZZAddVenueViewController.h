//
//  XZZAddVenueViewController.h
//  World Traveller
//
//  Created by Zac on 25/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZZAddVenueViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *venueNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *typeOfFoodTextField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *menuBarButtonItem;

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
