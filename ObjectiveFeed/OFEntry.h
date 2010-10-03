//
//  OFEntry.h
//  ObjectiveFeed
//
//  Created by Jorge Bernal on 10/1/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

@interface OFEntry : NSObject {
    NSString *title;
    NSString *link;
    NSDate *updated;
}
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *link;
@property (nonatomic,retain) NSDate *updated;
@end
