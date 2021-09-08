//
//  model.m
//  launcher
//
//  Created by mac mini on 02/09/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#import "Model.h"
#import "../gobridge/fff.h"

@implementation LauncherState

@synthesize portBegin;
@synthesize portEnd;
@synthesize enablePortForwarding;
@synthesize autoUpgrade;

@synthesize hasUpdate;
@synthesize isDockerRunning;
@synthesize currentVersion;
@synthesize imageName;
@synthesize latestVersion;

- (id) init
{
    self = [super init];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandler:) name:@"Eezy" object:nil];
    return self;
}

- (void)notificationHandler:(NSNotification *) notification{
//    NSLog(@"model > %@ %@", notification.object, notification.userInfo);
    
    self.portBegin            = notification.userInfo[@"portRangeBegin"];
    self.portEnd              = notification.userInfo[@"portRangeEnd"];
    self.enablePortForwarding = notification.userInfo[@"enablePortForwarding"];
    self.autoUpgrade          = notification.userInfo[@"autoUpgrade"];
    // enableNode

    self.imageName            = notification.userInfo[@"imageName"];
    self.hasUpdate            = notification.userInfo[@"hasUpdate"];
    self.currentVersion       = notification.userInfo[@"currentVersion"];
    self.latestVersion        = notification.userInfo[@"latestVersion"];
    self.isDockerRunning      = notification.userInfo[@"isDockerRunning"];
}

- (void)setState {
    SetStateArgs s;

    s.enablePortForwarding = [self.enablePortForwarding boolValue];
    s.portRangeBegin = [self.portBegin intValue];
    s.portRangeEnd = [self.portEnd intValue];
    s.autoUpgrade = [self.autoUpgrade boolValue];

    SetStateAndConfig(&s);
}

@end
