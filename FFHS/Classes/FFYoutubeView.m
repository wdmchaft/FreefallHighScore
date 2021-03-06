#import "FFYouTubeView.h"

@implementation FFYouTubeView

#pragma mark -
#pragma mark Initialization

- (void) loadYoutubeURL:(NSString*)urlString
{
    // HTML to embed YouTube video
    NSString *youTubeVideoHTML = @"<html><head>\
                                    <body style=\"margin:0\">\
                                    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
                                    width=\"%0.0f\" height=\"%0.0f\"></embed>\
                                    </body></html>";
    
    // Populate HTML with the URL and requested frame size
    NSString *html = [NSString stringWithFormat:youTubeVideoHTML, urlString, self.frame.size.width, self.frame.size.height];
    
    
    //NSString *theTitle=
    NSLog(@"final html is %@", html);
    
    // Load the html into the webview
    [self loadHTMLString:html baseURL:nil];
}

- (void)dealloc 
{
    [super dealloc];
}

@end