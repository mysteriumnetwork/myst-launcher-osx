//
//  AppDelegate.m
//  launcher
//
//  Created by mac mini on 15/08/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//
	
#import "AppDelegate.h"
#import "MainWindowDelegate.h"
#import "ModalWindowDelegate.h"

LauncherState *mod = nil;
NSWindowController *modalWindowDelegate = nil;

@interface AppDelegate ()
@property (weak) IBOutlet ModalWindowDelegate *window;
@property (weak) IBOutlet NSPopUpButton *button;

- (IBAction)showMain:(id)sender;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {   
    mod = [[LauncherState alloc] init];

    if (modalWindowDelegate == nil) {
        modalWindowDelegate = [[MainWindowDelegate alloc] init];
    }
    NSWindow *modalWindow = [modalWindowDelegate window];
    [modalWindowDelegate showWindow:modalWindow];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    NSLog(@"applicationWillTerminate");
}

- (IBAction)showMain:(id)sender {   
    NSWindow *modalWindow = [modalWindowDelegate window];
    [modalWindowDelegate showWindow:modalWindow];
}

@end
