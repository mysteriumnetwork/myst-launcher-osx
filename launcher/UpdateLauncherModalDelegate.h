//
//  UpdateNetworkModalDelegate.h
//  Mysterium Node Launcher
//
//  Created by mac mini on 10/11/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface UpdateLauncherModalDelegate : NSWindowController <NSWindowDelegate>

//@property (weak) IBOutlet NSButton *button;
@property (weak) IBOutlet NSTextField *lbCurrentVersion;
@property (weak) IBOutlet NSTextField *lbLatestVersion;

- (IBAction)okPressed:(id)sender;

@end
