//
//  NotesCell.h
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesCell : UITableViewCell
{
    
    __weak IBOutlet UILabel *noteLabel;
}
@property (retain, nonatomic) IBOutlet UILabel *noteLabel;

@end
