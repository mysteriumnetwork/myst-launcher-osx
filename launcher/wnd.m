//
//  wnd.m
//  launcher
//
//  Created by mac mini on 16/08/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

//#include "c.h"
//#import "appdelegate.h"
// #import "app.h"
//#import "ModalWindowDelegate.h"


/*
void menuFix() {
    if ([[NSBundle mainBundle] bundleIdentifier] != nil) {
        return;
    }

    NSRunningApplication *app = [NSRunningApplication currentApplication];
    [app hide];
    [app unhide];
    [app activateWithOptions:NSApplicationActivateIgnoringOtherApps];
}

AppDelegate *myst_applicationDelegate = nil;
//ModalWindowDelegate *windowDelegate = nil;

int
StartApp_(void) {
    [NSAutoreleasePool new];
    [NSApplication sharedApplication];

    // In Snow Leopard, programs without application bundles and Info.plist files
    // don't get a menubar and can't be brought to the front unless the
    // presentation option is changed
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    [NSApp activateIgnoringOtherApps:YES];

    myst_applicationDelegate = [[AppDelegate alloc] init];
    [NSApp setDelegate:myst_applicationDelegate];
    [NSApp finishLaunching];


    id menubar = [[NSMenu new] autorelease];
    id appMenuItem = [[NSMenuItem new] autorelease];
    [menubar addItem:appMenuItem];
    [NSApp setMainMenu:menubar];

    id appMenu = [[NSMenu new] autorelease];
    id appName = [[NSProcessInfo processInfo] processName];
    id quitTitle = [@"Quit " stringByAppendingString:appName];
    id quitMenuItem = [[[NSMenuItem alloc] initWithTitle:quitTitle
        action:@selector(terminate:) keyEquivalent:@"q"]
              autorelease];

    [appMenu addItem:quitMenuItem];
    [appMenuItem setSubmenu:appMenu];

    id window = [[[NSWindow alloc]
        initWithContentRect:NSMakeRect(0, 0, 600, 600)
        styleMask:(NSTitledWindowMask |
                     NSClosableWindowMask |
                     NSMiniaturizableWindowMask |
                     NSResizableWindowMask |
                     NSUnifiedTitleAndToolbarWindowMask )
        backing:NSBackingStoreBuffered
        defer:NO]
        autorelease];
    [window cascadeTopLeftFromPoint:NSMakePoint(20,20)];
    [window setTitle:appName];
    [window makeKeyAndOrderFront:nil];

    //Window Delegate
    //windowDelegate = [[ModalWindowDelegate alloc] init];
    //[window setDelegate:windowDelegate];
    //[window setDelegate:windowDelegate];

    
//NSArray * arr =[NSBundle loadNibNamed:@"CustomView" owner:nil];
 [[NSBundle mainBundle] loadNibNamed:@"CustomView"
                                      owner:nil
                            topLevelObjects:nil];
// CustomView * customView = [arr firstObject];
//     NSArray *arr =[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:nil options:nil];
//     UIView *view = [arr firstObject];
//    [window setContentView:view];


    menuFix();


    [NSApp run];
    return 0;
}
*/


