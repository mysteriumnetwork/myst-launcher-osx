//
//  Label.m
//  A NSTextField subclass
//

#import "Label.h"
#import "NSAttributedString.h"

@implementation Label

- (void)awakeFromNib
{
    [super awakeFromNib];
  
    self.color = self.textColor;
    self.cursor = [NSCursor pointingHandCursor];
    [self setObjectValue: self.objectValue];
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
