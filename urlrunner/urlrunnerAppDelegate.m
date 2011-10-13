#import "urlrunnerAppDelegate.h"

@implementation urlrunnerAppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // register the event handler
    NSLog(@"%@", @"launcher");
    [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self andSelector:@selector(handleURLEvent:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
}

- (void)handleURLEvent:(NSAppleEventDescriptor*)event withReplyEvent:(NSAppleEventDescriptor*)replyEvent
{
    NSLog(@"%@", @"handler");
    NSString* url = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
    NSUInteger flags = [NSEvent modifierFlags] & NSDeviceIndependentModifierFlagsMask;

    // some string cleanup
    url = [url stringByReplacingOccurrencesOfString:@"urlrunner://" withString:@""];
    url = [url stringByReplacingOccurrencesOfString:@"file//" withString:@""];
    
    // lets log it
    NSLog(@"%@", url);

    // open the file if you are holding shift
    if( flags & NSShiftKeyMask ){
        [[NSWorkspace sharedWorkspace] openFile:url];

    // open the file
    } else {
        [[NSWorkspace sharedWorkspace] selectFile:url inFileViewerRootedAtPath:url];
    }
}

@end
