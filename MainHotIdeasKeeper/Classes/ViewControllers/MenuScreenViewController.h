//
//  MenuScreenViewController.h
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 17.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuScreenViewController : UIViewController
{
    __weak IBOutlet UIButton *notesButton;
    __weak IBOutlet UIButton *mainButton;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)notesButtonPressed:(id)sender;
- (IBAction)mainButtonPressed:(id)sender;
- (IBAction)aboutUsButtonPressed:(id)sender;
- (IBAction)geoButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *siteLinkBtn;
- (IBAction)siteLinkBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;
@property (weak, nonatomic) IBOutlet UILabel *libraryLabel;
@property (weak, nonatomic) IBOutlet UIButton *mainButton;
@property (weak, nonatomic) IBOutlet UIButton *notesButton;
@property (weak, nonatomic) IBOutlet UIButton *geoButton;

@end
