//
//  OFTestRssParser.m
//  ObjectiveFeed
//
//  Created by Jorge Bernal on 10/1/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

#import "OFTestRssParser.h"


@implementation OFTestRssParser
- (void)testFeedData {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[OFTestRssParser class]] pathForResource:@"sample-rss-2.xml" ofType:nil]];
    
    parser = [OFParser parserWithData:data];
    GHAssertNotNil(parser, @"parser should exist");
    [parser parseWithError:nil];
    
    GHAssertNotNil(parser.feed, @"parser should have a feed property");
    GHAssertNotNil(parser.feed.entries, @"parser should have some entries");
    
    int entryCount = [parser.feed.entries count];
    GHAssertEquals(4, entryCount, @"feed should have 4 entries");

    NSDate *expectedDate = [NSDate dateWithTimeIntervalSince1970:1055217600];
    GHAssertEqualStrings(@"Liftoff News", parser.feed.title, @"feed title isn't right");
    GHAssertEqualStrings(@"http://liftoff.msfc.nasa.gov/", parser.feed.link, @"feed link isn't right");
    GHAssertEqualObjects(expectedDate, parser.feed.updated, @"feed update date isn't right");
    
    OFEntry *firstEntry = [parser.feed.entries objectAtIndex:0];
    GHAssertEqualStrings(@"Star City", firstEntry.title, @"entry title isn't right");
    GHAssertEqualStrings(@"http://liftoff.msfc.nasa.gov/news/2003/news-starcity.asp", firstEntry.link, @"entry link isn't right");
    expectedDate = [NSDate dateWithTimeIntervalSince1970:1054633161];
    GHAssertEqualObjects(expectedDate, firstEntry.updated, @"entry update date isn't right");
}
@end
