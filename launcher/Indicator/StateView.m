#import "StateView.h"


@implementation StateColorView

- (void)awakeFromNib
{
    originalBounds = [self bounds];
    [super awakeFromNib];
}

- (id)init
{
    [super init];
    return self;
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        originalBounds = [self bounds];
    }
    return self;
}

- (void)setFrameSize:(NSSize)newSize
{
    [super setFrameSize:newSize];
    originalBounds = [self bounds];
}

- (void)setState: (int)st {
    state = st;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)rect {
    
    [NSGraphicsContext saveGraphicsState];
    
    if (state != 0) {
        NSRect r = NSMakeRect(originalBounds.origin.x, originalBounds.origin.y, originalBounds.size.width, originalBounds.size.height);
        NSBezierPath* circlePath = [NSBezierPath bezierPath];
        [circlePath appendBezierPathWithOvalInRect: r];
        
        switch (state) {
            case 1:
                [[NSColor systemRedColor] set];
                break;
            case 2:
                [[NSColor systemOrangeColor] set];
                break;
            case 3:
                [[NSColor systemGreenColor] set];
                break;

            default:
                break;
        }
        [circlePath fill];
    }
    [NSGraphicsContext restoreGraphicsState];
}

@end
