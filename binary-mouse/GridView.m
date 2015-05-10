//
//  GridView.m
//  binary-mouse
//
//  Created by Shabarivas Abhiram on 5/8/15.
//  Copyright (c) 2015 Shaba Abhiram. All rights reserved.
//

#import "GridView.h"

@implementation GridView

- (void) drawLineFromPoint: (NSPoint) from
                   toPoint: (NSPoint) to
                withStroke: (float) s {
    
    NSBezierPath* path = [NSBezierPath bezierPath];
    [path moveToPoint: from];
    [path lineToPoint: to];
    [path closePath];
    [[NSColor yellowColor] set];
    [path setLineWidth: s];
    [path stroke];
}

- (void)drawRect:(NSRect)rect {
    [super drawRect: rect];
    NSRect f = self.window.frame;
    NSLog(@"drawRect %@", NSStringFromRect(f));
    
    float width  = f.size.width;
    float height = f.size.height;
    float x      = f.origin.x;
    float y      = f.origin.y;
    float majorS = 0.0;
    float minorS = 0.0;
    NSLog(@"W: %f H: %f", width, height);
    
    // Draw major axis which splits the quad into 4 pieces
    [self drawLineFromPoint: NSMakePoint(width / 2.0 - majorS, 0)
                    toPoint: NSMakePoint(width / 2.0 - majorS, height)
                 withStroke: majorS];
    [self drawLineFromPoint: NSMakePoint(0,     height / 2.0 - majorS)
                    toPoint: NSMakePoint(width, height / 2.0 - majorS)
                 withStroke: majorS];
    
    
}


- (id) initWithFrame: (NSRect) rect {
    NSLog(@"initWithFrame %@", NSStringFromRect(rect));
    self = [super initWithFrame: rect];
    if (self) {
        [self setAutoresizingMask: NSViewHeightSizable|NSViewWidthSizable];
        [self setNeedsDisplay: YES];
        [self setFrame: rect];
    }
    return self;
}
@end
