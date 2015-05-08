//
//  MouseOverlayWindow.m
//  binary-mouse
//
//  Created by Shabarivas Abhiram on 5/8/15.
//  Copyright (c) 2015 Shaba Abhiram. All rights reserved.
//

#import "MouseOverlayWindow.h"

@implementation MouseOverlayWindow

- (NSRect)getScreenSize {
    NSScreen *mainScreen = [NSScreen mainScreen];
    NSRect screenRect    = [mainScreen visibleFrame];
    
    NSLog(@"Screen %@", NSStringFromRect(screenRect));
    return screenRect;
}

- (void)keyDown:(NSEvent *)event {
    switch ([event keyCode]) {
        // ESC should kill the app
        case 53:
            [NSApp terminate: nil];
            break;
        
        // LEFT should choose the left 1/2
        // RIGHT should choose the right 1/2
        // Same w/ UP and DOWN
        
        default:
            [super keyDown: event];
            break;
    }

}

- (id)initWithContentRect:(NSRect)contentRect
                styleMask:(NSUInteger)aStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)flag {
    
    // Using NSBorderlessWindowMask results in a window without a title bar.
    self = [super initWithContentRect:contentRect
                            styleMask:NSBorderlessWindowMask
                              backing:bufferingType
                                defer:flag];

    // Fetch the current screen size
    NSRect screenSize = [self getScreenSize];

    if (self != nil) {
        [self setHasShadow:NO];
        [self setOpaque:YES];
        [self setBackgroundColor:[NSColor redColor]];
        [self setLevel:NSScreenSaverWindowLevel - 1];
        [self setAlphaValue:0.2f];
        [self setFrame:screenSize display:YES];
    }
    return self;
}

/*
 Custom windows that use the NSBorderlessWindowMask can't become key by default. Override this method
 so that controls in this window will be enabled.
 */
- (BOOL)canBecomeKeyWindow {
    
    return YES;
}


@end
