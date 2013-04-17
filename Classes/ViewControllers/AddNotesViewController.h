//
//  AddNotesViewController.h
//  TaskNotifier
//
//  Created by iOS - Evgeniy Lipskiy on 30.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNotesViewController : UIViewController <UITextViewDelegate>
@property (retain, nonatomic) IBOutlet UITextField *noteName;
@property (retain, nonatomic) IBOutlet UITextView *noteDesctription;
@property (retain, nonatomic) IBOutlet UIButton *redButton;
@property (retain, nonatomic) IBOutlet UIButton *yellowButton;
@property (retain, nonatomic) IBOutlet UIButton *greenButton;

@property (retain, nonatomic) IBOutlet UIButton *greyButton;

@property (assign,nonatomic) NSInteger prioritet;
@property (assign,nonatomic) BOOL flagView;


- (IBAction)redButtonPressed:(id)sender;
- (IBAction)yellowButtonPressed:(id)sender;
- (IBAction)greenButtonPressed:(id)sender;
- (IBAction)greyButtonPressed:(id)sender;

@end
