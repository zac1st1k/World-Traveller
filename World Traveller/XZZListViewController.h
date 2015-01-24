//
//  ViewController.h
//  World Traveler
//
//  Created by Zac on 22/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZZListViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *menuBarButtonItem;

- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender;

@end

