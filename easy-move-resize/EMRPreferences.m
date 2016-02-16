//
//  EMRPreferences.m
//  easy-move-resize
//
//  Created by Rajpaul Bagga on 2016-01-21.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "EMRPreferences.h"

#define DEFAULT_MODIFIER_FLAGS kCGEventFlagMaskCommand | kCGEventFlagMaskControl

@implementation EMRPreferences

+ (int)moveModifierFlags {
    return [self modifierFlagsForKey:MOVE_MODIFIER_FLAGS_DEFAULTS_KEY];
}

+ (int)resizeModifierFlags {
    return [self modifierFlagsForKey:RESIZE_MODIFIER_FLAGS_DEFAULTS_KEY];
}

+ (int)modifierFlagsForKey:(NSString*)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *modifierFlagString = [defaults stringForKey:key];
    if (modifierFlagString == nil) {
        return DEFAULT_MODIFIER_FLAGS;
    }
    return [self flagsFromFlagString:modifierFlagString];
}

// -------------------------
+ (void)setMoveModifierFlagString:(NSString *)flagString {
    [self setModifierFlagString:flagString forKey:MOVE_MODIFIER_FLAGS_DEFAULTS_KEY];
}

+ (void)setResizeModifierFlagString:(NSString *)flagString {
    [self setModifierFlagString:flagString forKey:RESIZE_MODIFIER_FLAGS_DEFAULTS_KEY];
}

+ (void)setModifierFlagString:(NSString*)flagString forKey:(NSString*)key {
    flagString = [[flagString stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString];
    [[NSUserDefaults standardUserDefaults] setObject:flagString forKey:key];
}

+ (void) setMoveModifierFlagSet:(NSSet*)flagStringSet {
    [self setMoveModifierFlagString:[[flagStringSet allObjects] componentsJoinedByString:@","]];
}

+ (void) setResizeModifierFlagSet:(NSSet*)flagStringSet {
    [self setResizeModifierFlagString:[[flagStringSet allObjects] componentsJoinedByString:@","]];
}

// -------------------------
+ (void)setMoveModifierKey:(NSString *)singleFlagString enabled:(BOOL)enabled {
    [self setModifierKey:singleFlagString enabled:enabled forDefaultsKey:MOVE_MODIFIER_FLAGS_DEFAULTS_KEY];
}

+ (void)setResizeModifierKey:(NSString *)singleFlagString enabled:(BOOL)enabled {
    [self setModifierKey:singleFlagString enabled:enabled forDefaultsKey:RESIZE_MODIFIER_FLAGS_DEFAULTS_KEY];
}

+ (void)setModifierKey:(NSString *)singleFlagString enabled:(BOOL)enabled forDefaultsKey:(NSString*)defaultsKey {
    singleFlagString = [singleFlagString uppercaseString];
    NSString *modifierFlagString = [[NSUserDefaults standardUserDefaults] stringForKey:defaultsKey];
    if (modifierFlagString == nil) {
        // No prior value set. Set if enabled.
        if (enabled) {
            [self setMoveModifierFlagString:singleFlagString];
            return;
        }
    }
    NSMutableSet *flagSet = [self createSetFromFlagString:modifierFlagString];
    if (enabled) {
        [flagSet addObject:singleFlagString];
    }
    else {
        [flagSet removeObject:singleFlagString];
    }
    [self setMoveModifierFlagString:[[flagSet allObjects] componentsJoinedByString:@","]];
}

// -------------------------
+ (NSSet*)moveFlagStringSet {
    return [self flagStringSetForKey:MOVE_MODIFIER_FLAGS_DEFAULTS_KEY];
}

+ (NSSet*)resizeFlagStringSet {
    return [self flagStringSetForKey:RESIZE_MODIFIER_FLAGS_DEFAULTS_KEY];
}

+ (NSSet*)flagStringSetForKey:(NSString*)key {
    NSString *modifierFlagString = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (modifierFlagString == nil) {
        return [NSSet setWithObjects:CTRL_KEY, CMD_KEY, nil];
    }
    NSMutableSet *flagSet = [self createSetFromFlagString:modifierFlagString];
    return flagSet;
}

// -------------------------
+ (void) removeDefaults {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:MOVE_MODIFIER_FLAGS_DEFAULTS_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:RESIZE_MODIFIER_FLAGS_DEFAULTS_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:MOVE_MOUSE_BUTTON_DEFAULTS_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:RESIZE_MOUSE_BUTTON_DEFAULTS_KEY];
}

+ (eMouseButton) moveMouseButton {
    eMouseButton button = (eMouseButton)[[NSUserDefaults standardUserDefaults] integerForKey:MOVE_MOUSE_BUTTON_DEFAULTS_KEY];
    if (button == 0) {
        button = eLeftMouseButton;
    }
    return button;
}

+ (void) setMoveMouseButton:(eMouseButton)button {
    [[NSUserDefaults standardUserDefaults] setInteger:(NSInteger)button forKey:MOVE_MOUSE_BUTTON_DEFAULTS_KEY];
}

+ (eMouseButton) resizeMouseButton {
    eMouseButton button = (eMouseButton)[[NSUserDefaults standardUserDefaults] integerForKey:RESIZE_MOUSE_BUTTON_DEFAULTS_KEY];
    if (button == 0) {
        button = eRightMouseButton;
    }
    return button;
}

+ (void) setResizeMouseButton:(eMouseButton)button {
    [[NSUserDefaults standardUserDefaults] setInteger:(NSInteger)button forKey:RESIZE_MOUSE_BUTTON_DEFAULTS_KEY];
}


// --------------------------------------------------------------------
// Private methods

+ (NSMutableSet*)createSetFromFlagString:(NSString*)modifierFlagString {
    modifierFlagString = [[modifierFlagString stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString];
    if ([modifierFlagString length] == 0) {
        return [[NSMutableSet alloc] initWithCapacity:0];
    }
    NSArray *flagList = [modifierFlagString componentsSeparatedByString:@","];
    NSMutableSet *flagSet = [[NSMutableSet alloc] initWithArray:flagList];
    return flagSet;
}


+ (int)flagsFromFlagString:(NSString*)modifierFlagString {
    int modifierFlags = 0;
    if (modifierFlagString == nil || [modifierFlagString length] == 0) {
        return 0;
    }
    NSSet *flagList = [self createSetFromFlagString:modifierFlagString];
    
    if ([flagList containsObject:CTRL_KEY]) {
        modifierFlags |= kCGEventFlagMaskControl;
    }
    if ([flagList containsObject:SHIFT_KEY]) {
        modifierFlags |= kCGEventFlagMaskShift;
    }
    if ([flagList containsObject:CAPS_KEY]) {
        modifierFlags |= kCGEventFlagMaskAlphaShift;
    }
    if ([flagList containsObject:ALT_KEY]) {
        modifierFlags |= kCGEventFlagMaskAlternate;
    }
    if ([flagList containsObject:CMD_KEY]) {
        modifierFlags |= kCGEventFlagMaskCommand;
    }
    
    return modifierFlags;
}
@end

