//
//  ModalWindowDelegate.h
//  Cocoa Modal Window
//
//  Created by Nikola Grujic on 17/01/2020.
//  Copyright © 2020 Mac Developers. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainWindowDelegate : NSWindowController <NSWindowDelegate>

@property (weak) IBOutlet NSButton *checkBox;
@property (weak) IBOutlet NSButton *button;

@property (weak) IBOutlet NSTextField *labelImageName;
@property (weak) IBOutlet NSTextField *labelCurrentVersion;
@property (weak) IBOutlet NSTextField *labelLatestVersion;
@property (weak) IBOutlet NSTextField *labelHasUpdate;
@property (weak) IBOutlet NSTextField *labelNetworkMode;

@property (weak) IBOutlet NSView *v11;
@property (weak) IBOutlet NSView *v21;

- (IBAction)cancelPressed:(id)sender;
- (IBAction)okPressed:(id)sender;
- (IBAction)okPressed1:(NSButton*)sender;

@end
