//
//  MainWindowDelegate.m
//  Launcher Main Window
//
//  Created by @zensey on 15/08/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//
#import "MainWindowDelegate.h"
#import "NetworkingModalDelegate.h"
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

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandlerMode:) name:@"new_mode" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandlerState:) name:@"new_state" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandlerLog:) name:@"log" object:nil];
    }
    
    return self;
}

- (void) windowDidLoad {  
    img1 = [NSImage imageNamed:@"img_128x128"];
    [img1 setSize: NSMakeSize(64, 64)];
    [self.img setImage:img1];
    
    [self refreshFrame];
}

- (void) refreshFrame {
    
    switch ([mod.mode intValue]) {
        case UIState_Initial:
        {
            [self.labelCurrentVersion setObjectValue: mod.currentVersion];
            [self.labelLatestVersion setObjectValue: mod.latestVersion];
            [self.labelImageName setObjectValue: mod.imageName];

            NSString *v = nil;
            if (mod.hasUpdate) {
                v = [mod.hasUpdate integerValue] ? @"YES" : @"NO";
            }
            [self.labelHasUpdate setObjectValue:v];
            
            v = [mod.enablePortForwarding intValue] ? @"Port forwarding mode" : @"Port restricted cone NAT";
            [self.labelNetworkMode setObjectValue: v];
            
            [self.labelDocker setObjectValue:      [Utils getRunStateString:mod.isDockerRunning] ];
            [self.labelContainer setObjectValue:   [Utils getRunStateString:mod.isContainerRunning] ];
            [self.checkBoxAutoUpgrade setState:    [mod.autoUpgrade boolValue]];
            
            [self.statusDocker setState: [Utils getStateViewStatus: mod.isDockerRunning ]];
            [self.statusNode setState: [Utils getStateViewStatus: mod.isContainerRunning ]];
        }
            break;
    
            
        case UIState_InstallInProgress:
        case UIState_InstallFinished:
        case UIState_InstallError:
            [self.checkBoxDocker         setState:[Utils getStateView2Status: mod.checkDocker ]];
            [self.checkBoxVirtualization setState:[Utils getStateView2Status: mod.checkVirt ]];
            [self.checkBoxDownloadFiles  setState:[Utils getStateView2Status: mod.downloadFiles ]];
            [self.checkBoxInstallDocker  setState:[Utils getStateView2Status: mod.installDocker ]];
            break;
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

- (IBAction)linkNodeUIPressed:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: @"http://localhost:4449"]];
}

- (IBAction)linkMMNPressed:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: @"https://my.mysterium.network/"]];
}

- (IBAction)checkBoxClick:(NSButton*)sender
{
    mod.autoUpgrade = @((long)sender.state);
    [mod setState];
    
    
    if ([self.checkBoxAutoUpgrade intValue] == 0) {
        [self.st setState:1];

    } else {
        [self.st setState:2];

    }
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
    NSNumber *n = mod.mode;
    switch ([n intValue]) {
        case UIState_Initial:
            [[self window] setContentView:self.v11];
            break;
            
        case UIState_InstallNeeded:
            [[self window] setContentView:self.v0];
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
        case UIState_InstallError:
            [self.finishButton setEnabled:YES];
            [self.finishButton setTitle:@"Exit"];
            break;
            
        default:
            break;
    }
}

- (void)notificationHandlerLog:(NSNotification *) notification
{
    NSString *n = notification.userInfo[@"msg"];

    [self.textView setEditable:YES];
    [self.textView setSelectedRange:NSMakeRange(-1,0)];
    [self.textView insertText:n replacementRange:NSMakeRange(-1, 0)];
    [self.textView setEditable:NO];
}

- (IBAction)finishPressed:(id)sender
{
    GoDialogueComplete();
    if ([mod.mode intValue] == UIState_InstallError) {
        [NSApp terminate:nil];
    }
}


@end
