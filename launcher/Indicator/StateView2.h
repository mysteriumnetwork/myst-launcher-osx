#import <Cocoa/Cocoa.h>


// show color circle or spinner
@interface StateView2 : NSView {
    NSRect originalBounds;

    int state;
    NSView *v;
}

- (void)setState: (int)state;

@end
