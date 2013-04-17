//
//  PageAlarmClockCell.h
//  View
//
//  Created by Edik Shovkovyi on 14.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICustomSwitch.h"
#import "Clock.h"

@interface PageAlarmClockCell : UITableViewCell
{
    IBOutlet UIImageView *imageBgView;

        
}
- (IBAction)switchButtonPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *nameClockLabel;
@property (retain, nonatomic) IBOutlet UILabel *descriptionClockLabel;
@property (retain, nonatomic) IBOutlet UILabel *monLabel;
@property (retain, nonatomic) IBOutlet UILabel *tueLabel;
@property (retain, nonatomic) IBOutlet UILabel *wedLabel;
@property (retain, nonatomic) IBOutlet UILabel *thuLabel;
@property (retain, nonatomic) IBOutlet UILabel *friLabel;
@property (retain, nonatomic) IBOutlet UILabel *satLabel;
@property (retain, nonatomic) IBOutlet UILabel *sunLabel;
@property (retain, nonatomic) IBOutlet UILabel *minuteLabel;
@property (retain, nonatomic) IBOutlet UILabel *hourLabel;

@property (assign, nonatomic)NSInteger active;

@property (retain, nonatomic) Clock *activeClock;

@property (assign, nonatomic)UITableViewCellStateMask state;

@end
