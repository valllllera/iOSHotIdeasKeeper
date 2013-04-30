//
//  AddNoteWithPhotoViewController.h
//  MainHotIdeasKeeper
//
//  Created by Alexandr Kolesnik on 20.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface AddNoteWithPhotoViewController :  UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextViewDelegate >
{
    
    __weak IBOutlet UIButton *saveButton;
    UIImage *image;
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
- (IBAction)saveButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *photoForNote;
@property (copy,nonatomic) NSURL* imageUrl;
@property (nonatomic, strong) ALAssetsLibrary *assetLibrary;
@property (nonatomic, strong) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *writeANoteLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

-(id)initWithNote:(Note *)note;
-(id)initWithImageUrl:(NSURL *)imageUrl;

@property(strong,nonatomic) Note *activeNote;

@property (assign,nonatomic) BOOL flagView;

@end
