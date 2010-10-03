//
//  OFParser.m
//  ObjectiveFeed
//
//  Created by Jorge Bernal on 10/1/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

#import "ObjectiveFeedInternal.h"

@implementation OFParser
@synthesize feedType;
@synthesize delegate;
@synthesize feed;

+ (OFParser *)parserWithData:(NSData *)data {
    return [[[OFParser alloc] initWithData:data] autorelease];
}

+ (OFParser *)parserWithURL:(NSURL *)url {
    return [[[OFParser alloc] initWithURL:url] autorelease];
}

- (OFParser *)initWithData:(NSData*)data {
    if (self = [super init]) {
        currentError = nil;
        feedType = OFParserFeedTypeUnknown;
        feed = nil;
        xmlParser = [[NSXMLParser alloc] initWithData:data];
        [xmlParser setDelegate:self];
    }
    
    return self;
}

- (OFParser *)initWithURL:(NSURL*)url {
    // FIXME: handle url errors
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [self initWithData:data];
}

// FIXME: this error management sucks, find a better way
- (bool)parseWithError:(NSError **)error {
    [xmlParser parse];
    
    if (currentError != nil) {
        if (error) {
            *error = currentError;
        }
        
        return NO;
    } else {
        feed = feedProcessor.feed;
        
        return YES;
    }
}

- (void)dealloc {
    [xmlParser release];
    if (feedProcessor != nil) {
        [feedProcessor release];
    }
    if (delegate != nil) {
        [delegate release];
    }
    
    [super dealloc];
}

#pragma mark -
#pragma mark NSXMLParserDelegate protocol

- (void)checkProcessor {
    if (feedProcessor == nil) {
        currentError = [NSError errorWithDomain:@"ObjectiveFeed" code:OFParserErrorParsingWithoutProcessor userInfo:nil];
        [xmlParser abortParsing];
        OFLog(@"aborting parse: %@", currentError);
    }
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
}
- (void)parserDidEndDocument:(NSXMLParser *)parser {
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if (feedProcessor == nil) {
        if ([elementName isEqualToString:@"feed"]) {
            feedType = OFParserFeedTypeAtom;
            feedProcessor = [[OFFeedProcessorAtom alloc] init];
        }
        if ([elementName isEqualToString:@"rss"]) {
            // FIXME: what to do if version != 2.0 ?
            feedType = OFParserFeedTypeRss20;
            feedProcessor = [[OFFeedProcessorRss alloc] init];
        }
    }
    [self checkProcessor];
    
    [feedProcessor parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    [self checkProcessor];
    [feedProcessor parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self checkProcessor];
    [feedProcessor parser:parser foundCharacters:string];
}

- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment {
    [self checkProcessor];
    [feedProcessor parser:parser foundComment:comment];
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    [self checkProcessor];
    [feedProcessor parser:parser foundCDATA:CDATABlock];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    [self checkProcessor];
    [feedProcessor parser:parser parseErrorOccurred:parseError];
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    [self checkProcessor];
    [feedProcessor parser:parser validationErrorOccurred:validationError];
}

@end
