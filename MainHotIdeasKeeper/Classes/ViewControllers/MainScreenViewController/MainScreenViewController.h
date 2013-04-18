//
//  MainScreenViewController.h
//  HotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 16.04.13.
//  Copyright (c) 2013 iOS - Eugene Lipskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainScreenViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (IBAction)showCameraController:(id)sender;
- (IBAction)addNoteButtonPressed:(id)sender;
- (IBAction)addPlaceButtonPressed:(id)sender;

@end
