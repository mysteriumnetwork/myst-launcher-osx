#import <Cocoa/Cocoa.h>


// show color circle
@interface StateColorView : NSView {
    NSRect originalBounds;

    // 0 clear
    // 1 red
    // 2 orange
    // 3 green
    int state;
}

- (void)setState: (int)state;

@end
