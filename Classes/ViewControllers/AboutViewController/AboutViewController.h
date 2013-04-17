//
//  AboutViewController.h
//  AboutViewController
//
//  Created by iOS - Evgeniy Lipskiy on 16.03.13.
//  Copyright (c) 2013 iOS - Eugene Lipskiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
    IBOutlet UIButton *writeUsButton;
    
}
- (IBAction)writeUsButtonPressed:(id)sender;

@end
