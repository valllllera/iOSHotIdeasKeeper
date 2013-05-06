//
//  AboutScreenViewController.h
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@protocol MFMailComposeViewControllerDelegate <NSObject>

- (IBAction)writeUsBtnClicked:(id)sender;

@end
@interface AboutScreenViewController : UIViewController < UIPageViewControllerDelegate , MFMailComposeViewControllerDelegate >
{
    SLComposeViewController *mySLComposerSheet;
}

@property (weak, nonatomic) IBOutlet UIButton *siteLinkBtn;
- (IBAction)siteLinkBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *writeUsBtn;
- (IBAction)writeUsBtnClicked:(id)sender;

- (IBAction)twitButton:(id)sender;
- (IBAction)facebookButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;

@end
