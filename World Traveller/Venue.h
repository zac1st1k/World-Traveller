//
//  Venue.h
//  World Traveller
//
//  Created by Zac on 25/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "XZZRecord.h"

@class Contact, FSCategory, Location, Menu;

@interface Venue : XZZRecord

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * favourite;
@property (nonatomic, retain) FSCategory *categories;
@property (nonatomic, retain) Contact *contact;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) Menu *menu;

+ (NSString *)keyPathForResponseObject;

@end