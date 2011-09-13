//
//  CommitViewerAppDelegate.h
//  CommitViewer
//
//  Created by Abizer Nasir on 13/09/2011.
//  Copyright 2011 Jungle Candy Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CommitViewerAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
