//
//  ModalWindowDelegate.m
//  Cocoa Modal Window
//
//  Created by @zensey on 15/08/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//
#import "UpgradeModalDelegate.h"
#import "AppDelegate.h"
#import "../gobridge/gobridge.h"

@implementation UpgradeModalDelegate

- (id)init
{
    self = [super initWithWindowNibName:@"UpgradeModal"];
    GoTriggerCheck();

    // enable window delegate extension
    [[self window] setDelegate:self];
    [self autorelease];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandlerState:) name:@"new_state" object:nil];

    // init data
    [self refreshFrame];
    return self;
}

- (void) refreshFrame {
    [self.lbImageName setStringValue:mod.imageName];
    [self.lbVersionCurrent setStringValue:mod.currentVersion];
    [self.lbVersionLatest setStringValue:mod.latestVersion];
    [self.button setEnabled: [mod.hasUpdate boolValue]];
}

- (void)notificationHandlerState:(NSNotification *) notification{
    [self refreshFrame];
}

- (void)notificationHandler:(NSNotification *) notification
{}

-(void)windowWillClose:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSApp stopModalWithCode:NSModalResponseCancel];
}

- (IBAction)cancelPressed:(id)sender
{
    [self close];
    [NSApp stopModalWithCode:NSModalResponseCancel];
}

- (IBAction)okPressed:(id)sender
{
    GoTriggerUpgrade();
    [self close];
    [NSApp stopModalWithCode:NSModalResponseOK];
}

@end
