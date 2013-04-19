//
//  MainScreenViewController.h
//  HotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 16.04.13.
//  Copyright (c) 2013 iOS - Eugene Lipskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainScreenViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImage *image;

- (IBAction)showCameraPhotoController:(id)sender;
- (IBAction)addNoteButtonPressed:(id)sender;
- (IBAction)addPlaceButtonPressed:(id)sender;
- (IBAction)showCameraVideoController:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *addLabel;

@end
