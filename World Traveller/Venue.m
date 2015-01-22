//
//  Venue.m
//  World Traveler
//
//  Created by Zac on 22/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import "Venue.h"
#import "Location.h"


@implementation Venue

@dynamic id;
@dynamic name;
@dynamic category;
@dynamic contact;
@dynamic location;
@dynamic menu;

+ (NSString *)keyPathForResponseObject
{
    return @"response.venues";
}

@end