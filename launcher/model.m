//
//  model.m
//  launcher
//
//  Created by mac mini on 02/09/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#import "model.h"

@implementation Config

@synthesize   portBegin;
@synthesize   portEnd;
@synthesize   enableForwarding;

@end


@implementation LauncherState

@synthesize config;
@synthesize portBegin;
@synthesize portEnd;

@synthesize enablePortForwarding;

- (id) init
{
    self = [super init];
    if (self)
    {
        
        config = [[Config alloc] init];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandler:) name:@"Eezy" object:nil];
    return self;
}

- (void)notificationHandler:(NSNotification *) notification{
    NSLog(@"model > %@ %@", notification.object, notification.userInfo);
    
    self.portBegin            = notification.userInfo[@"portRangeBegin"];
    self.portEnd              = notification.userInfo[@"portRangeEnd"];
    self.enablePortForwarding = notification.userInfo[@"enablePortForwarding"];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.button setTitle:@"OK"];
//        [self.labelCurrentVersion setStringValue: notification.userInfo[@"currentVersion"]];
//    });
}

@end
