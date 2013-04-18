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

    }
    return self;
}

-(id)initWithNote:(Note *)note
{
    self = [super init];
    if (self)
    {
        
    }
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.flagView = NO;
    
    self.notesTextView.delegate = self;
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
        [DataManager saveNewRemember:self.notesTextView.text];
        ViewNotesViewController *viewNotesViewController = [[ViewNotesViewController alloc]init];
        [self.slideMenuController setContentViewController:[[UINavigationController alloc] initWithRootViewController:viewNotesViewController] animated:YES completion:nil];
    }
    else
    {
        [DataManager updateNewRemember:self.notesTextView.text];
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
@end
