//
//  GridView.m
//  binary-mouse
//
//  Created by Shabarivas Abhiram on 5/8/15.
//  Copyright (c) 2015 Shaba Abhiram. All rights reserved.
//

#import "GridView.h"

@implementation GridView

- (void)drawRect:(NSRect)dirtyRect {
    NSLog(@"GridView %@", NSStringFromRect(dirtyRect));
    // erase the background by drawing white
    [[NSColor whiteColor] set];
    [NSBezierPath fillRect: dirtyRect];
}


- (id) initWithFrame: (NSRect) frameRect {
    self = [super initWithFrame: frameRect];
    if (self) {
        [self setNeedsDisplay: YES];
    }
    return self;
}

@end
