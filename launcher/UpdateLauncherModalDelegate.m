//
//  UpdateNetworkModalDelegate.m
//  Mysterium Node Launcher
//
//  Created by mac mini on 10/11/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#import "UpdateLauncherModalDelegate.h"
#import "AppDelegate.h"
#import "../gobridge/gobridge.h"

@implementation UpdateLauncherModalDelegate

- (id)init
{
    self = [super initWithWindowNibName:@"UpdateLauncher"];

    // enable window delegate extension
    [[self window] setDelegate:self];
    [self autorelease];
    
    // init data
    [self.lbCurrentVersion setStringValue:mod.launcherVersionCurrent];
    [self.lbLatestVersion setStringValue:mod.launcherVersionLatest];

    return self;
}

-(void)windowWillClose:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSApp stopModalWithCode:NSModalResponseCancel];
}

- (IBAction)okPressed:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: mod.productVersionLatestUrl]];
    
    [self close];
    [NSApp stopModalWithCode:NSModalResponseOK];
}

@end
