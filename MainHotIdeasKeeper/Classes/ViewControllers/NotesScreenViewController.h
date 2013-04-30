//
//  NotesScreenViewController.h
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 17.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NotesScreenViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>
{

    __weak IBOutlet UIButton *saveButton;
    UIImage *image;
    
}

@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
- (IBAction)saveButtonPressed:(id)sender;

-(id)initWithNote:(Note *)note;

@property(strong,nonatomic) Note *activeNote;

@property (assign,nonatomic) BOOL flagView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
