//
//  model.h
//  launcher
//
//  Created by mac mini on 02/09/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifndef model_h
#define model_h

@interface LauncherState : NSObject
{
    NSNumber *portBegin;
    NSNumber *portEnd;
    NSNumber *enablePortForwarding;
    
    NSNumber *hasUpdate;
    NSNumber *isDockerRunning;
    NSString *currentVersion;
    NSString *imageName;
    NSString *latestVersion;
}

@property (readwrite, copy) NSNumber *portBegin;
@property (readwrite, copy) NSNumber *portEnd;
@property (readwrite, copy) NSNumber *enablePortForwarding;

@property (readwrite, copy) NSNumber *hasUpdate;
@property (readwrite, copy) NSNumber *isDockerRunning;
@property (readwrite, copy) NSString *currentVersion;
@property (readwrite, copy) NSString *imageName;
@property (readwrite, copy) NSString *latestVersion;
@end

#endif /* model_h */
