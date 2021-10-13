#import "StateView.h"


@implementation StateColorView

- (void)awakeFromNib
{
    originalBounds = [self bounds];
    [super awakeFromNib];
}

- (id)init
{
    return self;
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code here.
        originalBounds = [self bounds];
    }
    return self;
}

- (void)setFrameSize:(NSSize)newSize
{
  [super setFrameSize:newSize];
  [self setBounds:originalBounds];
}

- (void)setState: (int)st {
    state = st;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)rect {
    [NSGraphicsContext saveGraphicsState];
    NSRect r = NSMakeRect(originalBounds.origin.x, originalBounds.origin.y, originalBounds.size.width, originalBounds.size.height);
    NSBezierPath* circlePath = [NSBezierPath bezierPath];
    [circlePath appendBezierPathWithOvalInRect: r];
    
    switch (state) {
        case 0:
            [[NSColor systemRedColor] set];
            break;
        case 1:
            [[NSColor systemOrangeColor] set];
            break;
        case 2:
            [[NSColor systemGreenColor] set];
            break;

        default:
            break;
    }
    [circlePath fill];
  
    [NSGraphicsContext restoreGraphicsState];
}

@end
