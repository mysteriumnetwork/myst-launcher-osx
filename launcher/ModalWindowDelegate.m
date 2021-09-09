//
//  ModalWindowDelegate.m
//  Cocoa Modal Window
//
//  Created by Nikola Grujic on 17/01/2020.
//  Copyright © 2020 Mac Developers. All rights reserved.
//

#import "ModalWindowDelegate.h"
#import "AppDelegate.h"
#import "../gobridge/fff.h"

@implementation ModalWindowDelegate

- (id)init
{
    self = [super initWithWindowNibName:@"ModalWindow"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandlerState:) name:@"config" object:nil];

    // enable window delegate extension
    [[self window] setDelegate:self];
    [self autorelease];
    
    
    // init data
    [self.editPortRangeBegin setStringValue:[NSString stringWithFormat:@"%@", mod.portBegin]];
    [self.editPortRangeEnd setStringValue:[NSString stringWithFormat:@"%@", mod.portEnd]];
    [self.checkBox setState: [mod.enablePortForwarding boolValue]];
    
    return self;
}

- (void)notificationHandler:(NSNotification *) notification
{
//    NSLog(@"ModalWindow > notificationHandler %@", notification.userInfo);
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
    mod.portBegin = @([self.editPortRangeBegin intValue]);
    mod.portEnd = @([self.editPortRangeEnd intValue]);
    mod.enablePortForwarding = [NSNumber numberWithBool:[self.checkBox integerValue]];
    [mod setState];
    
    [self close];
    [NSApp stopModalWithCode:NSModalResponseOK];
}

@end
