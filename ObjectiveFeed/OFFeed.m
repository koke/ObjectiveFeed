//
//  OFFeed.m
//  ObjectiveFeed
//
//  Created by Jorge Bernal on 10/1/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

#import "ObjectiveFeedInternal.h"

@implementation OFFeed
@synthesize title, link, updated, entries;

- (id)init {
    if (self = [super init]) {
        entries = [NSMutableArray array];
        [entries retain];
    }
    
    return self;
}

- (void)dealloc {
    [title release];
    [link release];
    [updated release];
    
    [super dealloc];
}
@end