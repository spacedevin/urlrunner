#import "urlrunnerAppDelegate.h"

@implementation urlrunnerAppDelegate

- init {
    // register the event
    [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self andSelector:@selector(handleURLEvent:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    // display the window. this should only open if we didnt get a handleURLEvent
    if([NSBundle loadNibNamed:@"MainWindow" owner:self]);
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return true;
}

- (void)handleURLEvent:(NSAppleEventDescriptor*)event withReplyEvent:(NSAppleEventDescriptor*)replyEvent
{
    NSString* url = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
    NSUInteger flags = [NSEvent modifierFlags] & NSDeviceIndependentModifierFlagsMask;

    // some string cleanup
    url = [url stringByReplacingOccurrencesOfString:@"urlrunner://" withString:@""];
    url = [url stringByReplacingOccurrencesOfString:@"file//" withString:@""];
    
    // lets log it
    // NSLog(@"%@", url);

    // open the file if you are holding shift
    if( flags & NSShiftKeyMask ){
        [[NSWorkspace sharedWorkspace] openFile:url];

    // open the file
    } else {
        [[NSWorkspace sharedWorkspace] selectFile:url inFileViewerRootedAtPath:url];
    }
    
    [NSApp terminate:nil];
}

@end
