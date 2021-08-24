#import "ff.h"

const char*
nsstring2cstring(NSString *s) {
    if (s == NULL) { return NULL; }
    
    const char *cstr = [s UTF8String];
    return cstr;
}

int
nsnumber2int(NSNumber *i) {
    if (i == NULL) { return 0; }
    return i.intValue;
}

unsigned long
nsarraylen(NSArray *arr) {
    if (arr == NULL) { return 0; }
    return arr.count;
}

const void*
nsarrayitem(NSArray *arr, unsigned long i) {
	if (arr == NULL) { return NULL; }
	return [arr objectAtIndex:i];
}

const NSURLdata*
nsurldata(NSURL *url) {
    NSURLdata *urldata = malloc(sizeof(NSURLdata));
    urldata->scheme = url.scheme;
    urldata->user = url.user;
    urldata->password = url.password;
    urldata->host = url.host;
    urldata->port = url.port;
    urldata->path = url.path;
    urldata->query = url.query;
    urldata->fragment = url.fragment;
    return urldata;
}

const NSArray*
UserApplicationSupportDirectories() {
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager URLsForDirectory: NSApplicationSupportDirectory
                           inDomains: NSUserDomainMask];
}


void
nsarray_additem(NSArray *arr, unsigned long i) {
    if (arr == NULL) {
        return;
    }
    [arr addObject: @(i)];
}

void
nsstate_set(NSState *s) {
    //NSLog(@">>>>>>>> %@", s->currentImage);
    //[ s->currentImage setString: @"v1.0.0.0"];
    //s->currentImage = nil;
    //[ s->currentImage initWithUTF8String: @"v1.0.0.0"];
    //[ s->currentImage initWithString: @"v1.0.0.0"];
    //s->currentImage =
}

