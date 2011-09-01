//
//  FlipsideViewController.m
//  FFHS
//
//  Created by James George on 8/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FFFlipsideViewController.h"
#import "FFYoutubeUploader.h"
#import "HJObjManager.h"

#import "FFFlipsideHighscoresController.h"
#import "FFFlipsideMyDropsController.h"
#import "FFFlipsideInstructionsController.h"

@implementation FFFlipsideViewController

@synthesize delegate=_delegate;
@synthesize uploader;
@synthesize tabBarController;
@synthesize imageViewManager;

- (void)dealloc
{
    [imageViewManager release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];  
    [self.view addSubview: self.tabBarController.view];

    [[[self.tabBarController viewControllers ]objectAtIndex:0] setFlipsideController:self];
    [[[self.tabBarController viewControllers ]objectAtIndex:1] setFlipsideController:self];
    [[[self.tabBarController viewControllers ]objectAtIndex:2] setFlipsideController:self];
    
    // Create the object manager
	imageViewManager = [[HJObjManager alloc] initWithLoadingBufferSize:6 memCacheSize:20];
    // Create a file cache for the object manager to use
	// A real app might do this durring startup, allowing the object manager and cache to be shared by several screens
	NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/frefall/"] ;
	HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] autorelease];
	imageViewManager.fileCache = fileCache;
    
    // Have the file cache trim itself down to a size & age limit, so it doesn't grow forever
	fileCache.fileCountLimit = 100;
	fileCache.fileAgeLimit = 60*60*24*7; //1 week
	[fileCache trimCacheUsingBackgroundThread];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)login:(id)sender
{
    NSLog(@"logging in");
    [self.uploader login:sender];
}

- (IBAction)logout:(id)sender
{
    NSLog(@"logging out");
    [self.uploader logout:sender];
}

@end
