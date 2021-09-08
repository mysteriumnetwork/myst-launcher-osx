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
@property (weak) IBOutlet NSMenuItem *itemEnableNode;

- (IBAction)showMain:(id)sender;
- (IBAction)enableNode:(id)sender;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {   
    mod = [[LauncherState alloc] init];

    if (modalWindowDelegate == nil) {
        modalWindowDelegate = [[MainWindowDelegate alloc] init];
    }
    NSWindow *modalWindow = [modalWindowDelegate window];
    [modalWindowDelegate showWindow:modalWindow];
    
    [self setMenuItemState];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    NSLog(@"applicationWillTerminate");
}

- (IBAction)showMain:(id)sender {   
    NSWindow *modalWindow = [modalWindowDelegate window];
    [modalWindowDelegate showWindow:modalWindow];
}

- (IBAction)enableNode:(id)sender {
    NSLog(@"enableNode %@", mod.autoUpgrade);

    if ([mod.autoUpgrade isEqualToNumber:@0]) {
        mod.autoUpgrade = @1;
    } else {
        mod.autoUpgrade = @0;
    }
    [mod setState];
    
    [self setMenuItemState];
}

- (void)setMenuItemState {
    [self.itemEnableNode setState:(NSControlStateValue) [mod.autoUpgrade intValue]];
}
@end
