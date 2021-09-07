//#import "ModalWindowDelegate.h"
//#import "app.h"

#import "main_w.h"

ViewController *vc1 = nil;
//LauncherState *mod = nil;


@interface Window : NSWindow {}
- (instancetype) init;
- (BOOL)windowShouldClose:(id)sender;
@end

@implementation Window
- (instancetype) init {
    
  [super initWithContentRect:NSMakeRect(100, 100, 400, 400) styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable backing:NSBackingStoreBuffered defer:NO];
    
  [self setTitle:@"Launcher"];
      
  vc1 = [[ViewController alloc] init];
  [self setContentViewController:vc1];
    
    
  [self setIsVisible:YES];
  return self;
}

- (BOOL)windowShouldClose:(id)sender {
  [NSApp terminate:sender];
  return YES;
}

@end



int
StartApp(void) {
    mod = [[LauncherState alloc] init];

    [NSApplication sharedApplication];
    
    id menubar = [[NSMenu new] autorelease];
    id appMenuItem = [[NSMenuItem new] autorelease];
    [menubar addItem:appMenuItem];
    [NSApp setMainMenu:menubar];

    id appMenu = [[NSMenu new] autorelease];
    id appName = [[NSProcessInfo processInfo] processName];
    id quitTitle = [@"Quit " stringByAppendingString:appName];
    id quitMenuItem = [[[NSMenuItem alloc] initWithTitle:quitTitle
        action:@selector(terminate:) keyEquivalent:@"q"]
              autorelease];

    [appMenu addItem:quitMenuItem];
    [appMenuItem setSubmenu:appMenu];
    
    [[[[Window alloc] init] autorelease] makeMainWindow];

    id d = [[AppDelegate alloc]init];
    [NSApp setDelegate:d];
    [NSApp run];
    
    return 0;
}
