//
//  PageAlarmClockViewController.h
//  View
//
//  Created by Edik Shovkovyi on 14.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Clock.h"

@interface PageAlarmClockViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
   // IBOutlet UITableView *alarmClockTableView;
    NSMutableArray *alarmClock;
    IBOutlet UIButton *lupaButton;
    IBOutlet UITextField *searchTextField;
    
}
- (IBAction)lupaButtonPressed:(id)sender;
- (IBAction)searchTextFieldPressed:(id)sender;
- (IBAction)addButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;

@property (nonatomic, retain) NSMutableArray *clocks;
@property (retain, nonatomic) IBOutlet UIToolbar *addToolbar;
@property (retain, nonatomic) UIViewController *addClockView;
@property (retain,nonatomic) IBOutlet UITableView *alarmClockTableView;
@property (retain, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong,nonatomic) NSMutableArray *filteredNotes;


@property (retain, nonatomic) Clock *activeClock;


@end
