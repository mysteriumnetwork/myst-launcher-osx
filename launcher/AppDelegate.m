//
//  AppDelegate.m
//  launcher
//
//  Created by @zensey on 15/08/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//
	
#import "AppDelegate.h"
#import "MainWindowDelegate.h"
#import "ModalWindowDelegate.h"
#import "../gobridge/gobridge.h"

LauncherState *mod = nil;

@implementation AppDelegate
@synthesize statusBarMenu;

- (void) applicationWillTerminate:(NSNotification *)aNotification {
    NSLog(@"applicationWillTerminate >");
    GoOnAppExit();
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {   
    mod = [[LauncherState alloc] init];

    if (!self.modalWindowDelegate) {
        self.modalWindowDelegate = [[MainWindowDelegate alloc] init];
    }
    NSWindow *modalWindow = [self.modalWindowDelegate window];
    [self.modalWindowDelegate showWindow:modalWindow];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandlerConfig:) name:@"new_config" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandlerState:) name:@"new_state" object:nil];

    
    NSStatusItem  *statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    statusItem.button.image = [NSImage imageNamed:@"icon"];
    statusItem.button.action = @selector(statusButtonClicked:);
    statusItem.button.target = self;
    [statusItem setMenu:self.statusBarMenu];
}

- (void)statusButtonClicked:(id)sender
{
//      [NSApp hide:nil];
//    if (NSApp.hidden || !self.mainWindow.visible)
//    {
//        [NSApp unhide:nil];
//        [NSApp activateIgnoringOtherApps:YES];
//        [self.mainWindow setIsVisible:YES];
//    } else {
//        [NSApp hide:nil];
//    }
}

- (void)notificationHandlerConfig:(NSNotification *) notification{
    //self.itemEnableNode = notification.userInfo[@"enabled"];
    NSLog(@"notificationHandlerConfig");
    [self setMenuItemState];
}

- (void)notificationHandlerState:(NSNotification *) notification{
    //self.itemEnableNode = notification.userInfo[@"enabled"];
}

- (IBAction)showMain:(id)sender {   
    NSWindow *modalWindow = [self.modalWindowDelegate window];
    [self.modalWindowDelegate showWindow:modalWindow];
}

- (IBAction)enableNode:(id)sender {
    NSLog(@"enableNode %@", mod.enabled);

    if ([mod.enabled isEqualToNumber:@0]) {
        mod.enabled = @1;
    } else {
        mod.enabled = @0;
    }
    [mod setState];
    [self setMenuItemState];
}

- (void)setMenuItemState {
    [self.itemEnableNode setState:(NSControlStateValue) [mod.enabled intValue]];
}
@end
