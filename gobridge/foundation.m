//
//  foundation.m
//  launcher
//
//  Created by mac mini on 18/08/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "foundation.h"

void
nsarray_additem(NSArray *arr, unsigned long i) {
    if (arr == NULL) {
        return;
    }    
    [arr addObject: i];
}
