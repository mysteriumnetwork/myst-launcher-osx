//
//  settings.h
//  launcher
//
//  Created by mac mini on 02/09/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "model.h"


#ifndef settings_h
#define settings_h

@interface ViewModal : NSView

@property (weak) NSButton *checkBox;
@property (weak) NSButton *button;
@property (weak) NSTextField *labelCurrentVersion;
@property (weak) NSTextField *editPortRangeBegin;
@property (weak) NSTextField *editPortRangeEnd;

// actions
- (IBAction)myAction:(id)sender;
@end

@interface ViewController1 : NSViewController
//- (void)pageControl:(int)id;
//- (int)runCmd:(NSString *)commandToRun :(NSString *)strOutput;
//- (BOOL)hasVirtualization;
//- (BOOL)runDocker:(id)sender;
@end


@interface WindowDelegate : NSObject<NSWindowDelegate>
@end

@interface Window1 : NSWindow {}
- (instancetype) init;
- (BOOL)windowShouldClose:(id)sender;
- (void)windowWillClose:(NSNotification *)notification;
@end

extern LauncherState *mod;

#endif /* settings_h */
