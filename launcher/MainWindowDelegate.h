//
//  MainWindowDelegate.h
//  Launcher Main Window
//
//  Created by @zensey on 15/08/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Label/Label.h"
#import "Indicator/StateView.h"
#import "Indicator/StateView2.h"

@interface MainWindowDelegate : NSWindowController <NSWindowDelegate> {
    NSImage *img1;
}

@property (weak) IBOutlet NSButton *checkBoxAutoUpgrade;
@property (weak) IBOutlet NSButton *btnUpdateToMainnet;
@property (weak) IBOutlet NSButton *btnNetworkConfig;

@property (weak) IBOutlet NSTextField *labelImageName;
@property (weak) IBOutlet NSTextField *labelCurrentVersion;
@property (weak) IBOutlet NSTextField *labelLatestVersion;
@property (weak) IBOutlet NSTextField *labelHasUpdate;
@property (weak) IBOutlet NSTextField *labelNetworkMode;
@property (weak) IBOutlet NSTextField *labelDocker;
@property (weak) IBOutlet NSTextField *labelContainer;
@property (weak) IBOutlet NSTextField *labelNetwork;
@property (weak) IBOutlet NSTextField *labelLauncherUpdate;
@property (weak) IBOutlet NSTextField *labelBackend;
@property (weak) IBOutlet NSTextField *labelStatus;

@property (weak) IBOutlet NSImageView *img;

@property (strong) IBOutlet NSView *v0;
@property (strong) IBOutlet NSView *v11;
@property (strong) IBOutlet NSView *v21;
@property (strong) IBOutlet StateColorView *statusDocker;
@property (strong) IBOutlet StateColorView *statusNode;
@property (strong) IBOutlet StateView2 *st;


- (IBAction)cancelPressed:(id)sender;
- (IBAction)linkNodeUIPressed:(id)sender;
- (IBAction)linkAboutMainnetPressed:(id)sender;
- (IBAction)linkUpdateLauncherPressed:(id)sender;

- (IBAction)checkBoxClick:(NSButton*)sender;
- (IBAction)networkingLabelPressed:(id)sender;
- (IBAction)updateNetworkPressed:(id)sender;

// installation
@property (weak) IBOutlet StateView2 *checkBoxVirtualization;
@property (weak) IBOutlet StateView2 *checkBoxDocker;
@property (weak) IBOutlet StateView2 *checkBoxDownloadFiles;
@property (weak) IBOutlet StateView2 *checkBoxInstallDocker;
@property (weak) IBOutlet NSButton *finishButton;
@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSTextView *textView;

@property (weak) IBOutlet NSProgressIndicator *pi;

- (IBAction)finishPressed:(id)sender;


@end
