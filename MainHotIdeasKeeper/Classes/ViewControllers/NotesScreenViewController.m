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
#import "MainScreenViewController.h"
#import "CameraScreenViewController.h"

@interface NotesScreenViewController ()

@end

@implementation NotesScreenViewController

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
    [addImageButton setBackgroundImage:[UIImage imageNamed:@"button_item_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.rightBarButtonItem = addImageButton;
    
    UIBarButtonItem *homeNaviButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"home_navi_button_bg.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(homeNaviButton:)];
    [homeNaviButton setBackgroundImage:[UIImage imageNamed:@"button_item_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = homeNaviButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    _scrollView.contentSize = CGSizeMake(320, 408);
    
    self.slideMenuController.panGestureEnabled = NO;
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

- (void)viewDidUnload
{
    [self setNotesTextView:nil];
    saveButton = nil;
    saveButton = nil;
    [self setScrollView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)saveButtonPressed:(id)sender
{
    if (self.flagView == NO)
    {
        Note *note = [[Note alloc]init];
        note.noteText = self.notesTextView.text;
        note.imageUrlPath = @"nil";
        
        if (_notesTextView.text.length > 1)
        {
            [[DataManager sharedInstance] saveNewNote:note];
      
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Заметка успешно    сохранена" delegate:self cancelButtonTitle:@"Oк" otherButtonTitles: nil];
            [alertView show];
            
            ViewNotesViewController *viewNotesViewController = [[ViewNotesViewController alloc]init];
            [self.slideMenuController setContentViewController:[[UINavigationController alloc] initWithRootViewController:viewNotesViewController] animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Нельзя сохранить пустую заметку" delegate:self cancelButtonTitle:@"Oк" otherButtonTitles: nil];
            [alertView show];
        }

    }
    else
    {
        _activeNote.noteText = self.notesTextView.text;
        [[DataManager sharedInstance] updateNewNote:_activeNote];
        
        ViewNotesViewController *viewNotesViewController = [[ViewNotesViewController alloc]init];
        [self.slideMenuController setContentViewController:[[UINavigationController alloc] initWithRootViewController:viewNotesViewController] animated:YES completion:nil];
    }
    
}

/*- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
}
    return YES;
}*/

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
