//
//  XZZFourSquareSessionManager.h
//  World Traveler
//
//  Created by Zac on 22/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//


#import "AFHTTPSessionManager.h"

@interface XZZFourSquareSessionManager : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
