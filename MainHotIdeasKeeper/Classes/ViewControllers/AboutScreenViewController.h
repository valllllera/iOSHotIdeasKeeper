//
//  AboutScreenViewController.h
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutScreenViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *siteLinkBtn;
- (IBAction)siteLinkBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *writeUsBtn;
- (IBAction)writeUsBtnClicked:(id)sender;

@end
