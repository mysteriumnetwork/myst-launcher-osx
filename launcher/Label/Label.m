//
//  Label.m
//  A NSTextField subclass
//

#import "Label.h"
#import "NSAttributedString.h"

@implementation Label

- (void)awakeFromNib
{
    self.color = [NSColor colorWithRed:0 green:0.4 blue:238.0/255 alpha:1];
    [super awakeFromNib];
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

/*
 *  Override setObjectValue method to intercept it to add attributes
 */
- (void)setObjectValue:(id)object
{
    [super setObjectValue:object];
    [self setHyperlinkText];
}

- (void)mouseUp:(NSEvent *)theEvent
{
    [self.target performSelector: self.action ];
}

- (void) setHyperlinkText {
    NSMutableAttributedString* string = [[NSMutableAttributedString alloc] init];
    [string appendAttributedString: [NSAttributedString hyperlinkFromString: [self stringValue]]];
    NSRange attachTextRange = NSMakeRange(0, [self stringValue].length);
    [string addAttributes:@{NSForegroundColorAttributeName: self.color} range:attachTextRange];

    [self setAttributedStringValue: string];
 }

- (void)resetCursorRects
{
    [super resetCursorRects];
    [self addCursorRect:self.bounds cursor:self.cursor];
}

@end
