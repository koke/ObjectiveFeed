//
//  RootViewController.h
//  Example-iPhone
//
//  Created by Jorge Bernal on 10/3/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectiveFeed.h"

@interface RootViewController : UITableViewController<UIWebViewDelegate> {
    UIWebView *webView;
    UIViewController *webViewController;
    IBOutlet UIBarButtonItem *reloadButton;
    IBOutlet UITableView *newsTable;
    OFFeed *feed;
    NSString *currentUrl;
    NSMutableData *receivedData;
}
- (IBAction)reloadFeed;

@end
