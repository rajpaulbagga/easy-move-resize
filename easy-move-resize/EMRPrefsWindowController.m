//
//  EMRPrefsWindowController.m
//  easy-move-resize
//
//  Created by Rajpaul Bagga on 2016-02-11.
//  Copyright © 2016 Daniel Marcotte. All rights reserved.
//

#import "EMRPrefsWindowController.h"

@implementation EMRPrefsWindowController

-(id)init {
    [self setMoveFlags:[[NSMutableSet alloc] initWithSet:[EMRPreferences moveFlagStringSet]]];
    [self setResizeFlags:[[NSMutableSet alloc] initWithSet:[EMRPreferences resizeFlagStringSet]]];
    [self setSelectedMoveMouseButton:[EMRPreferences moveMouseButton]];
    [self setSelectedResizeMouseButton:[EMRPreferences resizeMouseButton]];
    return self;
}

-(void) open {
    [[self window] makeMainWindow];
}

-(IBAction) toggleMoveModiferButton:(NSButton*)sender {
    BOOL enabled = (BOOL)[sender integerValue];
    NSString *modifier;
    if ([self moveAltKeyButton] == sender) {
        modifier = ALT_KEY;
    }
    else if ([self moveCmdKeyButton] == sender) {
        modifier = CMD_KEY;
    }
    else if ([self moveCtrlKeyButton] == sender) {
        modifier = CTRL_KEY;
    }
    else if ([self moveShiftKeyButton] == sender) {
        modifier = SHIFT_KEY;
    }
    
    if (enabled) {
        [[self moveFlags] addObject:modifier];
    }
    else {
        [[self moveFlags] removeObject:modifier];
    }
}

-(IBAction) toggleResizeModiferButton:(NSButton*)sender {
    BOOL enabled = (BOOL)[sender integerValue];
    NSString *modifier;

    if ([self moveAltKeyButton] == sender) {
        modifier = ALT_KEY;
    }
    else if ([self moveCmdKeyButton] == sender) {
        modifier = CMD_KEY;
    }
    else if ([self moveCtrlKeyButton] == sender) {
        modifier = CTRL_KEY;
    }
    else if ([self moveShiftKeyButton] == sender) {
        modifier = SHIFT_KEY;
    }

    if (enabled) {
        [[self resizeFlags] addObject:modifier];
    }
    else {
        [[self resizeFlags] removeObject:modifier];
    }
}

- (IBAction)setMoveMouseButton:(NSButton*)sender {
    if ([self moveLeftMouseRadioButton] == sender) {
        [self setSelectedMoveMouseButton:eLeftMouseButton];
    }
    else if ([self moveRightMouseRadioButton] == sender) {
        [self setSelectedMoveMouseButton:eRightMouseButton];
    }
}

- (IBAction)setResizeMouseButton:(NSButton*)sender {
    if ([self moveLeftMouseRadioButton] == sender) {
        [self setSelectedResizeMouseButton:eLeftMouseButton];
    }
    else if ([self moveRightMouseRadioButton] == sender) {
        [self setSelectedResizeMouseButton:eRightMouseButton];
    }
}

- (IBAction)savePreferences:(id)sender {
    [EMRPreferences setMoveModifierFlagSet:[self moveFlags]];
    [EMRPreferences setResizeModifierFlagSet:[self resizeFlags]];
    [EMRPreferences setMoveMouseButton:[self selectedMoveMouseButton]];
    [EMRPreferences setResizeMouseButton:[self selectedResizeMouseButton]];
}

- (IBAction)cancelPreferences:(id)sender {
    [[self window] close];
}

@end
