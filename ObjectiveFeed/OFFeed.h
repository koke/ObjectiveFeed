//
//  OFFeed.h
//  ObjectiveFeed
//
//  Created by Jorge Bernal on 10/1/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

@interface OFFeed : NSObject {
    NSString *title;
    NSString *link;
    NSDate *updated;
    NSMutableArray *entries;
}
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *link;
@property (nonatomic,retain) NSDate *updated;
@property (nonatomic,retain) NSMutableArray *entries;
@end