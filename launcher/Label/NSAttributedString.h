//
//  NSAttributedStringExt.h
//  launcher
//
//  Created by mac mini on 08/09/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#ifndef NSAttributedStringExt_h
#define NSAttributedStringExt_h

@interface NSAttributedString (Hyperlink)
+(id)hyperlinkFromString:(NSString*)inString; //withURL:(NSURL*)aURL;
@end

#endif /* NSAttributedStringExt_h */
