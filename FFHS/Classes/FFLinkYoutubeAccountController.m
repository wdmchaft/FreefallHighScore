//
//  FFLinkYoutubeAccountController.m
//  FreefallHighscore
//
//  Created by Jim on 9/6/11.
//  Copyright 2011 FlightPhase. All rights reserved.
//

#import "FFLinkYoutubeAccountController.h"


@implementation FFLinkYoutubeAccountController

@synthesize linkYoutubeWebview;
@synthesize request;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        NSLog(@"loading nib... named %@", nibNameOrNil);
//        NSLog(@"my webview is %@", self.linkYoutubeWebview);
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.request = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"link view showing, loading request %@", request);
    [self.linkYoutubeWebview loadRequest:request];
}

- (void) accountLinked:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    
    //re-request setup
    [self.delegate userSignaledLinkedFinished]; 
}

- (void) cancelLink:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate userSignaledLinkedCanceled];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return interfaceOrientation == UIInterfaceOrientationLandscapeRight;
    //return YES;
}

@end
