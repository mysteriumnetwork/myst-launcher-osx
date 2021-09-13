//
//  NSAttributedStringExt.m
//  launcher
//
//  Created by @zensey on 08/09/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

// From https://developer.apple.com/library/archive/qa/qa1487/_index.html

@implementation NSAttributedString (Hyperlink)
+(id)hyperlinkFromString:(NSString*)inString
{
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString: inString];
    NSRange range = NSMakeRange(0, [attrString length]);
 
    [attrString beginEditing];
 
    // make the text appear in blue
    [attrString addAttribute:NSForegroundColorAttributeName value:[NSColor blueColor] range:range];
 
    // next make the text appear with an underline
    [attrString addAttribute:
            NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:range];
 
    [attrString endEditing];
 
    return [attrString autorelease];
}
@end
