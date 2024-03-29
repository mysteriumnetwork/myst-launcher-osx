#import "interface.h"


void macSendState(NSState *s) {
    id dict = @{
        @"imageName": [[NSString alloc] initWithUTF8String:s->imageName],
        @"latestVersion": [[NSString alloc] initWithUTF8String:s->latestVersion],
        @"currentVersion": [[NSString alloc] initWithUTF8String:s->currentVersion],
        @"hasUpdate": @(s->hasUpdate),
        @"dockerRunning": @(s->dockerRunning),
        @"containerRunning": @(s->containerRunning),
        @"networkCaption": @(s->networkCaption),

        // instllation state
        @"checkVirt": @(s->checkVirt),
        @"checkDocker": @(s->checkDocker),
        @"downloadFiles": @(s->downloadFiles),
        @"installDocker": @(s->installDocker),

        @"launcherHasUpdate": @(s->launcherHasUpdate),
        @"productVersionLatestUrl": @(s->productVersionLatestUrl),
        @"launcherVersionLatest": @(s->launcherVersionLatest),
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
    id dict = @{       
        @"enabled": @(s->enabled),
        @"enablePortForwarding": @(s->enablePortForwarding),
        @"portRangeBegin": @(s->portRangeBegin),
        @"portRangeEnd": @(s->portRangeEnd),
        @"autoUpgrade": @(s->autoUpgrade),
        @"network": @(s->network),
        @"backend": @(s->backend),
    };
    free(s->backend);

    dispatch_async(dispatch_get_main_queue(),^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"config" object:nil userInfo:dict];
    });
    return;
}

void macSendModal(NSModal *s) {
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

void macSendMode(int s) {
//    NSLog(@"macSendMode >>>");

    id dict = @{
        @"mode": @(s),
    };
    dispatch_async(dispatch_get_main_queue(),^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"mode" object:nil userInfo:dict];
    });
    return;
}

void macSendLog(char *s) {
//    NSLog(@"macSendLog >>>");

    id dict = @{
        @"msg": [[NSString alloc] initWithUTF8String:s],
    };
    free(s);
    dispatch_async(dispatch_get_main_queue(),^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"log" object:nil userInfo:dict];
    });
    return;
}

void macSendOpenDialogue(int id_) {
    id dict = @{
        @"id": @(id_),
    };
    dispatch_async(dispatch_get_main_queue(),^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dialogue" object:nil userInfo:dict];
    });
    return;
}

void macSendOpenNodeUI() {
    dispatch_async(dispatch_get_main_queue(),^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"nodeui" object:nil userInfo:nil];
    });
    return;
}
