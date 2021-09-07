//
//  ModalWindowDelegate.m
//  Cocoa Modal Window
//
//  Created by Nikola Grujic on 17/01/2020.
//  Copyright © 2020 Mac Developers. All rights reserved.
//

#import "MainWindowDelegate.h"
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
}

- (void) refreshFrame {
    // init data
    
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
    
    //[self.checkBox setState: [mod.enablePortForwarding boolValue]];
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


#pragma mark Action methods

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

- (IBAction)okPressed1:(NSButton*)sender
{
    NSLog(@"OK >>> %d", (long)sender.state);

    mod.autoUpgrade = @((long)sender.state);
    [mod setState];
}
@end
