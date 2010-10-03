//
//  OFFeedProcessorRss.h
//  ObjectiveFeed
//
//  Created by Jorge Bernal on 10/1/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

@interface OFFeedProcessorRss : NSObject<OFFeedProcessorProtocol> {
    bool parsingItem;
    OFEntry *currentEntry;
    NSMutableString *currentString;
    NSString *currentElement;
}

@end
