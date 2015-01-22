//
//  XZZFourSquareSessionManager.m
//  World Traveler
//
//  Created by Zac on 22/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import "XZZFourSquareSessionManager.h"

static NSString *const XZZFoursquareBseURLString = @"https://api.foursquare.com/v2/";

@implementation XZZFourSquareSessionManager

+ (instancetype)sharedClient;
{
    static XZZFourSquareSessionManager *_shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareClient = [[XZZFourSquareSessionManager alloc] initWithBaseURL:[NSURL URLWithString:XZZFoursquareBseURLString]];
    });
    return _shareClient;
}
@end
