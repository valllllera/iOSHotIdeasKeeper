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
@end
