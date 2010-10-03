//
//  OFLog.m
//  ObjectiveFeed
//
//  Created by Jorge Bernal on 10/1/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

#import "OFLog.h"

bool OF_DEBUG_MODE = false;
@implementation OFLog
+ (void)setDebug:(bool)enabled {
    OF_DEBUG_MODE = enabled;
}

+ (void)log:(NSString *)fmt, ... {
    if (OF_DEBUG_MODE) {
        va_list ap;
        va_start(ap, fmt);
        NSLogv(fmt, ap);
    }
}
@end
