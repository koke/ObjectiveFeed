//
//  Example_MacAppDelegate.h
//  Example-Mac
//
//  Created by Jorge Bernal on 10/3/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface Example_MacAppDelegate : NSObject <NSApplicationDelegate,NSTableViewDelegate,NSTableViewDataSource> {
    NSWindow *window;
    IBOutlet WebView *webView;
    IBOutlet NSTableView *tableView;
    IBOutlet NSTextField *addressField;
    NSString *currentUrl;
    OFParser *parser;
    OFFeed *feed;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)go:(id)sender;
@end
