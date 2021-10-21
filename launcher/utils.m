//
//  utils.m
//  launcher
//
//  Created by @zensey on 09/09/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "utils.h"
#import "../gobridge/interface.h"



@implementation Utils: NSObject

NSString *const RunState0 = @"OFFLINE";
NSString *const RunState1 = @"STARTING..";
NSString *const RunState2 = @"ONLINE";
NSString *const RunState3 = @"INSTALLING..";
NSString *const RunState_ = @"?";

+ (NSString*)getRunStateString:(NSNumber*)state {
    switch ([state intValue]) {
        case RunnableState_Unknown:
            return RunState0;
            break;
            
        case RunnableState_Starting:
            return RunState1;
            break;
            
        case RunnableState_Running:
            return RunState2;
            break;
            
        case RunnableState_Installing:
            return RunState3;
            break;
            
        default:
            return RunState_;
            break;
    }
}

+ (int)getStateViewStatus:(NSNumber*)state {   
    switch ([state intValue]) {
        case RunnableState_Unknown:
            return 1;
            break;
            
        case RunnableState_Starting:
            return 2;
            break;
            
        case RunnableState_Running:
            return 3;
            break;
            
        case RunnableState_Installing:
            return 2;
            break;
            
        default:
            return 0;
            break;
    }
}

+ (int)getStateView2Status:(NSNumber*)state {
    switch ([state intValue]) {
        case StepState_None:
            return 0;
            break;
            
        case StepState_Progress:
            return -1;
            break;
            
        case StepState_Finished:
            return 3;
            break;
            
        case StepState_Failed:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
}

@end
