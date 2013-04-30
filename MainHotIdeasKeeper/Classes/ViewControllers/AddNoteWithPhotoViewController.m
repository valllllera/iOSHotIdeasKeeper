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
@synthesize saveButton;
typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Заметки", nil);
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
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
            UIImage *largeimage = [UIImage imageWithCGImage:iref];
            _photoForNote.image = largeimage;
        }
    };
    
    UIBarButtonItem *homeNaviButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"home_navi_button_bg.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(homeNaviButton:)];
    [homeNaviButton setBackgroundImage:[UIImage imageNamed:@"button_item_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = homeNaviButton;

    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"booya, cant get image - %@",[myerror localizedDescription]);
    };
    
    if(_imageUrl)
    {
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:_imageUrl
                       resultBlock:resultblock
                      failureBlock:failureblock];
    }
    
    
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
        
        ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
        {
            ALAssetRepresentation *rep = [myasset defaultRepresentation];
            CGImageRef iref = [rep fullResolutionImage];
            if (iref) {
                UIImage *largeimage = [UIImage imageWithCGImage:iref];
                self.photoForNote.image = largeimage;
            }
            else
                self.photoForNote.image  = [UIImage imageNamed:@"v_icon.png"];
        };
        
        
        ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
        {
            NSLog(@"booya, cant get image - %@",[myerror localizedDescription]);
        };
        
        if(_activeNote.imageUrlPath)
        {
            NSURL *imageUrl = [NSURL URLWithString:_activeNote.imageUrlPath];
            ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
            [assetslibrary assetForURL: imageUrl
                           resultBlock:resultblock
                          failureBlock:failureblock];
        }
    }
    

    
    UIBarButtonItem *addImageButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(addImageButton:)];
    [addImageButton setBackgroundImage:[UIImage imageNamed:@"button_item_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    self.navigationItem.rightBarButtonItem = addImageButton;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    _scrollView.contentSize = CGSizeMake(320, 408);
}


- (void)keyboardWasShown:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, _notesTextView.frame.origin) )
    {
        CGPoint scrollPoint = CGPointMake(0.0, _notesTextView.frame.origin.y - (keyboardSize.height-15));
        [_scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void) keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
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
    [self setWriteANoteLabel:nil];
    [self setSaveButton:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}
- (IBAction)saveButtonPressed:(id)sender
{
    if (self.flagView == NO)
    {
        Note *note = [[Note alloc]init];
        note.noteText = self.notesTextView.text;
        note.imageUrlPath = [_imageUrl absoluteString];
    
        [[DataManager sharedInstance] saveNewNote:note];
        ViewNotesViewController *viewNotesViewController = [[ViewNotesViewController alloc]init];
        
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:[Messages noteSuccssesfullSaved] delegate:self cancelButtonTitle:@"Oк" otherButtonTitles: nil];
        [alertView show];
        
        [self.slideMenuController setContentViewController:[[UINavigationController alloc] initWithRootViewController:viewNotesViewController] animated:YES completion:nil];
    }
    else
    {
        _activeNote.noteText = self.notesTextView.text;
        _activeNote.imageUrlPath = [_imageUrl absoluteString];
        [[DataManager sharedInstance] updateNewNote:_activeNote];
         ViewNotesViewController *viewNotesViewController = [[ViewNotesViewController alloc]init];        
        [self.slideMenuController setContentViewController:[[UINavigationController alloc] initWithRootViewController:viewNotesViewController] animated:YES completion:nil];
        
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

-(IBAction)homeNaviButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
