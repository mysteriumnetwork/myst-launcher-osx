//
//  AppDelegate.h
//  launcher
//
//  Created by @zensey on 15/08/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <Cocoa/Cocoa.h>
#import "Model.h"

#ifndef app_delegate_h
#define app_delegate_h

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSMenuItem *itemEnableNode;
@property (weak) IBOutlet NSMenu *statusBarMenu;

@property (strong) NSWindowController *mainWin;

- (IBAction)showMain:(id)sender;
- (IBAction)showUpgradeDlg:(id)sender;
- (IBAction)showNetworkingDlg:(id)sender;

- (IBAction)enableNode:(id)sender;
- (IBAction)openNodeUIAction:(id)sender;

@end


extern LauncherState *mod;

#endif /* app_delegate_h */
