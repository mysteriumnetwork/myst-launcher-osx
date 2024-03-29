//
//  ModalWindowDelegate.m
//  Cocoa Modal Window
//
//  Created by @zensey on 15/08/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//
#import "NetworkingModalDelegate.h"
#import "AppDelegate.h"
#import "../gobridge/gobridge.h"

@implementation ModalWindowDelegate

- (id)init
{
    self = [super initWithWindowNibName:@"NetworkingModal"];

    // enable window delegate extension
    [[self window] setDelegate:self];
    [self autorelease];
    
    // init data
    [self.editPortRangeBegin setStringValue:[NSString stringWithFormat:@"%@", mod.portBegin]];
    [self.editPortRangeEnd setStringValue:[NSString stringWithFormat:@"%@", mod.portEnd]];
    [self.checkBox setState: [mod.enablePortForwarding boolValue]];
    
    [self checkPressed:nil];
    return self;
}

- (void)notificationHandler:(NSNotification *) notification
{}

-(void)windowWillClose:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSApp stopModalWithCode:NSModalResponseCancel];
}

- (IBAction)checkPressed:(id)sender
{
    BOOL y = (self.checkBox.state == NSControlStateValueOn);
    
    [self.editPortRangeBegin setEnabled:y];
    [self.editPortRangeEnd setEnabled:y];
}

- (IBAction)cancelPressed:(id)sender
{
    [self close];
    [NSApp stopModalWithCode:NSModalResponseCancel];
}

- (bool)validatePortRange:(int)portBegin :(int)portEnd
{
    if (portEnd-portBegin+1 < 100) {
        return false;
    }
    if (portBegin > 65535) {
        return false;
    }
    if (portEnd > 65535) {
        return false;
    }
    return true;
}

- (IBAction)okPressed:(id)sender
{
    int portBegin = [self.editPortRangeBegin intValue];
    int portEnd = [self.editPortRangeEnd intValue];
    BOOL y = (self.checkBox.state == NSControlStateValueOn);

    if (y) {
        bool valid = [self validatePortRange:portBegin :portEnd];
        if (!valid) {
            NSAlert *alert = [[NSAlert alloc] init];
            [alert setMessageText:@"Port range"];
            [alert setInformativeText:@"Wrong port range.\nPorts shall be in range of 1000..65535.\nNumber of ports in the range shall be at least 100."];
            [alert addButtonWithTitle:@"OK"];
            [alert setAlertStyle:NSAlertStyleWarning];
            [alert beginSheetModalForWindow:self.window completionHandler:nil];
            return;
        }
    }
    mod.portBegin = @(portBegin);
    mod.portEnd = @(portEnd);
    mod.enablePortForwarding = [NSNumber numberWithBool:[self.checkBox integerValue]];
    [mod setNetworkConfig];
    
    [self close];
    [NSApp stopModalWithCode:NSModalResponseOK];
}

- (IBAction)linkInfoPressed:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: @"https://help.mystnodes.com/en/articles/8005269-manual-port-forwarding"]];
}
@end
