//
//  view.m
//  launcher
//
//  Created by mac mini on 16/08/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#import "main_view.h"
#import "settings.h"


//static const NSSize itemSize = {100, 100};
static const NSSize buttonSize = {120, 30};
static const NSPoint buttonOrigin = {20, 20};


@implementation View1
@synthesize button;

- (id)init {
    NSLog(@"init >");
    self = [super init];
    if (self) {}
    return self;
}

- (id)initWithFrame:(NSRect)frameRect {
    NSLog(@"initWithFrame");
    
    //self = [super initWithFrame:(NSRect){frameRect.origin, itemSize}];
    self = [super initWithFrame:NSMakeRect(100, 100, 300, 300)];
    if (self) {
        //NSLog(@"add button");
        
        NSButton *newButton = [[[NSButton alloc] initWithFrame:(NSRect){buttonOrigin, buttonSize}] autorelease];
        [newButton setBezelStyle:NSBezelStyleRounded];
        [newButton setTitle:@"Button 1"];
        [newButton setTarget:self];
        [newButton setAction:@selector(myAction:)];
        [newButton setAutoresizingMask:NSViewMaxXMargin | NSViewMinYMargin];


        [self addSubview:newButton];
        self.button = newButton;
    }
    return self;
}

- (IBAction) myAction: (NSButton*)button {
    [vc1 pageControl:2];
    NSLog(@"myAction >>> %@", button.title);
}
@end


@implementation View2
@synthesize button;
@synthesize labelCurrentVersion;
@synthesize labelLatestVersion;

- (id)init {
    NSLog(@"init >");

    self = [super init];
    if (self) {
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandler:) name:@"Eezy" object:nil];
    return self;
}

- (id)initWithFrame:(NSRect)frameRect {
    NSLog(@"initWithFrame");
    
    //self = [super initWithFrame:(NSRect){frameRect.origin, itemSize}];
    self = [super initWithFrame:NSMakeRect(100, 100, 300, 300)];
    if (self) {
        //NSLog(@"add button");

        NSButton *newButton = [[[NSButton alloc] initWithFrame:(NSRect){buttonOrigin, buttonSize}] autorelease];
        [newButton setBezelStyle:NSBezelStyleRounded];
        [newButton setTitle:@"Settings"];
        [newButton setTarget:self];
        [newButton setAction:@selector(myAction:)];
        //[newButton setAutoresizingMask:NSViewMaxXMargin | NSViewMinYMargin];
        [self addSubview:newButton];
        
        NSTextField *label11 = [[NSTextField alloc] initWithFrame:NSMakeRect(25, 70, 150, 20)];
        [label11 setStringValue:@"Docker image:"];
        [label11 setBezeled:NO];
        [label11 setDrawsBackground:NO];
        [label11 setEditable:NO];
        [self addSubview:label11];
        
        NSTextField *label12 = [[NSTextField alloc] initWithFrame:NSMakeRect(125, 70, 150, 20)];
        [label12 setStringValue:@"_"];
        [label12 setBezeled:NO];
        [label12 setDrawsBackground:NO];
        [label12 setEditable:NO];
        [self addSubview:label12];
        
        NSTextField *label21 = [[NSTextField alloc] initWithFrame:NSMakeRect(25, 90, 150, 20)];
        [label21 setStringValue:@"Latest image:"];
        [label21 setBezeled:NO];
        [label21 setDrawsBackground:NO];
        [label21 setEditable:NO];
        [self addSubview:label21];
        
        NSTextField *label22 = [[NSTextField alloc] initWithFrame:NSMakeRect(125, 90, 150, 20)];
        [label22 setStringValue:@"_"];
        [label22 setBezeled:NO];
        [label22 setDrawsBackground:NO];
        [label22 setEditable:NO];
        [self addSubview:label22];
        
        self.button = newButton;
        self.labelCurrentVersion = label12;
        self.labelLatestVersion = label22;

    }
    return self;
}
	
- (IBAction) myAction: (NSButton*)button {
    NSLog(@"myAction >>> %@", button.title);
    TriggerUIEvent((char *)@"action_123".UTF8String);

    
    id w = [[[Window1 alloc] init] autorelease];
    //[self.window beginSheet:w completionHandler:nil ];
    //[[self window] addChildWindow:w ordered:NSWindowAbove];

    [[NSApplication sharedApplication] runModalForWindow:w];
    
    //BOOL has = [vc1 hasVirtualization];
    //[self.button setTitle:@"OK"];
    //BOOL has = [vc1 runDocker:self];
}

- (void)notificationHandler:(NSNotification *) notification{
    NSLog(@"%@ %@", notification.object, notification.userInfo);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //[self.button setTitle:@"OK"];

        [self.labelLatestVersion setStringValue: notification.userInfo[@"latestVersion"]];
        [self.labelCurrentVersion setStringValue: notification.userInfo[@"currentVersion"]];
    });
}
   

@end



///
/*
  NSButton* button1;
  NSButton* button2;
  NSTextField* label1;
  NSTextField* label2;
  int button1Clicked;
  int button2Clicked;
*/

/*
  button1Clicked = 0;
  button2Clicked = 0;

  button1 = [[[NSButton alloc] initWithFrame:NSMakeRect(50, 225, 90, 25)] autorelease];
  [button1 setTitle:@"button1"];
  [button1 setBezelStyle:NSBezelStyleRounded];
  [button1 setTarget:self];
  [button1 setAction:@selector(OnButton1Click:)];
  [button1 setAutoresizingMask:NSViewMaxXMargin | NSViewMinYMargin];

  button2 = [[[NSButton alloc] initWithFrame:NSMakeRect(50, 125, 200, 75)] autorelease];
  [button2 setTitle:@"button2"];
  [button2 setBezelStyle:NSBezelStyleRegularSquare];
  [button2 setTarget:self];
  [button2 setAction:@selector(OnButton2Click:)];
  [button2 setAutoresizingMask:NSViewMaxXMargin | NSViewMinYMargin];
  
  label1 = [[NSTextField alloc] initWithFrame:NSMakeRect(50, 80, 150, 20)];
  [label1 setStringValue:@"button1 clicked 0 times"];
  [label1 setBezeled:NO];
  [label1 setDrawsBackground:NO];
  [label1 setEditable:NO];

  label2 = [[NSTextField alloc] initWithFrame:NSMakeRect(50, 50, 150, 20)];
  [label2 setStringValue:@"button2 clicked 0 times"];
  [label2 setBezeled:NO];
  [label2 setDrawsBackground:NO];
  [label2 setEditable:NO];
*/


