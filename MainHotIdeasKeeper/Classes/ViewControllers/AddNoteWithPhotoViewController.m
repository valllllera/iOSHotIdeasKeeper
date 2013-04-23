//
//  AddNoteWithPhotoViewController.m
//  MainHotIdeasKeeper
//
//  Created by Alexandr Kolesnik on 20.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "AddNoteWithPhotoViewController.h"
#import "DataManager.h"
#import "NVSlideMenuController.h"
#import "Note.h"
#import "ViewNotesViewController.h"
#import "Messages.h"

@interface AddNoteWithPhotoViewController ()

@end

@implementation AddNoteWithPhotoViewController
typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Заметки";
    }
    return self;
}

-(id)initWithNote:(Note *)note
{
    self = [super init];
    if (self)
    {
        _activeNote = note;
    }
    return  self;
}

-(id)initWithImageUrl:(NSURL *)imageUrl
{
    self = [super init];
    if (self)
    {
        self.imageUrl = imageUrl;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.assetLibrary = [[ALAssetsLibrary alloc] init];
    self.flagView = NO;
    dispatch_queue_t dispatchQueue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
        [self.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                __block BOOL foundThePhoto = NO;
                if (foundThePhoto) {
                    *stop = YES;
                }
                
                NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                
                if ([assetType isEqualToString:ALAssetTypePhoto]){
                    foundThePhoto = YES;
                    *stop = YES;
                    ALAssetRepresentation *assetRepresentation = [result defaultRepresentation];
                    CGFloat imageScale = [assetRepresentation scale];
                    UIImageOrientation imageOrientation = (UIImageOrientation)[assetRepresentation orientation];
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        CGImageRef imageReference = [assetRepresentation fullResolutionImage];
                        UIImage *image1 = [[UIImage alloc] initWithCGImage:imageReference scale:imageScale orientation:imageOrientation];
                        if (image != nil) {
                            self.photoForNote.contentMode = UIViewContentModeScaleAspectFit;
                            [self.photoForNote setImage:image1];
                           // [self.view addSubview:self.photoForNote];
                        } else
                        {
                            NSLog(@"Failed to create the image");
                        }
                        NSDictionary *assertUrls = [result valueForProperty:ALAssetPropertyURLs];
                        [assertUrls setValue:_imageUrl forKey:@"assertKey"];
                
                        NSInteger assetCounter = 0;
                        for (NSString *assertKey in assertUrls)
                        {
                            assetCounter++;
                            NSLog(@"Assert URL %lu = %@", (unsigned long)assetCounter, [assertUrls valueForKey:assertKey]);
                        }
                    });
                }
                                                                }];
        } failureBlock:^(NSError *error) {
            NSLog(@"Failed to rnumerate the asset group");
        }];
                                   
                                   });
    self.notesTextView.delegate = self;
    
    if (_imageUrl)
    {
        NSData *imageDate = [NSData dataWithContentsOfURL:_imageUrl];
        self.photoForNote.image = [UIImage imageWithData:imageDate];
        NSLog(@"asd");
    }
    
    if (_activeNote)
    {
        _flagView = YES;
        self.notesTextView.text = _activeNote.noteText;
    }
    

    
    UIBarButtonItem *addImageButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(addImageButton:)];
    self.navigationItem.rightBarButtonItem = addImageButton;
}

-(UIImage *)imageWithContentsOfFile:(NSString *)path
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNotesTextView:nil];
    saveButton = nil;
    saveButton = nil;
    self.assetLibrary = nil;
    self.imageView = nil;
    [self setPhotoForNote:nil];
    [super viewDidUnload];
}
- (IBAction)saveButtonPressed:(id)sender
{
    if (self.flagView == NO)
    {
        Note *note = [[Note alloc]init];
        note.noteText = self.notesTextView.text;
    
        [[DataManager sharedInstance] saveNewNote:note];
        ViewNotesViewController *viewNotesViewController = [[ViewNotesViewController alloc]init];
        
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:[Messages noteSuccssesfullSaved] delegate:self cancelButtonTitle:@"Oк" otherButtonTitles: nil];
        [alertView show];
        
        [self.slideMenuController setContentViewController:[[UINavigationController alloc] initWithRootViewController:viewNotesViewController] animated:YES completion:nil];
    }
    else
    {
        _activeNote.noteText = self.notesTextView.text;
        [[DataManager sharedInstance] updateNewNote:_activeNote];
        
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(IBAction)addImageButton:(id)sender
{
    NSDictionary *info = [[NSDictionary alloc]init];
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self dismissModalViewControllerAnimated:YES];
}


@end
