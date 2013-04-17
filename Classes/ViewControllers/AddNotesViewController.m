//
//  AddNotesViewController.m
//  TaskNotifier
//
//  Created by iOS - Evgeniy Lipskiy on 30.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "AddNotesViewController.h"
#import "NotesViewController.h"
#import "DataManager.h"
#import "NVSlideMenuController.h"

@interface AddNotesViewController ()

@end

@implementation AddNotesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.flagView = NO;
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(0, 0, 60, 31);
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveNewNote) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"edit_button_backround.png"] forState:UIControlStateNormal];
    saveButton.titleLabel.textColor = [UIColor blackColor];
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:saveButton] autorelease];
   
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(19, 29, 65, 31);
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.textColor = [UIColor blackColor];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"edit_button_backround.png"] forState:UIControlStateNormal];
     [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:cancelButton] autorelease];
   // self.redButton.selected = YES;
    self.prioritet = 4;
    _noteDesctription.delegate = self;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)buttonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveNewNote
{
    [DataManager saveNewRemember:self.noteName.text description:self.noteDesctription.text proritet:self.prioritet];
}

- (void)dealloc {
    [_noteName release];
    [_noteDesctription release];
    [_redButton release];
    [_yellowButton release];
    [_greenButton release];
    [_greyButton release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setNoteName:nil];
    [self setNoteDesctription:nil];
    [self setRedButton:nil];
    [self setYellowButton:nil];
    [self setGreenButton:nil];
    [self setGreyButton:nil];
    [super viewDidUnload];
}

- (IBAction)redButtonPressed:(id)sender
{
    if (_redButton.selected == NO)
    {
        _yellowButton.selected = NO;
        _greenButton.selected = NO;
        _greyButton.selected = NO;
    }
    _redButton.selected = !_redButton.selected;
    self.prioritet = 4;
}

- (IBAction)yellowButtonPressed:(id)sender
{
    if (_yellowButton.selected == NO)
    {
        _greenButton.selected = NO;
        _greyButton.selected = NO;
        _redButton.selected = NO;
    }
    _yellowButton.selected = !_yellowButton.selected;
    self.prioritet = 3;
}

- (IBAction)greenButtonPressed:(id)sender
{
    if (_greenButton.selected == NO)
    {
        _yellowButton.selected = NO;
        _greyButton.selected = NO;
        _redButton.selected = NO;
    }
    _greenButton.selected = !_greenButton.selected;
    self.prioritet = 2;
}

- (IBAction)greyButtonPressed:(id)sender
{
    if (_greyButton.selected == NO)
    {
        _yellowButton.selected = NO;
        _greenButton.selected = NO;
        _redButton.selected = NO;
    }
    _greyButton.selected = !_greyButton.selected;
    self.prioritet = 1;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
