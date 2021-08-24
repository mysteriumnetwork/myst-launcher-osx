//
//  view.m
//  launcher
//
//  Created by mac mini on 16/08/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#import "view.h"


//static const NSSize itemSize = {100, 100};
static const NSSize buttonSize = {120, 30};
static const NSPoint buttonOrigin = {20, 20};


@implementation View1
@synthesize button;

- (id)init {
    NSLog(@"init >");
    
    self = [super init];
    if (self) {
    }
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


- (id)init {
    NSLog(@"init >");

    self = [super init];
    if (self) {
        
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandler:) name:@"Eezy" object:@"my object"];
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
        [newButton setTitle:@"Run command"];
        [newButton setTarget:self];
        [newButton setAction:@selector(myAction:)];
        //[newButton setAutoresizingMask:NSViewMaxXMargin | NSViewMinYMargin];
        [self addSubview:newButton];

        
        NSTextField *label1 = [[NSTextField alloc] initWithFrame:NSMakeRect(25, 70, 150, 20)];
        [label1 setStringValue:@"Docker image:"];
        [label1 setBezeled:NO];
        [label1 setDrawsBackground:NO];
        [label1 setEditable:NO];
        [self addSubview:label1];

        
        NSTextField *label2 = [[NSTextField alloc] initWithFrame:NSMakeRect(125, 70, 150, 20)];
        [label2 setStringValue:@"_"];
        [label2 setBezeled:NO];
        [label2 setDrawsBackground:NO];
        [label2 setEditable:NO];
        [self addSubview:label2];
        
        self.button = newButton;
        self.labelCurrentVersion = label2;

    }
    return self;
}
	
- (IBAction) myAction: (NSButton*)button {
    NSLog(@"myAction >>> %@", button.title);

    //BOOL has = [vc1 hasVirtualization];
    //[self.button setTitle:@"OK"];

    BOOL has = [vc1 installDocker:self];
}

- (void)notificationHandler:(NSNotification *) notification{
     NSLog(@"%@ %@",notification.object, notification.userInfo);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.button setTitle:@"OK"];
        [self.labelCurrentVersion setStringValue: notification.userInfo[@"status"]];
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


