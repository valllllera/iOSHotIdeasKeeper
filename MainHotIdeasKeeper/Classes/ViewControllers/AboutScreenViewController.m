//
//  AboutScreenViewController.m
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "AboutScreenViewController.h"
#import "NVSlideMenuController.h"
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AboutScreenViewController ()
@end

@implementation AboutScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"About";
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
}

- (void)viewDidUnload
{
    [self setSiteLinkBtn:nil];
    [self setWriteUsBtn:nil];
    [super viewDidUnload];
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

- (IBAction)writeUsBtnClicked:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"A Message from Hot Ideas Keeper"];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"info@vexadev.com", nil];
        [mailer setToRecipients:toRecipients];
        NSString *emailBody = @"";
        [mailer setMessageBody:emailBody isHTML:NO];
        [self presentModalViewController:mailer animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)twitButton:(id)sender
{
    if ([TWTweetComposeViewController canSendTweet])
    {
        TWTweetComposeViewController *vc = [[TWTweetComposeViewController alloc] init];
        [vc setInitialText:@"Тут сообщение о том, насколько приложение офигенно, бла-бла-бла."];
        UIImage *image = [UIImage imageNamed:@"v_icon.png"];
        [vc addImage:image];
        NSURL *url = [NSURL URLWithString:@"http://vexadev.com"];
        [vc addURL:url];
        [vc setCompletionHandler:^(TWTweetComposeViewControllerResult result)
        {
            [self dismissModalViewControllerAnimated:YES];
        }];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else
    {
        NSString *message = @"The application cannot send a tweet at the moment. This is because it cannot reach Twitter or you don't have a Twitter account associated with this device.";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)facebookButton:(id)sender {
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}
@end
