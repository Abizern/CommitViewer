//
//  CommitViewerAppDelegate.h
//  CommitViewer
//
//  Created by Abizer Nasir on 13/09/2011.
//  Copyright 2011 Jungle Candy Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class GTCommit;

@interface AppDelegate : NSObject <NSApplicationDelegate, NSOpenSavePanelDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) GTCommit *commit;

- (IBAction)openNewRepository:(id)sender;

@end
