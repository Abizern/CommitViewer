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
@property (nonatomic, readonly) NSString *messageTitle;
@property (nonatomic, readonly) NSString *messageDetails;
@property (nonatomic, readonly) NSString *author;
@property (nonatomic, readonly) NSDate *date;


- (IBAction)openNewRepository:(id)sender;

@end
