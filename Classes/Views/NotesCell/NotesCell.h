//
//  NotesCell.h
//  TaskNotifier
//
//  Created by Vlad Polupan - iOS on 14.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Remember.h"

typedef enum
{
    NotePriorityGray = 1,
    NotePriorityGreen,
    NotePriorityYellow,
    NotePriorityRed
} NotePriority;

@interface NotesCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (retain, nonatomic) IBOutlet UIButton *chekButton;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *notesDescribeLabel;
@property (retain, nonatomic) IBOutlet UILabel *notesDataLabel;

@property (retain, nonatomic) IBOutlet UIImageView *priorityImage;
- (IBAction)checkButton:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *blockImageView;

@property (retain, nonatomic) IBOutlet UILabel *hourLabel;
- (void)setNotePrioriety:(NotePriority)priority;

@property (retain, nonatomic) Remember *activeNote;

@property (assign, nonatomic) UITableViewCellStateMask state;

@end
