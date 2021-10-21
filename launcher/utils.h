//
//  utils.h
//  launcher
//
//  Created by @zensey on 09/09/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//

@interface Utils : NSObject
+ (NSString*)getRunStateString:(NSNumber*)state;
+ (int)getStateViewStatus:(NSNumber*)state;
+ (int)getStateView2Status:(NSNumber*)state;

@end
