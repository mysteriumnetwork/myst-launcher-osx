//
//  view.h
//  launcher
//
//  Created by mac mini on 16/08/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <Cocoa/Cocoa.h>
#import "c.h"


#ifndef view_h
#define view_h


@interface View1 : NSView
@property (weak) NSButton *button;

- (IBAction)myAction:(id)sender;
@end

@interface View2 : NSView
@property (weak) NSButton *button;
@property (weak) NSTextField *labelCurrentVersion;

- (IBAction)myAction:(id)sender;
@end


#endif /* view_h */
