#import "StateView2.h"
#import "StateView.h"

@implementation StateView2

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
  
    if (state == st) {
        return;
    }

    state = st;
    if (v != nil) {
        [v removeFromSuperview];
        [v release];
    }
            
    switch (st) {
        case -1:
        {
            NSRect r = NSMakeRect(0,0,16,16);
            NSProgressIndicator *p = [[NSProgressIndicator alloc] initWithFrame:r];

            [p startAnimation:p];
            [p setStyle:(NSProgressIndicatorStyle)1];
            [self addSubview:p];
            v = p;
        };
        break;
            
        case 0:
        case 1:
        case 2:
        case 3:
        {
            NSRect r = NSMakeRect(0,2,14,14);
            StateColorView *vs = [[StateColorView alloc] initWithFrame:r];
            [self addSubview:vs];

            [vs setState:st];
            v = vs;
        };
        break;

    }

}

@end
