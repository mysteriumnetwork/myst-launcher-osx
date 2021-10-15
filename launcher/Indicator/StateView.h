#import <Cocoa/Cocoa.h>


// show color circle
@interface StateColorView : NSView {
    NSRect originalBounds;

    // 0 red
    // 1 orange
    // 2 green
    int state;
}

- (void)setState: (int)state;

@end
