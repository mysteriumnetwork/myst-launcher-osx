//
//  vc.h
//  launcher
//
//  Created by mac mini on 16/08/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <Cocoa/Cocoa.h>

//#ifndef vc_h
//#define vc_h

@interface ViewController : NSViewController

//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
//- (IBAction)pageControlDidPage:(id)sender;

- (void)pageControl:(int)id;

- (int)runCmd:(NSString *)commandToRun :(NSString *)strOutput;
- (BOOL)hasVirtualization;
- (BOOL)runDocker:(id)sender;
    
//- (IBAction)myAction:(id)sender;
//- (IBAction)myAction2:(id)sender;

@end


//#endif /* vc_h */
