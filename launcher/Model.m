//
//  model.m
//  launcher
//
//  Created by mac mini on 02/09/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#import "Model.h"

@implementation LauncherState

@synthesize portBegin;
@synthesize portEnd;
@synthesize enablePortForwarding;

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
    NSLog(@"model > %@ %@", notification.object, notification.userInfo[@"imageName"]);
    
    self.portBegin            = notification.userInfo[@"portRangeBegin"];
    self.portEnd              = notification.userInfo[@"portRangeEnd"];
    self.enablePortForwarding = notification.userInfo[@"enablePortForwarding"];

    self.imageName            = notification.userInfo[@"imageName"];
    self.hasUpdate            = notification.userInfo[@"hasUpdate"];
    self.currentVersion       = notification.userInfo[@"currentVersion"];
    self.latestVersion        = notification.userInfo[@"latestVersion"];
    self.isDockerRunning      = notification.userInfo[@"isDockerRunning"];
}

@end
