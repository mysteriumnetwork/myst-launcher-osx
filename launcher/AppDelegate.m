//
//  AppDelegate.m
//  launcher
//
//  Created by @zensey on 15/08/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//
	
#import "AppDelegate.h"
#import "MainWindowDelegate.h"
#import "NetworkingModalDelegate.h"
#import "UpgradeModalDelegate.h"
#import "../gobridge/gobridge.h"

#include <sys/stat.h>
#include <copyfile.h>

LauncherState *mod = nil;

@implementation AppDelegate
@synthesize statusBarMenu;

- (void) applicationWillTerminate:(NSNotification *)aNotification {
    GoOnAppExit();
    NSLog(@"application exit >");
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    GoInit((char*)[resourcePath UTF8String]);
    GoStart();
    
    mod = [[LauncherState alloc] init];

    if (!self.mainWin) {
        self.mainWin = [[MainWindowDelegate alloc] init];
    }
    NSWindow *modalWindow = [self.mainWin window];
    [self.mainWin showWindow:modalWindow];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandlerConfig:) name:@"new_config" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandlerState:) name:@"new_state" object:nil];

    
    NSStatusItem  *statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    statusItem.button.image = [NSImage imageNamed:@"icon"];
    statusItem.button.action = @selector(statusButtonClicked:);
    statusItem.button.target = self;
    [statusItem setMenu:self.statusBarMenu];
    
    [NSApp activateIgnoringOtherApps:YES];
}

- (IBAction)openNodeUIAction:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: @"http://localhost:4449"]];
}

- (void)statusButtonClicked:(id)sender{
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
    NSWindow *modalWindow = [self.mainWin window];
    [self.mainWin showWindow:modalWindow];
}

- (IBAction)showUpgradeDlg:(id)sender {
    NSWindowController *modalWindowDelegate = [[UpgradeModalDelegate alloc] init];
    NSWindow *modalWindow = [modalWindowDelegate window];

    NSModalResponse response = [NSApp runModalForWindow:modalWindow ]; // relativeToWindow:self.window - deprecated
    if (response == NSModalResponseOK) {
        NSLog(@"NSModalResponseOK");
    }
}

- (IBAction)showNetworkingDlg:(id)sender {
    NSWindowController *modalWindowDelegate = [[ModalWindowDelegate alloc] init];
    NSWindow *modalWindow = [modalWindowDelegate window];

    NSModalResponse response = [NSApp runModalForWindow:modalWindow ]; // relativeToWindow:self.window - deprecated
    if (response == NSModalResponseOK) {
        NSLog(@"NSModalResponseOK");
    }
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
