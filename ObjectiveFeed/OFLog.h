//
//  OFLog.h
//  ObjectiveFeed
//
//  Created by Jorge Bernal on 10/1/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

@interface OFLog : NSObject {
}
+ (void)setDebug:(bool)enabled;
+ (void)log:(NSString *)fmt, ...;
@end

#define OFLog(fmt, ...) [OFLog log:(@"%s:%d " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__]