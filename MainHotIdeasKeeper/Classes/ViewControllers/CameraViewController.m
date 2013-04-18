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

@interface CameraViewController ()

@end

@implementation CameraViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isPhotoActive = YES;
    
    UIImagePickerController *cameraView = [[UIImagePickerController alloc] init];
    cameraView.sourceType = UIImagePickerControllerSourceTypeCamera;
    cameraView.showsCameraControls = NO;
    //[self.cameraScreenView addSubview:cameraView.view];
    [self presentModalViewController:cameraView animated:YES];
    
    [cameraView viewWillAppear:YES];
    [cameraView viewDidAppear:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [self setCameraScreenView:nil];
    [self setModeButton:nil];
    [super viewDidUnload];
}

#pragma mark - Actions
- (IBAction)changeMode:(id)sender
{
    isPhotoActive = !isPhotoActive;

    if (isPhotoActive)
        [_modeButton setBackgroundImage:[UIImage imageNamed:@"camera_photo_button.png"] forState:UIControlStateNormal];
    else
        [_modeButton setBackgroundImage:[UIImage imageNamed:@"camera_video_button.png"] forState:UIControlStateNormal];
}


@end
