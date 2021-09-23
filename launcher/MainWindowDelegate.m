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
#import "utils.h"
#include "../gobridge/gobridge.h"

@implementation MainWindowDelegate

- (id)init
{
    if (self = [super initWithWindowNibName:@"MainWindow"]) {
        // enable window delegate extension
        [[self window] setDelegate:self];
        [self autorelease];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandlerMode:) name:@"mode" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandlerState:) name:@"new_state" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandlerLog:) name:@"log" object:nil];
    }
    return self;
}

- (void) windowDidLoad {  
    self.labelNetworkMode.cursor = [NSCursor pointingHandCursor];
    [self.labelNetworkMode setTarget:self];
    [self.labelNetworkMode setAction:@selector(networkingLabelPressed:)];
    
    img1 = [NSImage imageNamed:@"img_128x128"];
    img2 = [NSImage imageNamed:@"img_128x128-active"];
    [img1 setSize: NSMakeSize(64, 64)];
    [img2 setSize: NSMakeSize(64, 64)];

    [self refreshFrame];
}

- (void) refreshFrame {

    if ([[self window] contentView] == self.v11) {
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
        [self.labelDocker setObjectValue:      [Utils getRunStateString:mod.isDockerRunning] ];
        [self.labelContainer setObjectValue:   [Utils getRunStateString:mod.isContainerRunning] ];
        [self.checkBox setState:               [mod.autoUpgrade boolValue]];
        
        if ([mod.isContainerRunning intValue]==2) {
            [self.img setImage:img2];
        } else {
            [self.img setImage:img1];
        }
    }
    
    // installation
    if ([[self window] contentView] == self.v21) {
        [self.checkBoxDocker         setState:[mod.checkDocker boolValue]];
        [self.checkBoxVirtualization setState:[mod.checkVTx boolValue]];
        [self.checkBoxDownloadFiles  setState:[mod.downloadFiles boolValue]];
        [self.checkBoxInstallDocker  setState:[mod.installDocker boolValue]];
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

// Installation mode
- (void)notificationHandlerMode:(NSNotification *) notification
{
    NSNumber *n = notification.userInfo[@"mode"];
    
    switch ([n intValue]) {
        case UIState_Initial:
            [[self window] setContentView:self.v11];
            break;
            
        case UIState_InstallInProgress:
            [self.finishButton setEnabled:NO];
            [[self window] setContentView:self.v21];
            [self.checkBoxVirtualization setState:(NSControlStateValue)NO];
            [self.checkBoxDocker setState:(NSControlStateValue)NO];
            break;
        
        case UIState_InstallFinished:
            [self.finishButton setEnabled:YES];
            break;
        default:
            break;
    }
}

- (void)notificationHandlerLog:(NSNotification *) notification
{
    NSString *n = notification.userInfo[@"msg"];
    NSLog(@"Log > %@", n);

    [self.textView setEditable:YES];
    [self.textView setSelectedRange:NSMakeRange(-1,0)];
    [self.textView insertText:n replacementRange:NSMakeRange(-1, 0)];
    [self.textView setEditable:NO];
}

- (IBAction)finishPressed:(id)sender
{
    GoDialogueComplete();
}


@end
