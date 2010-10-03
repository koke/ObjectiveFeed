//
//  Example_iPhoneAppDelegate.h
//  Example-iPhone
//
//  Created by Jorge Bernal on 10/3/10.
//  Copyright 2010 Jorge Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Example_iPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

