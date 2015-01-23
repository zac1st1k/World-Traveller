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

static NSString *const kCLIENTID = @"ILDHWOBLICIZAGB2IIYMMSRLVMSSFCK2Q15PQWHQSEX4QYYN";
static NSString *const kCLIENTSECRET = @"0B33HRK4NKSSLGBRQKDQYYQERFGLGAQSBF3BB24HRN4HOSEB";

@interface XZZListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *venues;

@end

@implementation XZZListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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

#pragma mark - IBActions

- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender {
    [[XZZFourSquareSessionManager sharedClient] GET:@"venues/search?ll=30.25,-97.75" parameters:@{@"client_id":kCLIENTID, @"client_secret":kCLIENTSECRET, @"v":@"20140416"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        self.venues = responseObject;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    [self.tableView reloadData];
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

@end
