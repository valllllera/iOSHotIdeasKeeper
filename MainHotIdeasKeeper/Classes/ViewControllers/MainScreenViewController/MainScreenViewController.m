//
//  MainScreenViewController.m
//  HotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 16.04.13.
//  Copyright (c) 2013 iOS - Eugene Lipskiy. All rights reserved.
//

#import "MainScreenViewController.h"
#import "CameraScreenViewController.h"
#import "NotesScreenViewController.h"
#import "NVSlideMenuController.h"
#import "AddPlaceOnMapViewController.h"
#import "AddNoteWithPhotoViewController.h"

@interface MainScreenViewController ()

@end

@implementation MainScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Hot Ideas Keeper";
        [self.addLabel setText:NSLocalizedString(@"Добавить", nil)];
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"asd");
    isChoosen = NO;
    
    UIButton *menuButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu_button_background.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self.slideMenuController action:@selector(toggleMenuAnimated:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuButton];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 40, 40)];
    titleLabel.text = self.navigationItem.title;
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel setFont:[UIFont fontWithName:@"OpenSans-LightItalic" size:25]];
    self.navigationItem.titleView = titleLabel;
    
    [_addLabel setFont:[UIFont fontWithName:@"OpenSans-LightItalic" size:25]];
    [_photoButton.titleLabel setFont:[UIFont fontWithName:@"OpenSans-LightItalic" size:30]];
    [_notesButton.titleLabel setFont:[UIFont fontWithName:@"OpenSans-LightItalic" size:30]];
    [_videoButton.titleLabel setFont:[UIFont fontWithName:@"OpenSans-LightItalic" size:30]];
    [_mapButton.titleLabel setFont:[UIFont fontWithName:@"OpenSans-LightItalic" size:30]];
    
    self.slideMenuController.panGestureEnabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setAddLabel:nil];
    [self setPhotoButton:nil];
    [self setNotesButton:nil];
    [self setVideoButton:nil];
    [self setMapButton:nil];
    [self setMapButton:nil];
    [super viewDidUnload];
}

- (IBAction)showCameraPhotoController:(id)sender
{
    imagePick = [[UIImagePickerController alloc] init];
    [imagePick setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePick setDelegate:self];
    button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 35, 35)];
    
    [button setBackgroundImage:[UIImage imageNamed:@"menu_button_background.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(gotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
    
    [imagePick.view addSubview:button];
    
    [self presentViewController:imagePick animated:YES completion:nil];
    NSLog(@"asd");
}

-(void)gotoLibrary:(id)sender
{
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    
	if((UIButton *) sender == button) {
		picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	} else {
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	}
    isChoosen = YES;
	[self.presentedViewController presentModalViewController:picker animated:YES];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissModalViewControllerAnimated:YES];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    if (picker.cameraCaptureMode == UIImagePickerControllerCameraCaptureModePhoto)
    {
        
 
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:((UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage]).CGImage
                                 metadata:[info objectForKey:UIImagePickerControllerMediaMetadata]
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              NSLog(@"assetURL %@", assetURL);
                              self.imageUrl = assetURL;
                               NSLog(@"assetURL %@", _imageUrl);
                               AddNoteWithPhotoViewController *addNoteWithPhoto = [[AddNoteWithPhotoViewController alloc]initWithImageUrl:_imageUrl];
                              [self.navigationController pushViewController:addNoteWithPhoto animated:YES];
                              
                          }];
    _image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if (!isChoosen)
        {
            UIImageWriteToSavedPhotosAlbum(_image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    NSLog(@"imgage%@",_image);
    
    
    }
    else
    {
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if([mediaType isEqualToString:(NSString *)kUTTypeMovie])
        {
            NSURL *movieUrl = [info objectForKey:UIImagePickerControllerMediaURL];
            UISaveVideoAtPathToSavedPhotosAlbum([movieUrl relativePath], self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
            NSLog(@"URL of video - %@", movieUrl);
            NSError *dataReadingError = nil;
            NSData *videoData = [NSData dataWithContentsOfURL:movieUrl options:NSDataReadingMapped error:&dataReadingError];
            if (videoData != nil)
            {
                NSLog(@"Successfully loaded the data.");
            }
            else
            {
                NSLog(@"Failed to load the data with error = %@", dataReadingError);
            }
        }
          [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextinfo
{
    UIAlertView *alert;
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                           message:@"Unable to save to Photo Album." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Succes"
                                           message:@"Saved to Photo Album." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        NSLog(@"%@",_imageUrl);
       
        
        
    }
    [alert show];
}

- (IBAction)addNoteButtonPressed:(id)sender
{
    NotesScreenViewController *notesScreenViewController = [[NotesScreenViewController alloc]init];
    [self.navigationController pushViewController:notesScreenViewController animated:YES];
}

- (IBAction)addPlaceButtonPressed:(id)sender
{
    AddPlaceOnMapViewController *addPlaceOnMapViewController = [[AddPlaceOnMapViewController alloc]init];
    [self. navigationController pushViewController:addPlaceOnMapViewController animated:YES];
}

- (IBAction)showCameraVideoController:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = @[(NSString *)kUTTypeMovie];

    [self presentModalViewController:picker animated:YES];
    NSLog(@"aaa");
}

- (void)viewDidSlideIn:(BOOL)animated inSlideMenuController:(NVSlideMenuController *)slideMenuController
{
    _photoButton.userInteractionEnabled = YES;
    _videoButton.userInteractionEnabled = YES;
}

- (void)viewDidSlideOut:(BOOL)animated inSlideMenuController:(NVSlideMenuController *)slideMenuController
{
    _photoButton.userInteractionEnabled = NO;
    _videoButton.userInteractionEnabled = NO;
}

- (void) makeUIImagePickerControllerForCamera:(BOOL)camera
{


    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if (camera) {
        NSLog(@"!!! Show camera");
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    [picker setMediaTypes:[NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil]];
    
    [self presentModalViewController: picker animated: YES];


}

@end
