//
//  MenuViewController.m
//  MenuViewController
//
//  Created by iOS - Evgeniy Lipskiy on 13.03.13.
//  Copyright (c) 2013 iOS - EUgene Lipskiy. All rights reserved.
//

#import "NVSlideMenuController.h"
#import "MenuViewController.h"
#import "AddClockViewController.h"
#import "PageAlarmClockViewController.h"
#import "AddNoteViewController.h"
#import "MainViewController.h"
#import "NotesViewController.h"
#import "AddNotesViewController.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView.contentSize = CGSizeMake(254, 520);
    _i = 0;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [scrollView release];
    [aboutButton release];
    [super dealloc];
}


- (IBAction)aboutButtonPressed:(id)sender
{
    if(!aboutViewController)
    {
        aboutViewController = [[AboutViewController alloc] init];
    }
    if([_mainViewController.navigationController.viewControllers objectAtIndex:[_mainViewController.navigationController.viewControllers count] - 1] != aboutViewController)
    {
        [self.slideMenuController setContentViewController:[[[UINavigationController alloc] initWithRootViewController:aboutViewController] autorelease] animated:YES completion:nil];
    }
    [self.slideMenuController showContentViewControllerAnimated:YES completion:nil];
}

- (IBAction)addClockButtonPressed:(id)sender
{
    AddClockViewController *addClockViewController = [[AddClockViewController alloc]init];
    addClockViewController.value = 1;
    [self.slideMenuController setContentViewController:[[[UINavigationController alloc] initWithRootViewController:addClockViewController] autorelease] animated:YES completion:nil];

}

- (IBAction)allAlarmButtonPressed:(id)sender
{
    PageAlarmClockViewController *pageAlarmClockViewController = [[PageAlarmClockViewController alloc]init];
    [self.slideMenuController setContentViewController:[[[UINavigationController alloc] initWithRootViewController:pageAlarmClockViewController] autorelease] animated:YES completion:nil];
}

- (IBAction)notesPrimaryButtonPressed:(id)sender
{
    MainViewController *mainViewController = [[MainViewController alloc]init];
    [DataManager initWithActiveNote:0];
    [self.slideMenuController setContentViewController:[[[UINavigationController alloc] initWithRootViewController:mainViewController] autorelease] animated:YES completion:nil];
}

- (IBAction)addNotesButtonPressed:(id)sender
{
    AddNotesViewController *addNotesViewController = [[AddNotesViewController alloc]init];
    [self.slideMenuController setContentViewController:[[[UINavigationController alloc] initWithRootViewController:addNotesViewController] autorelease] animated:YES completion:nil];

}

- (IBAction)vexadevUrlButtonPressed:(id)sender
{
    NSString *stringURL = @"http://vexadev.com";
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)activeButtonPressed:(id)sender
{
    MainViewController *mainViewController = [[MainViewController alloc]init];
    [DataManager initWithActiveNote:1];
    [self.slideMenuController setContentViewController:[[[UINavigationController alloc] initWithRootViewController:mainViewController] autorelease] animated:YES completion:nil];
}

- (IBAction)primaryNotesAllButtonPressed:(id)sender
{
    NotesViewController *notesViewController = [[NotesViewController alloc]init];
    [self.slideMenuController setContentViewController:[[[UINavigationController alloc] initWithRootViewController:notesViewController] autorelease] animated:YES completion:nil];
}


- (void)viewDidUnload
{
    [aboutButton release];
    aboutButton = nil;
    [super viewDidUnload];
}
@end
