//
//  Venue.h
//  World Traveler
//
//  Created by Zac on 22/01/2015.
//  Copyright (c) 2015 1st1k. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "XZZRecord.h"

@class Location;

@interface Venue : XZZRecord

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *category;
@property (nonatomic, retain) NSManagedObject *contact;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) NSManagedObject *menu;

@end
