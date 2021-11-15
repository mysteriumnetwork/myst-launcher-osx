//
//  UpdateNetworkModalDelegate.h
//  Mysterium Node Launcher
//
//  Created by mac mini on 10/11/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface UpdateNetworkModalDelegate : NSWindowController <NSWindowDelegate>

@property (weak) IBOutlet NSButton *button;
@property (weak) IBOutlet NSTextField *lbNetworkCaption;

- (IBAction)cancelPressed:(id)sender;
- (IBAction)okPressed:(id)sender;
- (IBAction)linkAboutMainnetPressed:(id)sender;

@end


