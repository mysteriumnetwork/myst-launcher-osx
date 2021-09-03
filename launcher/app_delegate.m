//
//  AppDelegate.m
//  launcher
//
//  Created by mac mini on 15/08/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//
	
#import "app_delegate.h"

@interface MyAppDelegate ()
//@property (weak) IBOutlet NSWindow *window;
//@property (weak) IBOutlet NSPopUpButton *button;
@end

@implementation MyAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSLog(@"applicationDidFinishLaunching");
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    NSLog(@"applicationWillTerminate");
}

//- (IBAction)buttonPressed:(id)sender {
//    NSLog(@"%@", sender);
//}

@end
