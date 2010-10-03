//
//  OFEntry.m
//  ObjectiveFeed
//
//  Created by Jorge Bernal on 10/1/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

#import "ObjectiveFeedInternal.h"

@implementation OFEntry
@synthesize title, link, updated;

- (void)dealloc {
    [title release];
    [link release];
    [updated release];

    [super dealloc];
}
@end
