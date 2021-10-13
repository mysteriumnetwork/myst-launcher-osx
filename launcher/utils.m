//
//  utils.m
//  launcher
//
//  Created by @zensey on 09/09/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "utils.h"



@implementation Utils: NSObject

NSString *const RunState0 = @"OFFLINE";
NSString *const RunState1 = @"STARTING..";
NSString *const RunState2 = @"ONLINE";
NSString *const RunState3 = @"INSTALLING..";
NSString *const RunState_ = @"?";

+ (NSString*)getRunStateString:(NSNumber*)state {
    switch ([state intValue]) {
        case 0:
            return RunState0; break;
        case 1:
            return RunState1; break;
        case 2:
            return RunState2; break;
        case 3:
            return RunState3; break;
        default:
            return RunState_; break;
    }
}
@end
