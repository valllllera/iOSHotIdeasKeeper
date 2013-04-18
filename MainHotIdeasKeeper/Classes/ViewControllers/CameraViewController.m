//
//  CameraViewController.m
//  MainHotIdeasKeeper
//
//  Created by Alexandr Kolesnik on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "CameraViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MDCParallaxView.h"

@interface CameraViewController () 

@end

@implementation CameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isPhotoActive = YES;
    
    UIImagePickerController *cameraView = [[UIImagePickerController alloc] init];
    cameraView.sourceType = UIImagePickerControllerSourceTypeCamera;
    cameraView.showsCameraControls = YES;
    cameraView.
    [self presentModalViewController:cameraView animated:YES];
    
    [cameraView viewWillAppear:YES];
    [cameraView viewDidAppear:YES];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"background.png"];
    CGRect backgroundRect = CGRectMake(0, 0, self.view.frame.size.width, backgroundImage.size.height);
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:backgroundRect];
    backgroundImageView.image = backgroundImage;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
//    CGRect textRect = CGRectMake(0, 0, self.view.frame.size.width, 400.0f);
//    UITextView *textView = [[UITextView alloc] initWithFrame:textRect];
//    textView.text = NSLocalizedString(@"Note: ", nil);
//    textView.textAlignment = NSTextAlignmentCenter;
//    textView.font = [UIFont systemFontOfSize:14.0f];
//    textView.textColor = [UIColor darkTextColor];
//    textView.returnKeyType = UIReturnKeyDone;
//    textView.scrollsToTop = NO;
//    textView.editable = YES;
    
    CGRect bgForTextFieldRect = CGRectMake(0, 0, self.view.frame.size.width, 220.0f);
    UIView *bgForTextField = [[UIView alloc] initWithFrame:bgForTextFieldRect];
    bgForTextField.backgroundColor = [UIColor blackColor];
    
    CGRect textEditRect = CGRectMake(0, 0, self.view.frame.size.width, 23.0f);
    UITextField *textView = [[UITextField alloc] initWithFrame:textEditRect];
    textView.backgroundColor = [UIColor blueColor];
    textView.placeholder = @"Your note here...";
    textView.returnKeyType = UIReturnKeyDone;
    textView.clearButtonMode = UITextFieldViewModeWhileEditing;
    textView.delegate = self;
    [bgForTextField addSubview:textView];
    
    MDCParallaxView *parallaxView = [[MDCParallaxView alloc] initWithBackgroundView:backgroundImageView
                                                                     foregroundView:bgForTextField];
    parallaxView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    parallaxView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    parallaxView.backgroundHeight = 197.0f;
    parallaxView.scrollView.scrollsToTop = YES;
    parallaxView.scrollViewDelegate = self;
    [self.view addSubview:parallaxView];    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setCameraScreenView:nil];
    [self setModeButton:nil];
    [super viewDidUnload];
}

#pragma mark - UIScrollViewDelegate Protocol Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%@:%@", [self class], NSStringFromSelector(_cmd));
}

@end
