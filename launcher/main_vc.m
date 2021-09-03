//
//  vc.m
//  launcher
//
//  Created by mac mini on 16/08/2021.
//  Copyright © 2021 mac mini. All rights reserved.
//


#import "main_vc.h"
#import "main_view.h"
#import "../gobridge/fff.h"

@implementation ViewController

NSView *v1 = nil;
NSView *v2 = nil;

- (void)loadView {
    NSLog(@"loadView >>>");

    v1 = [View1 alloc];
    [v1 init];
    
    v2 = [View2 alloc];
    [v2 init];
    
    [self setView:v2];
    
//    [NSTimer scheduledTimerWithTimeInterval:15
//                                   target:self
//                                   selector:@selector(onTimer)
//                                   userInfo:nil
//                                   repeats:YES];
    
    [self runDocker:self];
}

-(void)onTimer {
    NSLog(@"onTimer >>>");
    [self runDocker:self];
}

- (void)viewDidLoad {
    NSLog(@"viewDidLoad >>>");
    [super viewDidLoad];
}

- (IBAction)pageControlDidPage:(id)sender {
    //CGFloat xOffset = self.scrollView.bounds.size.width * (CGFloat)self.pageControl.currentPage;
    //[self.scrollView setContentOffset:CGPointMake(xOffset, 0) animated:YES];
}

/*
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (NSInteger)self.scrollView.contentOffset.x/self.scrollView.bounds.size.width;
}
*/

- (void)pageControl:(int)id {
    NSLog(@"pageControl > %d", id);
    switch (id) {
    case 1:
        [self setView:v1];
        break;
        
    case 2:
        [self setView:v2];
        break;
    }
}

- (BOOL)hasVirtualization {
    NSString *out = [[NSMutableString alloc] init];
    int res = [vc1 runShellCmd:@"sysctl -a | grep machdep.cpu.features":out];
    
    NSLog(@"res >>> %@, %d", out, [out containsString:@"VMX"]);
    BOOL has = [out containsString:@"VMX"];
    //[out release];
    if (!has) {
        return NO;
    }
    
    //out = [[NSMutableString alloc] init];
    int res2 = [vc1 runShellCmd:@"sysctl kern.hv_support":out];
    NSLog(@"res >>> %@, %d", out, [out hasPrefix:@"kern.hv_support: 1"]);
    NSLog(@"res >>> %d", res2);
    has = [out hasPrefix:@"kern.hv_support: 1"];
    
    [out release];
    return has;
}

- (void)onInstallDockerFinish{}


- (BOOL)runDocker:(id)sender {
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        // block1
        NSLog(@"Block1");
        //[NSThread sleepForTimeInterval:2.0];
        
        //int res = [vc1 runShellCmd:@"" :@"/usr/local/bin/docker ps":nil];
        //int res = [vc1 runCmd:@"/bin/ls" :@"-la /":nil];
        //NSLog(@"res >>> %d", res);
        //NSMutableArray *args = [[NSMutableArray alloc] init];
        
        

        NSState args = {};
        /*
        QueryState(&args);
	    id dict = @{
            @"status": [[NSString alloc] initWithUTF8String:args.latestVersion],
            @"latestVersion": [[NSString alloc] initWithUTF8String:args.latestVersion],
            @"currentVersion": [[NSString alloc] initWithUTF8String:args.currentVersion],
            @"isDockerRunning": @(args.dockerRunning),
        };
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Eezy" object:@"my object" userInfo:dict];
        FreeState(&args);
        */
        
        NSLog(@"Block1_ End");
    });

    
//    dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
//        // block2
//        NSLog(@"Block2");
//        [NSThread sleepForTimeInterval:2.0];
//        NSLog(@"Block2 End");
//    });
    

    dispatch_group_notify(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        // block3
        //NSLog(@"Block3");
        //[self workDone];
        
    });

    // only for non-ARC projects, handled automatically in ARC-enabled projects.
    dispatch_release(group);

    return NO;
}

- (int)runCmd :(NSString *)cmd :(NSString *)args :(NSString *)strOutput{
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:cmd];
    
    NSArray *arguments = [args componentsSeparatedByString:@" "];
        
    //NSMutableArray *arguments = [[NSMutableArray alloc] init];
    //[arguments addObject:@"-c"];
    //[arguments addObjectsFromArray:[commandToRun componentsSeparatedByString:@" "]];
     
    NSLog(@"run command:%@ %@", cmd, arguments);
    [task setArguments:arguments];
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    //The magic line that keeps your log where it belongs
    [task setStandardInput:[NSPipe pipe]];

    NSFileHandle *file = [pipe fileHandleForReading];
    [task launch];
    NSData *data = [file readDataToEndOfFile];
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"output > %@", output);

    if (strOutput != nil) {
        [strOutput setString:output];
    }

    [task waitUntilExit];
    int res = [task terminationStatus];
    
    NSLog(@"command terminationStatus:%d", res);
    return res;
}


- (int)runShellCmd :(NSString *)cmd :(NSString *)commandToRun :(NSString *)strOutput{
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/sh"];
    
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"-c", commandToRun,
                          nil];
    
    
    //NSMutableArray *arguments = [[NSMutableArray alloc] init];
    //[arguments addObject:@"-c"];
    //[arguments addObjectsFromArray:[commandToRun componentsSeparatedByString:@" "]];

    
    
    NSLog(@"run command:%@ %@", commandToRun, arguments);
    [task setArguments:arguments];
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    //The magic line that keeps your log where it belongs
    [task setStandardInput:[NSPipe pipe]];

    NSFileHandle *file = [pipe fileHandleForReading];
    [task launch];
    NSData *data = [file readDataToEndOfFile];
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"output > %@", output);

    if (strOutput != nil) {
        [strOutput setString:output];
    }

    [task waitUntilExit];
    int res = [task terminationStatus];
    
    NSLog(@"command terminationStatus:%d", res);
    return res;
}

@end



/*
 
@interface MyViewController : NSViewController
@property(strong) IBOutlet NSView *viewToSubstitute;
@end

@interface MyViewController ()
@end

@implementation MyViewController
- (void)awakeFromNib
{
  NSView *view = [self viewToSubstitute];
  if (view) {
    [self setViewToSubstitute:nil];
    [[self view] setFrame:[view frame]];
    [[self view] setAutoresizingMask:[view autoresizingMask]];
    [[view superview] replaceSubview:view with:[self view]];

  }
}
@end
 
*/
