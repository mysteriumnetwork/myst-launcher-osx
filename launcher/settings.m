//
//  settings.m
//  launcher
//
//  Created by mac mini on 02/09/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#import "settings.h"
#import "../gobridge/fff.h"


static const NSSize buttonSize = {120, 30};
static const NSPoint buttonOrigin = {20, 20};

@implementation ViewModal
@synthesize button;
@synthesize labelCurrentVersion;
@synthesize editPortRangeBegin;
@synthesize editPortRangeEnd;

@synthesize checkBox;

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

        NSButton *checkBox = [[[NSButton alloc] initWithFrame:NSMakeRect(25, 250, 200, 20)] autorelease];
        [checkBox setTitle:@"Enable port forwarding"];
        [checkBox setButtonType:NSButtonTypeSwitch];
        [checkBox setTarget:self];
        //[checkBox setAction:@selector(OnCheckBox1Click:)];
        [checkBox setAutoresizingMask:NSViewMaxXMargin | NSViewMinYMargin];
        [checkBox setState:NSControlStateValueOff];
        [self addSubview:checkBox];

        NSButton *newButton = [[[NSButton alloc] initWithFrame:(NSRect){buttonOrigin, buttonSize}] autorelease];
        [newButton setBezelStyle:NSBezelStyleRounded];
        [newButton setTitle:@"OK"];
        [newButton setTarget:self];
        [newButton setAction:@selector(myAction:)];
        //[newButton setAutoresizingMask:NSViewMaxXMargin | NSViewMinYMargin];
        [self addSubview:newButton];
        
        NSTextField *label11 = [[NSTextField alloc] initWithFrame:NSMakeRect(25, 100, 150, 20)];
        [label11 setStringValue:@"Port range begin"];
        [label11 setBezeled:NO];
        [label11 setDrawsBackground:NO];
        [label11 setEditable:NO];
        [self addSubview:label11];
        
        
        NSTextField *label21 = [[NSTextField alloc] initWithFrame:NSMakeRect(25, 70, 150, 20)];
        [label21 setStringValue:@"Port range end"];
        [label21 setBezeled:NO];
        [label21 setDrawsBackground:NO];
        [label21 setEditable:NO];
        [self addSubview:label21];
        
        
        NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(150, 100, 100, 22)];
        [textField setStringValue:@""];
        [textField setEditable:YES];
        [self addSubview:textField];
        
        NSTextField *tfPortRangeEnd = [[NSTextField alloc] initWithFrame:NSMakeRect(150, 70, 100, 22)];
        [textField setStringValue:@""];
        [textField setEditable:YES];
        [self addSubview:tfPortRangeEnd];
        
        
        self.button = newButton;
//        self.labelCurrentVersion = label12;
        self.editPortRangeBegin = textField;
        self.editPortRangeEnd = tfPortRangeEnd;

        self.checkBox = checkBox;
        
        
//        [self.button setTitle:mod.name];
//        Config *c = [mod valueForKey:@"config"];
        
        [self.editPortRangeBegin setStringValue:[NSString stringWithFormat:@"%@", mod.portBegin]];
        [self.editPortRangeEnd setStringValue:[NSString stringWithFormat:@"%@", mod.portEnd]];
        [checkBox setState: [mod.enablePortForwarding boolValue]];
        //NSControlStateValueOff

    }
    return self;
}
    
- (IBAction) myAction: (NSButton*)button {
    NSLog(@"myAction >>>");
    
    
//    id v = @([self.editPortRangeBegin intValue]);
    mod.portBegin = @([self.editPortRangeBegin intValue]);
    mod.portEnd = @([self.editPortRangeEnd intValue]);
    
    mod.enablePortForwarding = [NSNumber numberWithBool:[checkBox integerValue]];

    SetStateArgs s;
    s.enablePortForwarding = [mod.enablePortForwarding boolValue];
    s.portRangeBegin = [mod.portBegin intValue];
    s.portRangeEnd = [mod.portEnd intValue];
    SetStateAndConfig(&s);
    
    [self.window close];
}

- (void)notificationHandler:(NSNotification *) notification{
    NSLog(@"%@ %@", notification.object, notification.userInfo);

}
@end



@implementation ViewController1
NSView *v11 = nil;

- (void)loadView {
    NSLog(@"modal > loadView >>>>>> ");
    v11 = [ViewModal alloc];
    [v11 init];
    [self setView:v11];
}

-(void)onTimer {
    NSLog(@"onTimer >>>");
}

- (void)viewDidLoad {
    NSLog(@"modal > viewDidLoad >>> >>>");
    [super viewDidLoad];
}

- (IBAction)pageControlDidPage:(id)sender {
}

@end


@implementation WindowDelegate
-(void)windowWillClose:(NSNotification *)notification {
    NSLog(@"windowWillClose >");
    [NSApp stopModal];
}
@end



@implementation Window1
- (instancetype) init {
    
  [super initWithContentRect:NSMakeRect(200, 300, 400, 200) styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable backing:NSBackingStoreBuffered defer:NO];

  [self setTitle:@"Settings"];

    
  id d = [[WindowDelegate alloc] init];
  [self setDelegate:d];
  [self setReleasedWhenClosed:NO];
    
    
  id vc1 = [[ViewController1 alloc] init];
  [self setContentViewController:vc1];
      
    
  [self setIsVisible:YES];
  //[self setWorksWhenModal:YES];
  return self;
}

- (void)windowWillClose:(NSNotification *)notification {
    //NSLog(@"windowWillClose");
    //[[NSApplication sharedApplication] stopModal];
}

- (BOOL)windowShouldClose:(id)sender {
    //[[NSApplication sharedApplication] stopModal];
    //[NSApp terminate:sender];
    //[NSApp stopModal];
    
    return YES;
}

@end
