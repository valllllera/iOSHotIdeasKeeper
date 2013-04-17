//
//  NotesViewCell.h
//  TaskNotifier
//
//  Created by iOS - Evgeniy Lipskiy on 31.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (retain, nonatomic) IBOutlet UIImageView *priorityImage;

@property (assign, nonatomic) UITableViewCellStateMask state;

@end
