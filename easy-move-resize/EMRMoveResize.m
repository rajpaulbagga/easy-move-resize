#import "EMRMoveResize.h"

@implementation EMRMoveResize
@synthesize eventTap = _eventTap;
@synthesize runLoopSource = _runLoopSource;
@synthesize resizeSection = _resizeSection;
@synthesize window = _window;
@synthesize tracking = _tracking;
@synthesize wndPosition = _wndPosition;
@synthesize wndSize = _wndSize;

+ (EMRMoveResize*)instance {
    static EMRMoveResize *instance = nil;

    if (instance == nil) {
        instance = [[EMRMoveResize alloc] init];
    }

    return instance;
}

- init {
    _window = nil;
    _runLoopSource = nil;
    [self setMoveMouseButton:eLeftMouseButton];
    [self setResizeMouseButton:eRightMouseButton];
    return self;
}

- (AXUIElementRef)window {
    return _window;
}

- (void)setWindow:(AXUIElementRef)window {
    if (_window != nil) CFRelease(_window);
    if (window != nil) CFRetain(window);
    _window = window;
}

- (CFRunLoopSourceRef) runLoopSource {
    return _runLoopSource;
}

- (void)setRunLoopSource:(CFRunLoopSourceRef)runLoopSource {
    if (_runLoopSource != nil) CFRelease(_runLoopSource);
    if (runLoopSource != nil) CFRetain(runLoopSource);
    _runLoopSource = runLoopSource;
}

- (void) setMoveMouseButton:(eMouseButton)mouseButton {
    switch (mouseButton) {
        default:
        case eLeftMouseButton:
            [self setEventMoveMouseUp: kCGEventLeftMouseUp];
            [self setEventMoveMouseDown: kCGEventLeftMouseDown];
            [self setEventMoveMouseDragged: kCGEventLeftMouseDragged];
            break;
        case eRightMouseButton:
            [self setEventMoveMouseUp: kCGEventRightMouseUp];
            [self setEventMoveMouseDown: kCGEventRightMouseDown];
            [self setEventMoveMouseDragged: kCGEventRightMouseDragged];
            break;
    }
}

- (void) setResizeMouseButton:(eMouseButton)mouseButton {
    switch (mouseButton) {
        case eLeftMouseButton:
            [self setEventResizeMouseUp: kCGEventLeftMouseUp];
            [self setEventResizeMouseDown: kCGEventLeftMouseDown];
            [self setEventResizeMouseDragged: kCGEventLeftMouseDragged];
            break;
        default:
        case eRightMouseButton:
            [self setEventResizeMouseUp: kCGEventRightMouseUp];
            [self setEventResizeMouseDown: kCGEventRightMouseDown];
            [self setEventResizeMouseDragged: kCGEventRightMouseDragged];
            break;
    }
}

- (void)dealloc {
    if (_window != nil) CFRelease(_window);
}

@end
