//
//  NSAttributedStringExt.h
//  launcher
//
//  Created by @zensey on 08/09/2021.
//  Copyright © 2021 Mysterium Network. All rights reserved.
//

#ifndef NSAttributedStringExt_h
#define NSAttributedStringExt_h

@interface NSAttributedString (Hyperlink)
+(id)hyperlinkFromString:(NSString*)inString; //withURL:(NSURL*)aURL;
@end

#endif /* NSAttributedStringExt_h */
