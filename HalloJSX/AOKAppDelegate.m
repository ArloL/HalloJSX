#import "AOKAppDelegate.h"

#import <WebKit/WebKit.h>

@interface AOKAppDelegate ()

@property (weak) IBOutlet WebView *webview;

@end

@implementation AOKAppDelegate

+(BOOL)isSelectorExcludedFromWebScript:(SEL)selector {
    if (selector == @selector(consoleLog:)) {
        return NO;
    }
    if (selector == @selector(save:)) {
        return NO;
    }
    
    return YES;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.webview setFrameLoadDelegate:self];

    [[self.webview mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]]]];
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    id scriptObject = [sender windowScriptObject];
    [scriptObject setValue:self forKey:@"MyApp"];
    [scriptObject evaluateWebScript:@"console = { log: function(msg) { MyApp.consoleLog_(msg); } }"];
}

- (void)consoleLog:(NSString *)aMessage {
    NSLog(@"JSLog: %@", aMessage);
}

-(void)save:(NSString *)content {
    NSLog(@"Saving: %@", content);
}

@end
