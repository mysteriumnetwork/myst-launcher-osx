#import <Cocoa/Cocoa.h>


@interface StateColorView : NSView {
    NSRect originalBounds;
    CGSize originalSize;

    // 0 red
    // 1 orange
    // 2 green
    int state;
}

- (void)setState: (int)state;

@end
