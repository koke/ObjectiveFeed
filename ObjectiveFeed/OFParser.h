//
//  OFParser.h
//  ObjectiveFeed
//
//  Created by Jorge Bernal on 10/1/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

typedef enum {
    OFParserFeedTypeUnknown,
    OFParserFeedTypeRss20,
    OFParserFeedTypeAtom
} OFParserFeedType;

typedef enum {
    OFParserErrorUnknown,
    OFParserErrorParsingWithoutProcessor
} OFParserError;

#pragma mark -


@class OFParser;
@protocol OFParserDelegateProtocol<NSObject>
@optional
- (void)parser:(OFParser *)parser didParseFeed:(OFFeed *)feed;
- (void)parser:(OFParser *)parser didParseEntry:(OFEntry *)entry;
@end

#pragma mark -

@protocol OFFeedProcessorProtocol<NSObject>
@property (retain,readonly) OFFeed *feed;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment;
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock;
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError;
- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError;
@end

#pragma mark -

/**
  main class to parse feeds
*/

@interface OFParser : NSObject<NSXMLParserDelegate> {
    OFParserFeedType feedType;
    NSXMLParser *xmlParser;
    id<OFFeedProcessorProtocol> feedProcessor;
    OFFeed *feed;
    NSError *currentError;
}
/** Stores the type of feed after it has been detected. See ::OFParserFeedType */
@property (readonly) OFParserFeedType feedType;
@property (retain) id<OFParserDelegateProtocol> delegate;
@property (readonly,retain) OFFeed *feed;

- (OFParser *)initWithData:(NSData*)data;
- (OFParser *)initWithURL:(NSURL*)url;
- (bool)parseWithError:(NSError **)error;
+ (OFParser *)parserWithData:(NSData *)data;
+ (OFParser *)parserWithURL:(NSURL *)url;
@end
