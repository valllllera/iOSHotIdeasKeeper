//
//  AddNoteWithPhotoViewController.h
//  MainHotIdeasKeeper
//
//  Created by Alexandr Kolesnik on 20.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface AddNoteWithPhotoViewController :  UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate>
{
    
    __weak IBOutlet UIButton *saveButton;
    UIImage *image;
    
}

@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
- (IBAction)saveButtonPressed:(id)sender;

-(id)initWithNote:(Note *)note;

@property(strong,nonatomic) Note *activeNote;

@property (assign,nonatomic) BOOL flagView;

@end
