//
//  ModalWindowDelegate.h
//  Cocoa Modal Window
//
//  Created by @zensey on 15/08/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//
#import <Cocoa/Cocoa.h>

@interface UpgradeModalDelegate : NSWindowController <NSWindowDelegate>

@property (weak) IBOutlet NSButton *button;
@property (weak) IBOutlet NSTextField *lbImageName;
@property (weak) IBOutlet NSTextField *lbVersionCurrent;
@property (weak) IBOutlet NSTextField *lbVersionLatest;

- (IBAction)cancelPressed:(id)sender;
- (IBAction)okPressed:(id)sender;

@end
