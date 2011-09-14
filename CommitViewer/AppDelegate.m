//
//  CommitViewerAppDelegate.m
//  CommitViewer
//
//  Created by Abizer Nasir on 13/09/2011.
//  Copyright 2011 Jungle Candy Software. All rights reserved.
//

#import "AppDelegate.h"
#import <ObjectiveGit/ObjectiveGit.h>

@interface AppDelegate ()

- (NSURL *)repositoryURLForURL:(NSURL *)url;

@end

@implementation AppDelegate

@synthesize window;
@synthesize commit;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}



- (IBAction)openNewRepository:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.delegate = self;
    panel.canChooseDirectories = YES;
    panel.showsHiddenFiles = YES;
    
    [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            NSLog(@"selected: %@", [self repositoryURLForURL:panel.URL]);
        }
    }];
    
}

#pragma mark - OpenSavePanel Delegate methods

- (BOOL)panel:(id)sender shouldEnableURL:(NSURL *)url {
    // Should do more here to enable and disable items - but I'm lazy.
    return YES;
}

- (BOOL)panel:(NSOpenPanel *)sender validateURL:(NSURL *)url error:(NSError **)outError {
    if (!([self repositoryURLForURL:url])) {
        return NO;
    }
    
    return YES;
}

#pragma mark - class extension

- (NSURL *)repositoryURLForURL:(NSURL *)url {
    // returns the repository URL or nil if it can't be made.
    // If the URL is a file, it should have the extension '.git' - bare repository
    // If the URL is a folder it should have the name '.git'
    // If the URL is a folder, then it should contain a subfolder called '.git
    NSString *kGit = @".git";
    NSString *endPoint = [url lastPathComponent];
    NSLog(@"Endpoint: %@", endPoint);
    
    if ([[endPoint lowercaseString] hasSuffix:kGit]) {
        return url;
    }
    
    if ([endPoint isEqualToString:kGit]) {
        return url;
    }
    
    NSURL *possibleGitDir = [url URLByAppendingPathComponent:kGit isDirectory:YES];
    if ([possibleGitDir checkResourceIsReachableAndReturnError:NULL]) {
        return possibleGitDir;
    }
    
    NSLog(@"Not a valid path");
    return nil;

    
}

@end
