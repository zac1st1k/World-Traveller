//
//  XZZMenuViewController.h
//  World Traveller
//
//  Created by Zac on 25/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZZMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
