//
//  UpdateNetworkModalDelegate.m
//  Mysterium Node Launcher
//
//  Created by mac mini on 10/11/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#import "UpdateNetworkModalDelegate.h"
#import "AppDelegate.h"
#import "../gobridge/gobridge.h"

@implementation UpdateNetworkModalDelegate


- (id)init
{
    self = [super initWithWindowNibName:@"UpdateNetwork"];

    // enable window delegate extension
    [[self window] setDelegate:self];
    [self autorelease];
    
    // init data
    [self.lbNetworkCaption setStringValue:mod.networkCaption];
    return self;
}

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
    GoUpdateToMainnet();
    [self close];
    [NSApp stopModalWithCode:NSModalResponseOK];
}

- (IBAction)linkAboutMainnetPressed:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: @"https://mysterium.network"]];
}
@end
