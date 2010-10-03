//
//  OFTestProcessorDetect.m
//  ObjectiveFeed
//
//  Created by Jorge Bernal on 10/1/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

#import "ObjectiveFeed.h"
#import "OFTestProcessorDetect.h"

@implementation OFTestProcessorDetect
- (void) setUp
{
    // Create data structures here.
    [OFLog setDebug:YES];
}

- (void) tearDown
{
    // Release data structures here.
}

- (void) testGuessParserAtom {
    NSBundle *bundle = [NSBundle bundleForClass:[OFTestProcessorDetect class]];
    NSString *filePath = [bundle pathForResource:@"sample-atom.xml" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    GHAssertNotNil(data, @"Can't find atom fixture");
    
    OFParser *parser = [OFParser parserWithData:data];
    GHAssertNotNil(parser, @"Can't create parser");
    
    NSError *error;
    bool result = [parser parseWithError:&error];
    GHAssertTrue(result, @"parser should not fail");
    GHAssertNil(error, @"error is: %@", error);
    GHAssertEquals(parser.feedType, OFParserFeedTypeAtom, @"Wrong feed type guessed");
}

- (void) testGuessParserRss20 {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[OFTestProcessorDetect class]] pathForResource:@"sample-rss-2.xml" ofType:nil]];
    GHAssertNotNil(data, @"Can't find rss20 fixture");
    
    OFParser *parser = [OFParser parserWithData:data];
    GHAssertNotNil(parser, @"Can't create parser");

    NSError *error = nil;
    bool result = [parser parseWithError:&error];
    GHAssertTrue(result, @"parser should not fail");
    GHAssertNil(error, @"no errors, please");
    GHAssertEquals(parser.feedType, OFParserFeedTypeRss20, @"Wrong feed type guessed");
}

@end
