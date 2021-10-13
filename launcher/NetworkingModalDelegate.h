//
//  ModalWindowDelegate.h
//  Cocoa Modal Window
//
//  Created by @zensey on 15/08/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//
#import <Cocoa/Cocoa.h>

@interface ModalWindowDelegate : NSWindowController <NSWindowDelegate>

@property (weak) IBOutlet NSButton *checkBox;
@property (weak) IBOutlet NSButton *button;
@property (weak) IBOutlet NSTextField *editPortRangeBegin;
@property (weak) IBOutlet NSTextField *editPortRangeEnd;

- (IBAction)cancelPressed:(id)sender;
- (IBAction)okPressed:(id)sender;
- (IBAction)checkPressed:(id)sender;

@end
