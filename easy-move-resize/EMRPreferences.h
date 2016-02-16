//
//  EMRPreferences.h
//  easy-move-resize
//
//  Created by Rajpaul Bagga on 2016-01-21.
//
// Preferences can be stored manually by running from Terminal a command like:
// defaults write org.dmarcotte.Easy-Move-Resize ModifierFlags CMD,CTRL


#ifndef EMRPreferences_h
#define EMRPreferences_h

#define MOVE_MODIFIER_FLAGS_DEFAULTS_KEY @"ModifierFlags"
#define RESIZE_MODIFIER_FLAGS_DEFAULTS_KEY @"ResizeModifierFlags"
#define MOVE_MOUSE_BUTTON_DEFAULTS_KEY @"MoveMouseButton"
#define RESIZE_MOUSE_BUTTON_DEFAULTS_KEY @"ResizeMouseButton"
#define CTRL_KEY @"CTRL"
#define SHIFT_KEY @"SHIFT"
#define CAPS_KEY @"CAPS" // CAPS lock
#define ALT_KEY @"ALT" // Alternate or Option key
#define CMD_KEY @"CMD"

typedef enum {
    eLeftMouseButton = 1,
    eRightMouseButton
} eMouseButton;

@interface EMRPreferences : NSObject {
    
}

// Get the move modifier flags from the standard preferences
+ (int) moveModifierFlags;
+ (NSSet*) moveFlagStringSet;

// Store a move modifier flag string in the preferences. (e.g. "CTRL,CMD"
+ (void) setMoveModifierFlagString:(NSString*)flagString;
+ (void) setMoveModifierFlagSet:(NSSet*)flagStringSet;
+ (void) setMoveModifierKey:(NSString*)singleFlagString enabled:(BOOL)enabled;

// Get the resize modifier flags from the standard preferences
+ (int) resizeModifierFlags;
+ (NSSet*) resizeFlagStringSet;

// Store a resize modifier flag string in the preferences. (e.g. "CTRL,CMD"
+ (void) setResizeModifierFlagString:(NSString*)flagString;
+ (void) setResizeModifierFlagSet:(NSSet*)flagStringSet;
+ (void) setResizeModifierKey:(NSString*)singleFlagString enabled:(BOOL)enabled;

+ (void) removeDefaults;

+ (eMouseButton) moveMouseButton;
+ (void) setMoveMouseButton:(eMouseButton)button;
+ (eMouseButton) resizeMouseButton;
+ (void) setResizeMouseButton:(eMouseButton)button;

@end

#endif /* EMRPreferences_h */
