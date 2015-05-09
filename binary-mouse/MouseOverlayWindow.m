//
//  MouseOverlayWindow.m
//  binary-mouse
//
//  Created by Shabarivas Abhiram on 5/8/15.
//  Copyright (c) 2015 Shaba Abhiram. All rights reserved.
//

#import "MouseOverlayWindow.h"

@implementation MouseOverlayWindow

- (NSRect) getScreenSize {
    NSScreen *mainScreen = [NSScreen mainScreen];
    NSRect screenRect    = [mainScreen visibleFrame];
    
    NSLog(@"Screen %@", NSStringFromRect(screenRect));
    return screenRect;
}

- (void) resizeWindow: (NSEvent *)event {
    NSPoint origin = self.m_currentWindowRect.origin;
    NSSize  size   = self.m_currentWindowRect.size;
    
    switch ([event keyCode]) {
        // LEFT - Maintain origin, chop width in 1/2
        case 123:
            size.width /= 2;
            break;

        // RIGHT - Move origin.x up by width / 2, width divs in 1/2
        case 124:
            size.width /= 2;
            origin.x   += size.width;
            break;
            
        // DOWN - Maintain origin, chop height in 1/2
        case 125:
            size.height /= 2;
            break;
            
        // UP - Maintain origin, chop height in 1/2
        case 126:
            size.height /= 2;
            origin.y    += size.height;
            break;
        
        default:
            NSLog(@"Unknown event type!");
            return;
    }
    
    self.m_currentWindowRect = NSMakeRect(origin.x, origin.y, size.width, size.height);
    [self setFrame: self.m_currentWindowRect display: YES animate: YES];
}

- (void) leftClickPoint: (CGPoint) point {
    CGEventRef e = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseDown, point, kCGMouseButtonLeft);
    CGEventPost(kCGHIDEventTap, e);
    CGEventSetType(e, kCGEventLeftMouseUp);
    CGEventPost(kCGHIDEventTap, e);
    CFRelease(e);
}

- (void) rightClickPoint: (CGPoint) point {
    CGEventRef e = CGEventCreateMouseEvent(NULL, kCGEventRightMouseDown, point, kCGMouseButtonRight);
    CGEventPost(kCGHIDEventTap, e);
    CGEventSetType(e, kCGEventRightMouseUp);
    CGEventPost(kCGHIDEventTap, e);
    CFRelease(e);
}

- (CGPoint) getCenterOfRect: (NSRect) r {
    NSPoint p = r.origin;
    
    // X Position
    p.x += r.size.width  / 2;
  
    // Transform the point so its transposed from the center
    p.y = self.m_startingHeight - p.y + 16;
    p.y -= (r.size.height) / 2;

    // Cursor offset
    NSPoint offset = [[NSCursor arrowCursor] hotSpot];
    p.y += offset.y;
    
    return p;
}


- (void) keyDown:(NSEvent *)event {
    switch ([event keyCode]) {
        // ESC should kill the app
        case 53:
            [NSApp terminate: nil];
            break;
        
        // LEFT, RIGHT, UP, DOWN chop the selection in 1/2
        case 123:
        case 124:
        case 126:
        case 125:
            [self resizeWindow: event];
            break;
        
        // SPACEBAR or ENTER clicks the mouse
        case 36:
        case 49:
            // Send a click to the appropriate spot
            [self orderOut: self];
            [self leftClickPoint: [self getCenterOfRect: self.m_currentWindowRect]];
            [self leftClickPoint: [self getCenterOfRect: self.m_currentWindowRect]];
            [NSApp terminate: self];
            break;
        
        // SHIFT = right click
        case 56:
            [self orderOut: self];
            [self rightClickPoint: [self getCenterOfRect: self.m_currentWindowRect]];
            [NSApp terminate: self];
            break;
        
        default:
            [super keyDown: event];
            break;
    }

}

- (id) initWithContentRect:(NSRect)contentRect
                styleMask:(NSUInteger)aStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)flag {
    
    // Using NSBorderlessWindowMask results in a window without a title bar.
    self = [super initWithContentRect: contentRect
                            styleMask: NSBorderlessWindowMask
                              backing: bufferingType
                                defer: flag];

    // Fetch the current screen size
    self.m_currentWindowRect = [self getScreenSize];
    self.m_startingHeight    = self.m_currentWindowRect.size.height;
    
    if (self == nil) {
        return nil;
    }
    
    [self setHasShadow: NO];
    [self setOpaque: YES];
    [self setBackgroundColor: [NSColor redColor]];
    [self setLevel: NSScreenSaverWindowLevel - 1];
    [self setAlphaValue: 0.2f];
    [self setFrame: self.m_currentWindowRect display: YES];
    
    // Build our view :)
    GridView *gv = [[GridView alloc] initWithFrame: self.m_currentWindowRect];
    [[self contentView] addSubview: gv];

    return self;
}

- (void) drawRect: (CGRect) rect {
    NSLog(@"DRAW RECT CALLED");
}

/*
 Custom windows that use the NSBorderlessWindowMask can't become key by default. Override this method
 so that controls in this window will be enabled.
 */
- (BOOL) canBecomeKeyWindow {
    
    return YES;
}


@end
