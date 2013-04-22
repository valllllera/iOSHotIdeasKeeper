//
//  MenuScreenViewController.m
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 17.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "MenuScreenViewController.h"
#import "ViewNotesViewController.h"
#import "MainScreenViewController.h"
#import "NVSlideMenuController.h"
#import "AboutScreenViewController.h"
#import "ViewNoteWithMapController.h"

@interface MenuScreenViewController ()

@end

@implementation MenuScreenViewController

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
  
    _scrollView.contentSize = CGSizeMake(240, 470);
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 40, 40)];
    titleLabel.text = self.navigationItem.title;
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel setFont:[UIFont fontWithName:@"OpenSans-LightItalic" size:25]];
    self.navigationItem.titleView = titleLabel;
    
    [_aboutButton.titleLabel setFont:[UIFont fontWithName:@"OpenSans-LightItalic" size:30]];
    [_mainButton.titleLabel setFont:[UIFont fontWithName:@"OpenSans-LightItalic" size:30]];
    [_notesButton.titleLabel setFont:[UIFont fontWithName:@"OpenSans-LightItalic" size:30]];
    [_geoButton.titleLabel setFont:[UIFont fontWithName:@"OpenSans-LightItalic" size:30]];
    [_libraryLabel setFont:[UIFont fontWithName:@"OpenSans-LightItalic" size:13]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    notesButton = nil;
    mainButton = nil;
    [self setLibraryLabel:nil];
    [self setMainButton:nil];
    [self setNotesButton:nil];
    [self setGeoButton:nil];
    [self setAboutButton:nil];
    [super viewDidUnload];
}
- (IBAction)notesButtonPressed:(id)sender
{
    ViewNotesViewController *viewNotesViewController = [[ViewNotesViewController alloc]init];
    [self.slideMenuController setContentViewController:[[UINavigationController alloc] initWithRootViewController:viewNotesViewController] animated:YES completion:nil];
}

- (IBAction)mainButtonPressed:(id)sender
{
    MainScreenViewController *mainScreenViewController = [[MainScreenViewController alloc]init];
    [self.slideMenuController setContentViewController:[[UINavigationController alloc]initWithRootViewController:mainScreenViewController] animated:YES completion:nil];
}

- (IBAction)aboutUsButtonPressed:(id)sender
{
    AboutScreenViewController *aboutScreenViewController = [[AboutScreenViewController alloc]init];
    [self.slideMenuController setContentViewController:[[UINavigationController alloc]initWithRootViewController:aboutScreenViewController] animated:YES completion:nil];
}

- (IBAction)geoButtonPressed:(id)sender
{
    ViewNoteWithMapController *aboutScreenViewController = [[ViewNoteWithMapController alloc]init];
    [self.slideMenuController setContentViewController:[[UINavigationController alloc]initWithRootViewController:aboutScreenViewController] animated:YES completion:nil];
}

- (IBAction)siteLinkBtnClicked:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://vexadev.com"];
    
    if (![[UIApplication sharedApplication] openURL:url])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to open url"
                                                        message:[url description]
                                                       delegate:nil
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
@end
