//
//  NotesViewCell.m
//  TaskNotifier
//
//  Created by iOS - Evgeniy Lipskiy on 31.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NotesViewCell.h"

@implementation NotesViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_titleLabel release];
    [_descriptionLabel release];
    [_priorityImage release];
    [super dealloc];
}

- (void)willTransitionToState:(UITableViewCellStateMask)aState
{
    [super willTransitionToState:aState];
    self.state = aState;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    // no indent in edit mode
    self.contentView.frame = CGRectMake(0,
                                        self.contentView.frame.origin.y,
                                        self.contentView.frame.size.width,
                                        self.contentView.frame.size.height);
    
    if (self.editing )
    {
        NSLog(@"subview");
        float indentPoints = self.indentationLevel * self.indentationWidth;
        
        switch (self.state) {
            case 1:
                self.contentView.frame = CGRectMake(indentPoints,
                                                    self.contentView.frame.origin.y,
                                                    self.contentView.frame.size.width +124,// - indentPoints,
                                                    self.contentView.frame.size.height);
                
                break;
            case 2:
                // swipe action
                self.contentView.frame = CGRectMake(indentPoints,
                                                    self.contentView.frame.origin.y,
                                                    self.contentView.frame.size.width +75,// - indentPoints,
                                                    self.contentView.frame.size.height);
                
                break;
            default:
                // state == 1, hit edit button
                self.contentView.frame = CGRectMake(indentPoints,
                                                    self.contentView.frame.origin.y,
                                                    self.contentView.frame.size.width +80,// - indentPoints,
                                                    self.contentView.frame.size.height);
                break;
        }
    }
}

@end
