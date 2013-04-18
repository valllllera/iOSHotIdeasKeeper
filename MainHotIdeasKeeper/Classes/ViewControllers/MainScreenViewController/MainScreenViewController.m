//
//  MainScreenViewController.m
//  HotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 16.04.13.
//  Copyright (c) 2013 iOS - Eugene Lipskiy. All rights reserved.
//

#import "MainScreenViewController.h"
#import "CameraScreenViewController.h"
#import "NotesScreenViewController.h"
#import "NVSlideMenuController.h"
#import "AddPlaceOnMapViewController.h"

@interface MainScreenViewController ()

@end

@implementation MainScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Hot Ideas Keeper";
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *menuButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu_button_background.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self.slideMenuController action:@selector(toggleMenuAnimated:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
- (IBAction)showCameraController:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController:picker animated:YES];
}

- (IBAction)addNoteButtonPressed:(id)sender
{
    NotesScreenViewController *notesScreenViewController = [[NotesScreenViewController alloc]init];
    [self.navigationController pushViewController:notesScreenViewController animated:YES];
}

- (IBAction)addPlaceButtonPressed:(id)sender
{
    AddPlaceOnMapViewController *addPlaceOnMapViewController = [[AddPlaceOnMapViewController alloc]init];
    [self. navigationController pushViewController:addPlaceOnMapViewController animated:YES];
}
@end
