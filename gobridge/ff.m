#import "ff.h"


void macSendState(NSState *s) {
    NSLog(@"macSendState >>>");

    id dict = @{
        @"imageName": [[NSString alloc] initWithUTF8String:s->imageName],
        @"latestVersion": [[NSString alloc] initWithUTF8String:s->latestVersion],
        @"currentVersion": [[NSString alloc] initWithUTF8String:s->currentVersion],
        @"hasUpdate": @(s->hasUpdate),
        @"dockerRunning": @(s->dockerRunning),
        @"containerRunning": @(s->containerRunning),
    };
    
    // free strings
    free(s->latestVersion);
    free(s->currentVersion);
    free(s->imageName);
    
    dispatch_async(dispatch_get_main_queue(),^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"state" object:nil userInfo:dict];
    });
    return;
}

void macSendConfig(NSConfig *s) {
    NSLog(@"macSendConfig >>>");

    id dict = @{       
        @"enabled": @(s->enabled),
        @"enablePortForwarding": @(s->enablePortForwarding),
        @"portRangeBegin": @(s->portRangeBegin),
        @"portRangeEnd": @(s->portRangeEnd),
        @"autoUpgrade": @(s->autoUpgrade),
    };
       
    dispatch_async(dispatch_get_main_queue(),^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"config" object:nil userInfo:dict];
    });
    return;
}

void macSendModal(NSModal *s) {
    NSLog(@"macSendNodal >>>");

    id dict = @{
        @"title": @(s->title),
        @"msg": @(s->msg),
        @"modal_type": @(s->modal_type),
    };
    
    // free strings
    free(s->title);
    free(s->msg);
    
    dispatch_async(dispatch_get_main_queue(),^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"modal" object:nil userInfo:dict];
    });
    return;
}
