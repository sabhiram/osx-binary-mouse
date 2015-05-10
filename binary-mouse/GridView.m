//
//  GridView.m
//  binary-mouse
//
//  Created by Shabarivas Abhiram on 5/8/15.
//  Copyright (c) 2015 Shaba Abhiram. All rights reserved.
//

#import "GridView.h"

@implementation GridView

- (void) drawLineFromPoint: (NSPoint)  from
                   toPoint: (NSPoint)  to
                withStroke: (float)    stroke
                  andColor: (NSColor*) color {
    
    NSBezierPath* path = [NSBezierPath bezierPath];
    [color set];
    [path moveToPoint: from];
    [path lineToPoint: to];
    [path closePath];
    [path setLineWidth: stroke];
    [path stroke];
}

- (void)drawRect:(NSRect)rect {
    [super drawRect: rect];
    const float MINOR_AXIS_MIN_LENGTH = 256.0;

    NSRect f      = self.window.frame;
    float width   = f.size.width;
    float height  = f.size.height;
    float wstroke = 1.0;
    float hstroke = 1.0;
    
    // Draw minor axis for height
    if (width > MINOR_AXIS_MIN_LENGTH) {
        [self drawLineFromPoint: NSMakePoint(width / 4.0, 0)
                        toPoint: NSMakePoint(width / 4.0, height)
                     withStroke: hstroke
                       andColor: [NSColor colorWithRed: 0.95 green: 0.90 blue: 0.2 alpha: 0.9]];
        
        [self drawLineFromPoint: NSMakePoint(3.0 * width / 4.0, 0)
                        toPoint: NSMakePoint(3.0 * width / 4.0, height)
                     withStroke: hstroke
                       andColor: [NSColor colorWithRed: 0.95 green: 0.90 blue: 0.2 alpha: 0.9]];

        // Update size for major axis
        hstroke = 2.0;
    }
    
    // Draw minor axis for width
    if (height > MINOR_AXIS_MIN_LENGTH) {
        [self drawLineFromPoint: NSMakePoint(0,     height / 4.0)
                        toPoint: NSMakePoint(width, height / 4.0)
                     withStroke: wstroke
                       andColor: [NSColor colorWithRed: 0.95 green: 0.90 blue: 0.2 alpha: 0.9]];
        
        [self drawLineFromPoint: NSMakePoint(0,     3.0 * height / 4.0)
                        toPoint: NSMakePoint(width, 3.0 * height / 4.0)
                     withStroke: wstroke
                       andColor: [NSColor colorWithRed: 0.95 green: 0.90 blue: 0.2 alpha: 0.9]];
        
        // Update size for major axis
        wstroke = 2.0;
    }
    
    // Draw major axis for height
    [self drawLineFromPoint: NSMakePoint(width / 2.0, 0)
                    toPoint: NSMakePoint(width / 2.0, height)
                 withStroke: hstroke
                   andColor: [NSColor colorWithRed: 0.95 green: 0.90 blue: 0.2 alpha: 1.0]];
    
    // Draw major axis for width
    [self drawLineFromPoint: NSMakePoint(0,     height / 2.0)
                    toPoint: NSMakePoint(width, height / 2.0)
                 withStroke: wstroke
                   andColor: [NSColor colorWithRed: 0.95 green: 0.90 blue: 0.2 alpha: 1.0]];
}


- (id) initWithFrame: (NSRect) rect {
    self = [super initWithFrame: rect];
    if (self) {
        [self setAutoresizingMask: NSViewHeightSizable|NSViewWidthSizable];
        [self setNeedsDisplay: YES];
        [self setFrame: rect];
    }
    return self;
}
@end
