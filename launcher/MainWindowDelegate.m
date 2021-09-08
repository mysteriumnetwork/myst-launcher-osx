//
//  ModalWindowDelegate.m
//  Cocoa Modal Window
//
//  Created by Nikola Grujic on 17/01/2020.
//  Copyright © 2020 Mac Developers. All rights reserved.
//

#import "MainWindowDelegate.h"
#import "ModalWindowDelegate.h"
#import "AppDelegate.h"
#import "../gobridge/fff.h"


@implementation MainWindowDelegate

- (id)init
{
    if (self = [super initWithWindowNibName:@"MainWindow"]) {

        // enable window delegate extension
        [[self window] setDelegate:self];
        
        /*
         *  dont autorelease, as with ARC the window controller gets deallocated unless you make it
         *  a property of the App Delegate
         */
        //[self autorelease];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"Eezy" object:nil];

        [self refreshFrame];
    }
    return self;
}

- (void) windowDidLoad {
    //NSLog(@"MainWindow > windowDidLoad %@", self);
    
    self.labelNetworkMode.cursor = [NSCursor pointingHandCursor];
    
    [self.labelNetworkMode setTarget:self];
    [self.labelNetworkMode setAction:@selector(networkingLabelPressed:)];
}

- (void) refreshFrame {
    [self.labelCurrentVersion setObjectValue: mod.currentVersion];
    [self.labelLatestVersion setObjectValue: mod.latestVersion];
    [self.labelImageName setObjectValue: mod.imageName];

    NSString *v = nil;
    if (mod.hasUpdate) {
        v = [mod.hasUpdate integerValue] ? @"YES" : @"NO";
    }
    [self.labelHasUpdate setObjectValue:v];
    
    if (mod.enablePortForwarding) {
        v = [mod.hasUpdate integerValue] ? @"Port forwarding mode" : @"Port restricted cone NAT";
    }
    [self.labelNetworkMode setObjectValue: v];
    
    [self.labelDocker setObjectValue: [self getRunStateString: [mod.isDockerRunning intValue]]];
    [self.labelContainer setObjectValue: [self getRunStateString: [mod.isContainerRunning intValue]]];
}


NSString *const RunState0 = @"-";
NSString *const RunState1 = @"Starting..";
NSString *const RunState2 = @"Running [OK]";
NSString *const RunState3 = @"Installing..";
NSString *const RunState_ = @"?";


-(NSString*) getRunStateString:(int)state {
    switch (state) {
        case 0:
            return RunState0; break;
        case 1:
            return RunState1; break;
        case 2:
            return RunState2; break;
        case 3:
            return RunState3; break;

        default:
            return RunState_; break;
    }
}

- (void)notificationHandler:(NSNotification *) notification
{
    NSLog(@"MainWindow > notificationHandler %@", notification.name);
    [self refreshFrame];
}

-(void)windowWillClose:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSApp stopModal];
}

- (IBAction)cancelPressed:(id)sender
{
    [self close];
    [NSApp stopModalWithCode:NSModalResponseCancel];
}

- (IBAction)okPressed:(id)sender
{
    NSLog(@"OK >>>");
    //[[self window] setContentView:self.v21];
}

- (IBAction)checkBoxClick:(NSButton*)sender
{
    mod.autoUpgrade = @((long)sender.state);
    [mod setState];
}

- (IBAction)networkingLabelPressed:(id)sender
{
    NSWindowController *modalWindowDelegate = [[ModalWindowDelegate alloc] init];
    NSWindow *modalWindow = [modalWindowDelegate window];

    NSModalResponse response = [NSApp runModalForWindow:modalWindow ]; // relativeToWindow:self.window - deprecated
    if (response == NSModalResponseOK) {
        NSLog(@"NSModalResponseOK");
    }
}
@end
