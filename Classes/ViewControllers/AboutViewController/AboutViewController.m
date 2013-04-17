//
//  AboutViewController.m
//  AboutViewController
//
//  Created by iOS - Evgeniy Lipskiy on 16.03.13.
//  Copyright (c) 2013 iOS - Eugene Lipskiy. All rights reserved.
//

#import "AboutViewController.h"
#import "MenuViewController.h"
#import "NVSlideMenuController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"About";
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 50, 31);
        [button setTitle:@"" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"menu_button.png" ]forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:normal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [writeUsButton release];
    [super dealloc];
}
- (IBAction)writeUsButtonPressed:(id)sender
{

    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"Sent from TaskNotifier"];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"info@vexadev.com", nil];
        [mailer setToRecipients:toRecipients];
        [self presentModalViewController:mailer animated:YES];
        [mailer release];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"E-mail не настроен" delegate:nil cancelButtonTitle:@"Oк" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    
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

- (IBAction)cancelButtonPressed:(id)sender
{
    [self.slideMenuController showMenuAnimated:YES completion:nil];
}
@end
