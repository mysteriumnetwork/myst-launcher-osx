#import "ff.h"


void
macSend(NSState *s) {
    NSLog(@"macCall >>>");

    id dict = @{

        @"imageName": [[NSString alloc] initWithUTF8String:s->imageName],
        @"latestVersion": [[NSString alloc] initWithUTF8String:s->latestVersion],
        @"currentVersion": [[NSString alloc] initWithUTF8String:s->currentVersion],
        @"hasUpdate": @(s->hasUpdate),


        @"enablePortForwarding": @(s->enablePortForwarding),
        @"isDockerRunning": @(s->dockerRunning),
        @"portRangeBegin": @(s->portRangeBegin),
        @"portRangeEnd": @(s->portRangeEnd),

    };
    
    // free strings
    free(s->latestVersion);
    
    dispatch_async(dispatch_get_main_queue(),^{
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"my_notification" object:nil, userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Eezy" object:nil userInfo:dict];
    });
    return;
}




