//
//  Venue.m
//  World Traveller
//
//  Created by Zac on 24/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import "Venue.h"
#import "Contact.h"
#import "FSCategory.h"
#import "Location.h"
#import "Menu.h"


@implementation Venue

@dynamic id;
@dynamic name;
@dynamic categories;
@dynamic contact;
@dynamic location;
@dynamic menu;

+ (NSString *)keyPathForResponseObject
{
    return @"response.venues";
}

@end
