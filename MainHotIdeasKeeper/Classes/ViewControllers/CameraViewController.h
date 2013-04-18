//
//  CameraViewController.h
//  MainHotIdeasKeeper
//
//  Created by Alexandr Kolesnik on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController
{
    BOOL isPhotoActive;
}
@property (weak, nonatomic) IBOutlet UIView *cameraScreenView;
@property (weak, nonatomic) IBOutlet UIButton *modeButton;


- (IBAction)changeMode:(id)sender;

@end
