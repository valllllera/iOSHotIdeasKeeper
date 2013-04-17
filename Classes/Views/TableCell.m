//
//  TableCell.m
//  TaskNotifier
//
//  Created by Vlad Polupan - iOS on 25.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _cellBackground.image = [UIImage imageNamed:@"custom_row"];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_cellBackground release];

    [super dealloc];
}
@end
