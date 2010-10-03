//
//  OFFeedProcessorRss.m
//  ObjectiveFeed
//
//  Created by Jorge Bernal on 10/1/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

#import "ObjectiveFeedInternal.h"
#import "OFDate.h"

@implementation OFFeedProcessorRss
@synthesize feed;

- (id)init {
    if (self = [super init]) {
        parsingItem = NO;
        currentString = nil;
    }
    
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    currentElement = [elementName copy];
    currentString = [[NSMutableString alloc] init];
    
    if ([elementName isEqualToString:@"channel"]) {
        feed = [[OFFeed alloc] init];
    } else if ([elementName isEqualToString:@"item"]) {
        currentEntry = [[OFEntry alloc] init];
        parsingItem = YES;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (parsingItem) {
        // Item elements
        if ([elementName isEqualToString:@"item"]) {
            [self.feed.entries addObject:currentEntry];
            [currentEntry release];
            currentEntry = nil;
            parsingItem = NO;
        } else if ([elementName isEqualToString:@"title"]) {
            currentEntry.title = currentString;
        } else if ([elementName isEqualToString:@"link"]) {
            currentEntry.link = currentString;
        } else if ([elementName isEqualToString:@"pubDate"]) {
            currentEntry.updated = [OFDate dateWithRFC822:currentString];
        }
    } else {
        // Channel elements
        if ([elementName isEqualToString:@"title"]) {
            feed.title = currentString;
        } else if ([elementName isEqualToString:@"link"]) {
            feed.link = currentString;
        } else if ([elementName isEqualToString:@"pubDate"]) {
            feed.updated = [OFDate dateWithRFC822:currentString];
        }
    }
    
    [currentString release];
    currentString = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment {
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
}
@end
