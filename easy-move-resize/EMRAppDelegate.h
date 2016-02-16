#import <Cocoa/Cocoa.h>
#import "EMRPrefsWindowController.h"

static const int kMoveFilterInterval = 2;
static const int kResizeFilterInterval = 4;

@interface EMRAppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSMenu *statusMenu;
    NSStatusItem * statusItem;
    EMRPrefsWindowController* prefsWindow;
    int keyModifierFlags;
}

- (int)modifierFlags;

- (void)initModifierMenuItems;
- (IBAction)modifierToggle:(id)sender;
- (IBAction)resetModifiersToDefaults:(id)sender;
- (IBAction)toggleDisabled:(id)sender;
- (IBAction)openPrefs:(id)sender;

@property (weak) IBOutlet NSMenuItem *altMenu;
@property (weak) IBOutlet NSMenuItem *cmdMenu;
@property (weak) IBOutlet NSMenuItem *ctrlMenu;
@property (weak) IBOutlet NSMenuItem *shiftMenu;
@property (weak) IBOutlet NSMenuItem *disabledMenu;

@end
