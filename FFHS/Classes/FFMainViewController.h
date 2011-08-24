/*
     File: AVCamViewController.h
 Abstract: A view controller that coordinates the transfer of information between the user interface and the capture manager.
  Version: 1.2
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2011 Apple Inc. All Rights Reserved.
 
 */

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FFVideoOverlay.h"
#import "FFFlipsideViewController.h"
#import "FFUtilities.h"

typedef enum {
    kFFStateJustOpened,
    kFFStateReadyToDrop,
    kFFStatePreDropRecording,
    kFFStatePreDropCancelling,
    kFFStatePreDropCanceled,
    kFFStatePreDropTimedOut, //TODO:: implement a screen for this
    kFFStateInFreeFall,
    kFFStateFinishedDropPostroll,
    kFFStateFinishedDropProcessing,
    kFFStateFinishedDropVideoPlayback,
    kFFStateFinishedDropScoreView,
    kFFStateFinishedDropSubmitView,
    kFFStateFinishedDropUploading,
    kFFStateFinishedDropUploadComplete,
} FFGameState;

@class AVCamCaptureManager;
@class AVCamPreviewView;
@class AVCaptureVideoPreviewLayer;
@class AVPlayer;
@class AVPlayerLayer;
@class AccelerometerFilter;
@class FFTrackLocation;
@class FFYoutubeUploader;
@class FFWidgetOverlays;

@interface FFMainViewController : UIViewController <UINavigationControllerDelegate,UIAccelerometerDelegate,CLLocationManagerDelegate, FFVideoOverlayDelegate, FFFlipsideViewControllerDelegate, UITextFieldDelegate> {
    
	AccelerometerFilter *filter;
    NSMutableArray* accelerometerData;
    
    FFGameState state;
    
    NSTimeInterval freefallDuration;
    NSDate* freefallStartTime; 
    NSDate* freefallEndTime; 
    
    NSInteger framesInFreefall;
    NSInteger framesOutOfFreefall;
    
    NSInteger timesLooped;
    UIColor* fontcolor;
    
    NSDate* recordStartTime;
    FFTrackLocation *trackLoc;
    FFVideoOverlay* videoOverlay;
    AVURLAsset* assetForOverlay;
    AVPlayer* player;
    AVPlayerLayer* playerLayer;
    
    CGRect screenBounds;
    CGRect whiteTabBaseRect;
    CGRect dropBaseRect;    
    //TODO: Get rid of these
    CGRect baseScoreRect;
    CGRect scoreRectWithSubmitControls;
    
    BOOL libraryAssetURLReceived;
    NSURL* currentDropAssetURL;
    FFYoutubeUploader* uploader;
    FFWidgetOverlays* widgetOverlayLayer;

    BOOL firstLoad;
}

//camera related stuff
@property (nonatomic,retain) AVCamCaptureManager *captureManager;
@property (nonatomic,retain) IBOutlet UIView *videoPreviewView;
@property (nonatomic,retain) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (nonatomic,assign) IBOutlet UIButton *submitButton;
@property (nonatomic,assign) IBOutlet UIButton *dropButton;
@property (nonatomic,assign) IBOutlet UIButton *cancelDropButton;
@property (nonatomic,assign) IBOutlet UIButton *deleteDropButton;
@property (nonatomic,assign) IBOutlet UIButton *retryDropButton;
@property (nonatomic,assign) IBOutlet UIButton *introLoginButton;
@property (nonatomic,assign) IBOutlet UIButton *playVideoButton;
@property (nonatomic,assign) IBOutlet UIButton *infoButton;
@property (nonatomic,assign) IBOutlet UIButton *whatButton;

@property (nonatomic,assign) IBOutlet UIImageView* recordingFlash;

@property (nonatomic,assign) IBOutlet UIView* leftStripeContainer;
@property (nonatomic,assign) IBOutlet UIView* bottomStripeContainer;
@property (nonatomic,assign) IBOutlet UIView* rightStripeContainer;
@property (nonatomic,assign) IBOutlet UIView* whiteTabView;
@property (nonatomic,assign) IBOutlet UIView* blackTabView;

@property (nonatomic,assign) IBOutlet UIView* dropNowTextContainer;

@property (nonatomic,assign) IBOutlet UIImageView* blackTabLogo;
@property (nonatomic,assign) IBOutlet UIImageView* whiteTabLogo;

@property (nonatomic,assign) IBOutlet UILabel* dropscoreLabel;
@property (nonatomic,assign) IBOutlet UILabel* dropscoreSayingLabel;

//accel related stuff
@property (nonatomic,retain) AccelerometerFilter* filter;
@property (nonatomic,retain) NSMutableArray* acceleromterData;
@property (nonatomic,readwrite) NSTimeInterval freefallDuration;
@property (nonatomic,retain) NSDate* freefallStartTime;
@property (nonatomic,retain) NSDate* freefallEndTime;

//playback stuff
@property (nonatomic, retain) NSDate* recordStartTime;
@property (nonatomic, retain) AVPlayer* player;
@property (nonatomic, retain) AVPlayerLayer* playerLayer;
@property (nonatomic, retain) AVURLAsset* assetForOverlay;
@property (nonatomic, retain) FFVideoOverlay* videoOverlay;
@property (nonatomic, retain) NSURL* currentDropAssetURL;

//location stuff
@property (nonatomic,retain) FFTrackLocation *trackLoc;

//uploading stuff
@property (nonatomic,retain) FFYoutubeUploader* uploader;

@property (nonatomic,assign) IBOutlet UIView* scoreView;
@property (nonatomic,assign) IBOutlet UITextField* videoTitle;
@property (nonatomic,assign) IBOutlet UITextField* videoStory;
@property (nonatomic,assign) IBOutlet UIButton* cancelSubmitButton;
@property (nonatomic,assign) IBOutlet UIButton* loginButton;
@property (nonatomic,assign) FFWidgetOverlays* widgetOverlayLayer;

@property (nonatomic,assign) IBOutlet UIView* uploadProgressView;
@property (nonatomic,assign) IBOutlet UIProgressView* uploadProgressBar;

//state abstractors
- (BOOL) listenToAccel;
- (BOOL) isRecording;
- (BOOL) hasDropVideo;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

- (IBAction) showInfo:(id)sender;

- (void) playerItemDidReachEnd:(NSNotification *)notification;
- (IBAction) submitCurrentVideo:(id)sender;
- (IBAction) discardCurrentVideo:(id)sender;
- (IBAction) prepareToDrop:(id)sender;
- (IBAction) startRecording:(id)sender;
- (IBAction) cancelRecording:(id)sender; //after time out
- (IBAction) playVideo:(id)sender; //after time out

- (void) overlayReachedPercent:(CGFloat)percentComplete;
- (void) overlayComplete:(NSURL*)assetURL;

- (void) completeSubmit;
- (void) removeSubmitView;
- (void) removeUploadProgressView;
- (void) showUploadProgress;

- (void) textFieldShouldReturn:(UITextField*)field;

//forwards to youtube sender
- (IBAction)login:(id)sender;
- (IBAction)cancelSubmit:(id)sender;


@end

