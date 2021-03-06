//
//  FFFlipsideController.m
//  FreefallHighscore
//
//  Created by James George on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FFFlipsideController.h"
#import "FFFlipsideViewController.h"
#import "FFUtilities.h"
#import "FFYoutubeViewController.h"
#import "FFAppDelegate.h"

@implementation FFFlipsideController

@synthesize flipsideController;
@synthesize loginButton;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//    }
//    return self;
//}

- (void)dealloc
{

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)done:(id)sender
{
    [self.flipsideController done:sender];
}

- (IBAction)login:(id)sender
{
    [self.flipsideController login:sender];
}

- (void) refreshLoginButton
{
    [self.loginButton setTitle:[[[[UIApplication sharedApplication] delegate] uploader] loginButtonText]];
}

- (void) userDidLogIn:(id)sender
{
	[self refreshLoginButton] ;
}

- (void) userDidLogOut:(id)sender
{
    [self refreshLoginButton];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone  
                                                                                target:self.flipsideController 
                                                                                action:@selector(done:)];
	self.loginButton = [[UIBarButtonItem alloc] initWithTitle:@"Log in" 
                                                        style:UIBarButtonItemStylePlain 
                                                       target:self.flipsideController 
                                                       action:@selector(login:)];
    
    self.navigationItem.leftBarButtonItem = doneButton;
    self.navigationItem.rightBarButtonItem = loginButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidLogIn:)
                                                 name:kFFUserDidLogin
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidLogOut:)
                                                 name:kFFUserDidLogout
                                               object:nil];

    [self refreshLoginButton];
    
    [loginButton release];
	[doneButton release];
    
}

- (void)showYoutubeVideo:(NSString*)youtubeURL withTitle:(NSString*)title
{
    FFYoutubeViewController* youtubeController = [[FFYoutubeViewController alloc] initWithNibName:nil bundle:nil];
    youtubeController.youtubeURL = youtubeURL;
    youtubeController.hidesBottomBarWhenPushed = YES;
    youtubeController.navigationItem.title = title;
	[self.navigationController	pushViewController:youtubeController animated:YES];

    NSLog(@"Presenting view for URL %@", youtubeURL );    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshLoginButton];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFFUserDidLogin object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFFUserDidLogout object:nil];

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
//    return YES;
}

@end
