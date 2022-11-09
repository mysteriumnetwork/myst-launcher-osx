#import <Foundation/Foundation.h>


typedef struct _NSState {
    char *imageName;
    char *currentVersion;
    char *latestVersion;
    bool hasUpdate;
    int  dockerRunning;
    int  containerRunning;
    char *networkCaption;

    // install steps
    int checkVirt;
    int checkDocker;
    int downloadFiles;
    int installDocker;

    // launcher
    bool launcherHasUpdate;
    char *productVersionLatestUrl;
    char *launcherVersionLatest;
} NSState;

typedef struct _NSConfig {
    bool autoUpgrade;
    bool enabled;
    bool enablePortForwarding;
    int  portRangeBegin;
    int  portRangeEnd;
    char *network;
    char *backend;
} NSConfig;

typedef struct _NSModal {
    char *title;
    char *msg;
    int  modal_type;
} NSModal;

/*
typedef struct _SetStateArgs {
    bool enablePortForwarding;
    int  portRangeBegin;
    int  portRangeEnd;
    bool autoUpgrade;
    bool enabled;
} SetStateArgs;
*/


///
void macSendState(NSState *s);
void macSendConfig(NSConfig *s);
void macSendModal(NSModal *s);
void macSendMode(int s);
void macSendLog(char *s);
void macSendOpenDialogue(int id_);

///
typedef enum {
    IDOK       = 1,
    IDCANCEL   = 2,
    IDABORT    = 3,
    IDRETRY    = 4,
    IDIGNORE   = 5,
    IDYES      = 6,
    IDNO       = 7,
    IDCLOSE    = 8,
    IDHELP     = 9,
    IDTRYAGAIN = 10,
    IDCONTINUE = 11,
    IDTIMEOUT  = 32000
} MODAL_RESULT;

typedef enum {
    MODAL_ConfirmModal = 1,
    MODAL_YesNoModal   = 2,
    MODAL_ErrorModal   = 3,
} MODAL_TYPE;

typedef enum {
    UIState_Initial           = 0,
    UIState_InstallNeeded     = -1,
    UIState_InstallInProgress = -2,
    UIState_InstallFinished   = -3,
    UIState_InstallError      = -4,
} UI_STATE;

typedef enum {
    RunnableState_Unknown     = 0,
    RunnableState_Starting    = 1,
    RunnableState_Running     = 2,
    RunnableState_Installing  = 3,
} RUNNABLE_STATE;

// install step state
typedef enum {
    StepState_None     = 0,
    StepState_Progress = 1,
    StepState_Finished = 2,
    StepState_Failed   = 3,
} STEP_STATE;
