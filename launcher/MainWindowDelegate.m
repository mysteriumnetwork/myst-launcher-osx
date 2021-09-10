//
//  MainWindowDelegate.m
//  Launcher Main Window
//
//  Created by @zensey on 15/08/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//
#import "MainWindowDelegate.h"
#import "ModalWindowDelegate.h"
#import "AppDelegate.h"
#import "../gobridge/fff.h"
#import "utils.h"

@implementation MainWindowDelegate

- (id)init
{
    if (self = [super initWithWindowNibName:@"MainWindow"]) {
        // enable window delegate extension
        [[self window] setDelegate:self];
        [self autorelease];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandlerState:) name:@"new_state" object:nil];
    }
    return self;
}

- (void) windowDidLoad {
    //NSLog(@"MainWindow > windowDidLoad %@", self);
    
    self.labelNetworkMode.cursor = [NSCursor pointingHandCursor];
    [self.labelNetworkMode setTarget:self];
    [self.labelNetworkMode setAction:@selector(networkingLabelPressed:)];
    
//    [self.img setImage:[NSImage imageNamed:@"playstore-icon (1)"]];
    img1 = [NSImage imageNamed:@"img_128x128"];
    img2 = [NSImage imageNamed:@"img_128x128-active"];
    [img1 setSize: NSMakeSize(96, 96)];
    [img2 setSize: NSMakeSize(96, 96)];

    [self refreshFrame];
}

- (void) refreshFrame {
    NSLog(@"refreshFrame >");
    
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
    [self.labelDocker setObjectValue:  [Utils getRunStateString:mod.isDockerRunning] ];
    [self.labelContainer setObjectValue:  [Utils getRunStateString:mod.isContainerRunning] ];
    [self.checkBox setState:(NSControlStateValue) [mod.autoUpgrade boolValue]];
    
    if ([mod.isContainerRunning intValue]==2) {
        [self.img setImage:img2];
    } else {
        [self.img setImage:img1];
    }
}

- (void)notificationHandlerState:(NSNotification *) notification
{
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
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: @"http://localhost:4449"]];
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
