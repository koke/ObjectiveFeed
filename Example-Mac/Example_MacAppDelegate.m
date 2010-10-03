//
//  Example_MacAppDelegate.m
//  Example-Mac
//
//  Created by Jorge Bernal on 10/3/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

#import "ObjectiveFeed.h"
#import "Example_MacAppDelegate.h"

@implementation Example_MacAppDelegate

@synthesize window;

- (void)parseFeed {
    if (parser) {
        [parser release];
    }
    parser = [OFParser parserWithURL:[NSURL URLWithString:currentUrl]];
    [parser retain];
    
    [parser parseWithError:nil];
    if (feed) {
        [feed release];
    }
    feed = parser.feed;
    NSLog(@"feed parsed: %@ (%@) : %@", feed, feed.title, feed.entries);
    [feed retain];
    [window setTitle:feed.title];
    
    [tableView reloadData];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
    currentUrl = [[NSString alloc] initWithString:@"http://www.jorgebernal.info/feed"];
    [currentUrl retain];
    
    [addressField setStringValue:currentUrl];    
    [self parseFeed];
}

- (void)dealloc {
    [currentUrl release];
    [parser release];
    [feed release];
    
    [super dealloc];
}

- (IBAction)go:(id)sender {
    NSLog(@"go: %@", [addressField stringValue]);
    [currentUrl release];
    currentUrl = [addressField stringValue];
    [currentUrl retain];
    [self parseFeed];
}

#pragma mark -
#pragma mark NSTableViewDelegate

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
    OFEntry *entry = [feed.entries objectAtIndex:[tableView selectedRow]];
    NSURL *url = [NSURL URLWithString:entry.link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[webView mainFrame] loadRequest:request];
}

#pragma mark -
#pragma mark NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    NSLog(@"numberOfRowsInTableView: %i", [feed.entries count]);
    return [feed.entries count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    OFEntry *entry;
    NSString *title;
    
    NSParameterAssert(rowIndex >= 0 && rowIndex < [feed.entries count]);
    entry = [feed.entries objectAtIndex:rowIndex];
    title = entry.title;
    return title;
}

@end
