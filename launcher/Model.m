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

@implementation LauncherState

@synthesize portBegin;
@synthesize portEnd;
@synthesize enablePortForwarding;
@synthesize autoUpgrade;
@synthesize enabled;

@synthesize hasUpdate;
@synthesize isDockerRunning;
@synthesize isContainerRunning;
@synthesize currentVersion;
@synthesize imageName;
@synthesize latestVersion;
@synthesize checkVTx;
@synthesize checkDocker;

- (id) init
{
    self = [super init];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandlerState:) name:@"state" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandlerConfig:) name:@"config" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandlerModal:) name:@"modal" object:nil];

    return self;
}

- (void)notificationHandlerState:(NSNotification *) notification{
    NSLog(@"state >> %@ %@", notification.object, notification.userInfo); //

    self.imageName            = notification.userInfo[@"imageName"];
    self.hasUpdate            = notification.userInfo[@"hasUpdate"];
    self.currentVersion       = notification.userInfo[@"currentVersion"];
    self.latestVersion        = notification.userInfo[@"latestVersion"];
    self.isDockerRunning      = notification.userInfo[@"dockerRunning"];
    self.isContainerRunning   = notification.userInfo[@"containerRunning"];
    
    self.checkVTx    = notification.userInfo[@"checkVTx"];
    self.checkDocker = notification.userInfo[@"checkDocker"];

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"new_state" object:nil];
}

- (void)notificationHandlerConfig:(NSNotification *) notification{
//    NSLog(@"config > %@ %@", notification.object, notification.userInfo); //
    
    self.portBegin            = notification.userInfo[@"portRangeBegin"];
    self.portEnd              = notification.userInfo[@"portRangeEnd"];
    self.enablePortForwarding = notification.userInfo[@"enablePortForwarding"];
    self.autoUpgrade          = notification.userInfo[@"autoUpgrade"];
    self.enabled              = notification.userInfo[@"enabled"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"new_config" object:nil];
}

- (void)notificationHandlerModal:(NSNotification *) notification{
//    NSLog(@"modal > %@ %@", notification.object, notification.userInfo); //
    
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
            SetModalResult(IDYES);
            break;
        case NSAlertSecondButtonReturn:
            SetModalResult(IDNO);
            break;
    }
}

- (void)setState {
    SetStateArgs s;

    s.enablePortForwarding = [self.enablePortForwarding boolValue];
    s.portRangeBegin = [self.portBegin intValue];
    s.portRangeEnd = [self.portEnd intValue];
    s.autoUpgrade = [self.autoUpgrade boolValue];
    s.enabled = [self.enabled boolValue];

    SetStateAndConfig(&s);
}

@end