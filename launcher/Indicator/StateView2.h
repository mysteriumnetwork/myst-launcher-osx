#import <Cocoa/Cocoa.h>


// show color circle or spinner
@interface StateView2 : NSView {
    NSRect originalBounds;

    // 0  clear
    // 1  red
    // 2  orange
    // 3  green
    // -1 spinner
    int state;
    NSView *v;
}

- (void)setState: (int)state;

@end
