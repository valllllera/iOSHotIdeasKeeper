//
//  MenuViewController.h
//  MenuViewController
//
//  Created by iOS - Evgeniy Lipskiy on 13.03.13.
//  Copyright (c) 2013 iOS - EUgene Lipskiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutViewController.h"

@interface MenuViewController : UIViewController
{
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *aboutButton;
    AboutViewController *aboutViewController;
}

@property (nonatomic, retain) UIViewController *mainViewController;
@property (nonatomic, assign) NSInteger i;

- (IBAction)aboutButtonPressed:(id)sender;
- (IBAction)addClockButtonPressed:(id)sender;
- (IBAction)allAlarmButtonPressed:(id)sender;
- (IBAction)notesPrimaryButtonPressed:(id)sender;
- (IBAction)addNotesButtonPressed:(id)sender;
- (IBAction)vexadevUrlButtonPressed:(id)sender;
- (IBAction)activeButtonPressed:(id)sender;
- (IBAction)primaryNotesAllButtonPressed:(id)sender;



@end
