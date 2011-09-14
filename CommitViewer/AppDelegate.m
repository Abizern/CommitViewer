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

@property (nonatomic, retain) GTCommit *commit;

- (NSURL *)repositoryURLForURL:(NSURL *)url;

@end

@implementation AppDelegate

@synthesize window;
@synthesize commit;

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    NSSet *keySet = [NSSet setWithObjects:@"commit", nil];
    if ([key isEqualToString:@"messageTitle"] || [key isEqualToString:@"messageDetails"] || [key isEqualToString:@"author"] || [key isEqualToString:@"date"]) {
        return keySet;
    }
    return [super keyPathsForValuesAffectingValueForKey:key];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

#pragma mark - non-synthesised accessors
// Annoying that I have to do this - I'll have to change GTCommit to use properties at some later stage.

- (NSString *)messageTitle {
    return [self.commit messageTitle];
}

- (NSString *)messageDetails {
    return [self.commit messageDetails];
}

- (NSString *)author {
    return [self.commit author].name;
}

- (NSDate *)date {
    return [self.commit commitDate];
}

- (IBAction)openNewRepository:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.delegate = self;
    panel.canChooseDirectories = YES;
    panel.showsHiddenFiles = YES;
    
    [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelCancelButton) {
            return;
        }
        // I should do more error checking but thsi is only an example project ;)
        GTRepository *repo = [GTRepository repositoryWithURL:[self repositoryURLForURL:panel.URL] error:NULL];
        GTReference *head = [repo headReferenceWithError:NULL];
        self.commit = (GTCommit *)[repo lookupObjectBySha:[head target]  error:NULL];
        
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
