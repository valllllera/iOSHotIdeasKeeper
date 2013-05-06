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
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface AboutScreenViewController ()
@end

@implementation AboutScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"О нас", nil);
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
    
    [self fixButton:_writeUsBtn];
    [self fixButton:_fbButton];
    [self fixButton:_twitterButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setSiteLinkBtn:nil];
    [self setWriteUsBtn:nil];
    [self setTwitterButton:nil];
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
        [mailer setSubject:@"Hot Ideas Keeper"];
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
        [vc setInitialText:@"I'm really enjoying Hot Ideas Keeper for iPhone. Save and enjoy all your Remembers!. http://bit.ly/11SsWdK"];
        UIImage *image = [UIImage imageNamed:@"icon.png"];
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

- (IBAction)facebookButton:(id)sender
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) //check if Facebook Account is linked
    {
        mySLComposerSheet = [[SLComposeViewController alloc] init]; //initiate the Social Controller
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; //Tell him with what social plattform to use it, e.g. facebook or twitter
        [mySLComposerSheet setInitialText:[NSString stringWithFormat:@"I'm really enjoying Hot Ideas Keeper for iPhone. Save and enjoy all your Remembers!. http://bit.ly/11SsWdK"]];
        [mySLComposerSheet addImage:[UIImage imageNamed:@"icon.png"]];
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successfull";
                break;
            default:
                break;
        } //check if everythink worked properly. Give out a message on the state.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];
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

- (void)fixButton:(UIButton *)button
{
    [button setBackgroundImage:[[button backgroundImageForState:UIControlStateNormal] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 15, 20, 15)] forState:UIControlStateNormal];
    [button setBackgroundImage:[[button backgroundImageForState:UIControlStateHighlighted] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 15, 20, 15)] forState:UIControlStateHighlighted];
}


@end
