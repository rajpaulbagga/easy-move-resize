//
//  EMRPrefsWindowController.h
//  easy-resize-resize
//
//  Created by Rajpaul Bagga on 2016-02-11.
//  Copyright © 2016 Daniel Marcotte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMRPreferences.h"

@interface EMRPrefsWindowController : NSWindowController {
}


-(IBAction) toggleMoveModiferButton:(NSButton*)sender;
-(IBAction) toggleResizeModiferButton:(NSButton*)sender;

@property eMouseButton selectedMoveMouseButton;
@property eMouseButton selectedResizeMouseButton;
@property NSMutableSet* moveFlags;
@property NSMutableSet* resizeFlags;

@property (weak) IBOutlet NSButton* moveAltKeyButton;
@property (weak) IBOutlet NSButton* moveCmdKeyButton;
@property (weak) IBOutlet NSButton* moveCtrlKeyButton;
@property (weak) IBOutlet NSButton* moveShiftKeyButton;

@property (weak) IBOutlet NSButton* resizeAltKeyButton;
@property (weak) IBOutlet NSButton* resizeCmdKeyButton;
@property (weak) IBOutlet NSButton* resizeCtrlKeyButton;
@property (weak) IBOutlet NSButton* resizeShiftKeyButton;

@property (weak) IBOutlet NSButton* moveLeftMouseRadioButton;
@property (weak) IBOutlet NSButton* moveRightMouseRadioButton;
@property (weak) IBOutlet NSButton* resizeLeftMouseRadioButton;
@property (weak) IBOutlet NSButton* resizeRightMouseRadioButton;


@end
