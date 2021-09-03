#import <Foundation/Foundation.h>

///
typedef struct _NSState {

    char *imageName;
    char *currentVersion;
    char *latestVersion;
    bool hasUpdate;

    int  dockerRunning;
    bool containerRunning;    

    bool enablePortForwarding;
	int  portRangeBegin;
	int  portRangeEnd;
    
    bool autoUpgrade;
} NSState;


typedef struct _SetStateArgs {
    bool enablePortForwarding;
	int  portRangeBegin;
	int  portRangeEnd;
    bool autoUpgrade;
} SetStateArgs;



///
void 
macSend(NSState *s);
