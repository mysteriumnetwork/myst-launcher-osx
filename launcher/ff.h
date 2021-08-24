#import <Foundation/Foundation.h>

typedef struct _NSURLdata {
    NSString *scheme;
    NSString *user;
    NSString *password;
    NSString *host;
    NSNumber *port;
    NSString *path;
    NSString *query;
    NSString *fragment;
} NSURLdata;

const char* 
nsstring2cstring(NSString*);

int 
nsnumber2int(NSNumber*);

unsigned long 
nsarraylen(NSArray*);

const void* 
nsarrayitem(NSArray*, unsigned long);

const 
NSURLdata* nsurldata(NSURL*);

const 
NSArray* UserApplicationSupportDirectories();

///
typedef struct _NSState {
    char *currentVersion;
    char *latestVersion;
    bool hasUpdate;

//    NSString *user;
//    NSString *password;
//    NSString *host;
//    NSNumber *port;
//    NSString *path;
//    NSString *query;
//    NSString *fragment;
} NSState;


void
nsarray_additem(NSArray*, unsigned long);

void nsstate_set(NSState *s);
