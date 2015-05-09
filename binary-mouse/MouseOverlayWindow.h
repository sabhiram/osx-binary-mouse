//
//  MouseOverlayWindow.h
//  binary-mouse
//
//  Created by Shabarivas Abhiram on 5/8/15.
//  Copyright (c) 2015 Shaba Abhiram. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GridView.h"

@interface MouseOverlayWindow : NSWindow

@property NSRect m_currentWindowRect;
@property float  m_startingHeight;

@end
