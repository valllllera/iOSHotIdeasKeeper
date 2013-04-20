//
//  NotesScreenViewController.m
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 17.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NotesScreenViewController.h"
#import "DataManager.h"
#import "NVSlideMenuController.h"
#import "Note.h"
#import "ViewNotesViewController.h"

@interface NotesScreenViewController ()

@end

@implementation NotesScreenViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.flagView = NO;
    
    self.notesTextView.delegate = self;
    
    if (_activeNote)
    {
        _flagView = YES;
        self.notesTextView.text = _activeNote.noteText;
    }
    
    UIBarButtonItem *addImageButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(addImageButton:)];
    self.navigationItem.rightBarButtonItem = addImageButton;
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
    [super viewDidUnload];
}
- (IBAction)saveButtonPressed:(id)sender
{
    if (self.flagView == NO)
    {
        Note *note = [[Note alloc]init];
        note.noteText = self.notesTextView.text;
        [DataManager saveNewNote:note];
        ViewNotesViewController *viewNotesViewController = [[ViewNotesViewController alloc]init];
      
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Заметка успешно сохранена" delegate:self cancelButtonTitle:@"Oк" otherButtonTitles: nil];
        [alertView show];
        
          [self.slideMenuController setContentViewController:[[UINavigationController alloc] initWithRootViewController:viewNotesViewController] animated:YES completion:nil];
    }
    else
    {
        _activeNote.noteText = self.notesTextView.text;
        [DataManager updateNewNote:_activeNote];
        
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
