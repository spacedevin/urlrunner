//
//  urlrunnerAppDelegate.h
//  urlrunner
//
//  Created by arzynik on 10/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface urlrunnerAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *_window;
}

@property (strong) IBOutlet NSWindow *window;

@end
