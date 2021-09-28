//
//  model.h
//  launcher
//
//  Created by @zensey on 02/09/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifndef model_h
#define model_h

@interface LauncherState : NSObject
{
    NSNumber *portBegin;
    NSNumber *portEnd;
    NSNumber *enablePortForwarding;
    NSNumber *autoUpgrade;
    NSNumber *enabled;

    NSNumber *hasUpdate;
    NSString *currentVersion;
    NSString *imageName;
    NSString *latestVersion;
    
    NSNumber *isDockerRunning;
    NSNumber *isContainerRunning;
    
    // installation
    NSNumber *checkDocker;
    NSNumber *checkVirt;
    NSNumber *downloadFiles;
    NSNumber *installDocker;
}

@property (readwrite, copy) NSNumber *portBegin;
@property (readwrite, copy) NSNumber *portEnd;
@property (readwrite, copy) NSNumber *enablePortForwarding;
@property (readwrite, copy) NSNumber *autoUpgrade;
@property (readwrite, copy) NSNumber *enabled;

@property (readwrite, copy) NSNumber *hasUpdate;
@property (readwrite, copy) NSString *currentVersion;
@property (readwrite, copy) NSString *imageName;
@property (readwrite, copy) NSString *latestVersion;
@property (readwrite, copy) NSNumber *isDockerRunning;
@property (readwrite, copy) NSNumber *isContainerRunning;

@property (readwrite, copy) NSNumber *checkDocker;
@property (readwrite, copy) NSNumber *checkVirt;
@property (readwrite, copy) NSNumber *downloadFiles;
@property (readwrite, copy) NSNumber *installDocker;


- (void)setState;

@end

#endif /* model_h */
