//
//  NotesCell.h
//  MainHotIdeasKeeper
//
//  Created by Alexandr Kolesnik on 19.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteTextLabel;

@end
