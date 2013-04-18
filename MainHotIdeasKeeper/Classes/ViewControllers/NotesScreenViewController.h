//
//  NotesScreenViewController.h
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 17.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NotesScreenViewController : UIViewController <UITextFieldDelegate>
{

    __weak IBOutlet UIButton *saveButton;
    
}

@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
- (IBAction)saveButtonPressed:(id)sender;

-(id)initWithNote:(Note *)note;

@property (assign,nonatomic) BOOL flagView;

@end
