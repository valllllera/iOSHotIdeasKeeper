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
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
    imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagepicker.delegate = self;
    imagepicker.allowsEditing = NO;
    [self presentModalViewController:imagepicker animated:YES];
}

- (void) imagePickerController:(UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:((UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage]).CGImage
                                 metadata:[info objectForKey:UIImagePickerControllerMediaMetadata]
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              NSLog(@"assetURL %@", assetURL);
                              _imageUrl = assetURL;
                              
                          }];
    _image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImageWriteToSavedPhotosAlbum(_image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    NSLog(@"%@",_image);
    [self dismissModalViewControllerAnimated:YES];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextinfo
{
    UIAlertView *alert;
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                           message:@"Unable to save image to Photo Album." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Succes"
                                           message:@"Image saved to Photo Album." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        AddNoteWithPhotoViewController *addNoteWithPhoto = [[AddNoteWithPhotoViewController alloc]initWithImageUrl:_imageUrl];
        [self.navigationController pushViewController:addNoteWithPhoto animated:YES];
        
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

- (IBAction)showCameraVideoController:(id)sender {
}
@end
