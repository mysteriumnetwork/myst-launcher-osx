//
//  MainWindowDelegate.h
//  Launcher Main Window
//
//  Created by @zensey on 15/08/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Label.h"

@interface MainWindowDelegate : NSWindowController <NSWindowDelegate>

@property (weak) IBOutlet NSButton *checkBox;
@property (weak) IBOutlet NSButton *button;

@property (weak) IBOutlet NSTextField *labelImageName;
@property (weak) IBOutlet NSTextField *labelCurrentVersion;
@property (weak) IBOutlet NSTextField *labelLatestVersion;
@property (weak) IBOutlet NSTextField *labelHasUpdate;
@property (weak) IBOutlet Label       *labelNetworkMode;
@property (weak) IBOutlet NSTextField *labelDocker;
@property (weak) IBOutlet NSTextField *labelContainer;

@property (weak) IBOutlet NSView *v11;
@property (weak) IBOutlet NSView *v21;
@property (weak) IBOutlet NSImageView *img;

- (IBAction)cancelPressed:(id)sender;
- (IBAction)okPressed:(id)sender;
- (IBAction)checkBoxClick:(NSButton*)sender;
- (IBAction)networkingLabelPressed:(id)sender;

@end
