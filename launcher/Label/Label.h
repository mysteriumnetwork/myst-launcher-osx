//
//  Label.h
//  A NSTextField subclass implementing label-like functionality
//

#import <Cocoa/Cocoa.h>

@interface Label : NSTextField


@property (nonatomic, strong) NSCursor *cursor;
@property (retain)NSColor *color;

//- (void) setHyperlinkText;
@end
