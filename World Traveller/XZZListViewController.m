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

static NSString *const kCLIENTID = @"ILDHWOBLICIZAGB2IIYMMSRLVMSSFCK2Q15PQWHQSEX4QYYN";
static NSString *const kCLIENTSECRET = @"0B33HRK4NKSSLGBRQKDQYYQERFGLGAQSBF3BB24HRN4HOSEB";

@interface XZZListViewController ()

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender {
    [[XZZFourSquareSessionManager sharedClient] GET:@"venues/search?ll=30.25,-97.75" parameters:@{@"client_id":kCLIENTID, @"client_secret":kCLIENTSECRET, @"v":@"20140416"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
@end
