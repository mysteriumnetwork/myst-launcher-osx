//
//  MainWindowDelegate.h
//  Launcher Main Window
//
//  Created by @zensey on 15/08/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Label.h"

@interface MainWindowDelegate : NSWindowController <NSWindowDelegate> {
    NSImage *img1, *img2;
}

@property (weak) IBOutlet NSButton *checkBox;
@property (weak) IBOutlet NSButton *button;

@property (weak) IBOutlet NSTextField *labelImageName;
@property (weak) IBOutlet NSTextField *labelCurrentVersion;
@property (weak) IBOutlet NSTextField *labelLatestVersion;
@property (weak) IBOutlet NSTextField *labelHasUpdate;
@property (weak) IBOutlet Label       *labelNetworkMode;
@property (weak) IBOutlet NSTextField *labelDocker;
@property (weak) IBOutlet NSTextField *labelContainer;
@property (weak) IBOutlet NSImageView *img;


@property (strong) IBOutlet NSView *v11;
@property (strong) IBOutlet NSView *v21;

- (IBAction)cancelPressed:(id)sender;
- (IBAction)okPressed:(id)sender;
- (IBAction)checkBoxClick:(NSButton*)sender;
- (IBAction)networkingLabelPressed:(id)sender;

// installation
@property (weak) IBOutlet NSButton *checkBoxVirtualization;
@property (weak) IBOutlet NSButton *checkBoxDocker;
@property (weak) IBOutlet NSButton *checkBoxDownloadFiles;
@property (weak) IBOutlet NSButton *checkBoxInstallDocker;

@property (weak) IBOutlet NSButton *finishButton;

@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSTextView *textView;
- (IBAction)finishPressed:(id)sender;


@end
