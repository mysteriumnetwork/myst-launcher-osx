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

@interface Config : NSObject
{
    //NSString *name;
    int portBegin;
    int portEnd;
    BOOL enableForwarding;
};

@property (readwrite) int portBegin;
@property (readwrite) int portEnd;
@property (readwrite) BOOL enableForwarding;

@end

@interface LauncherState : NSObject
{
//    NSString *name;
//    NSString *foundationYear;

    NSNumber *portBegin;
    NSNumber *portEnd;
    NSNumber *enablePortForwarding;
    
    Config   *config;
}

@property (readwrite, copy) Config *config;
@property (readwrite, copy) NSNumber *portBegin;
@property (readwrite, copy) NSNumber *portEnd;

@property (readwrite, copy) NSNumber *enablePortForwarding;

//@property (readwrite, copy) NSString *name;
//@property (readwrite, copy) NSString *foundationYear;
@end

#endif /* model_h */
