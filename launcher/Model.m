//
//  model.m
//  launcher
//
//  Created by @zensey on 02/09/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "Model.h"
#include "../gobridge/gobridge.h"
#import "UpdateLauncherModalDelegate.h"

@implementation LauncherState

@synthesize portBegin;
@synthesize portEnd;
@synthesize enablePortForwarding;
@synthesize autoUpgrade;
@synthesize enabled;
@synthesize backend;

@synthesize hasUpdate;
@synthesize isDockerRunning;
@synthesize isContainerRunning;
@synthesize currentVersion;
@synthesize imageName;
@synthesize latestVersion;
@synthesize checkVirt;
@synthesize checkDocker;
@synthesize downloadFiles;
@synthesize installDocker;

@synthesize network;
@synthesize networkCaption;
@synthesize launcherHasUpdate;
@synthesize productVersionLatestUrl;
- (id) init
{
    self = [super init];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandlerState:) name:@"state" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandlerConfig:) name:@"config" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandlerModal:) name:@"modal" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandlerMode:) name:@"mode" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandlerDialogue:) name:@"dialogue" object:nil];

    return self;
}

// Installation mode
- (void)notificationHandlerMode:(NSNotification *) notification
{
    self.mode = notification.userInfo[@"mode"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"new_mode" object:nil];
}

- (void)notificationHandlerState:(NSNotification *) notification{
    //NSLog(@"notificationHandlerState > %@", notification.userInfo);

    self.imageName            = notification.userInfo[@"imageName"];
    self.hasUpdate            = notification.userInfo[@"hasUpdate"];
    self.currentVersion       = notification.userInfo[@"currentVersion"];
    self.latestVersion        = notification.userInfo[@"latestVersion"];
    self.isDockerRunning      = notification.userInfo[@"dockerRunning"];
    self.isContainerRunning   = notification.userInfo[@"containerRunning"];
    self.networkCaption       = notification.userInfo[@"networkCaption"];

    self.checkVirt     = notification.userInfo[@"checkVirt"];
    self.checkDocker   = notification.userInfo[@"checkDocker"];
    self.downloadFiles = notification.userInfo[@"downloadFiles"];
    self.installDocker = notification.userInfo[@"installDocker"];
    
    self.launcherHasUpdate = notification.userInfo[@"launcherHasUpdate"];
    self.productVersionLatestUrl = notification.userInfo[@"productVersionLatestUrl"];
    self.launcherVersionLatest = notification.userInfo[@"launcherVersionLatest"];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"new_state" object:nil];
}

- (void)notificationHandlerConfig:(NSNotification *) notification{
    NSLog(@"notificationHandlerState > %@", notification.userInfo);
    
    self.portBegin            = notification.userInfo[@"portRangeBegin"];
    self.portEnd              = notification.userInfo[@"portRangeEnd"];
    self.enablePortForwarding = notification.userInfo[@"enablePortForwarding"];
    self.autoUpgrade          = notification.userInfo[@"autoUpgrade"];
    self.enabled              = notification.userInfo[@"enabled"];
    self.backend              = notification.userInfo[@"backend"];
    self.network              = notification.userInfo[@"network"];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"new_config" object:nil];
}

- (void)notificationHandlerModal:(NSNotification *) notification{
    
    NSAlert *a = [[[NSAlert alloc] init] autorelease];
    [a setMessageText:notification.userInfo[@"title"]];
    [a setInformativeText:notification.userInfo[@"msg"]];
    [a setAlertStyle:NSAlertStyleInformational];

    int modalType = (int)[notification.userInfo[@"modal_type"] integerValue];
    switch(modalType) {
        case MODAL_YesNoModal:
            [a addButtonWithTitle:@"Yes"];
            [a addButtonWithTitle:@"No"];
            break;
        case MODAL_ConfirmModal:
        case MODAL_ErrorModal:
            [a addButtonWithTitle:@"OK"];
            break;
        default:
            break;
    }
    
    NSInteger rc = [a runModal];
    switch(rc) {
        case NSAlertFirstButtonReturn:
            GoSetModalResult(IDYES);
            break;
        case NSAlertSecondButtonReturn:
            GoSetModalResult(IDNO);
            break;
    }
}

- (void)notificationHandlerDialogue:(NSNotification *) notification
{
    id id_ = notification.userInfo[@"id"];
    
    if ([id_ intValue] == 1) {
        NSWindowController *modalWindowDelegate = [[UpdateLauncherModalDelegate alloc] init];
        NSWindow *modalWindow = [modalWindowDelegate window];
        NSModalResponse response = [NSApp runModalForWindow:modalWindow ];

        if (response == NSModalResponseCancel) {
            GoTriggerLauncherUpdateOk(0);
        }
        if (response == NSModalResponseOK) {
            GoTriggerLauncherUpdateOk(2);
        }
    }
}

- (void)setState {
    NSConfig s;
    
    s.autoUpgrade = [self.autoUpgrade boolValue];
    s.enabled = [self.enabled boolValue];
    
    const char *b = [self.backend UTF8String];
    // copy string, as we work in a managed env.
    s.backend = malloc(10);
    strcpy(s.backend, b);

    GoSetState(&s);
}

- (void)setNetworkConfig {
    NSConfig s;

    s.enablePortForwarding = [self.enablePortForwarding boolValue];
    s.portRangeBegin = [self.portBegin intValue];
    s.portRangeEnd = [self.portEnd intValue];

    GoSetNetworkConfig(&s);
}


- (bool)currentNetIsMainnet {
    return [self.network isEqual:@"mainnet"] || [self.network isEqual:@""];
}

@end
