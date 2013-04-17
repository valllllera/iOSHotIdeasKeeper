//
//  NotesCell.m
//  TaskNotifier
//
//  Created by Vlad Polupan - iOS on 14.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NotesCell.h"
#import "Remember.h"
#import "SQLiteAccess.h"
@implementation NotesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_backgroundImageView release];
    [_chekButton release];
    [_titleLabel release];
    [_notesDescribeLabel release];
    [_notesDataLabel release];
    [_priorityImage release];
    [_blockImageView release];
    [_hourLabel release];
    [super dealloc];
}


- (IBAction)checkButton:(id)sender
{
    if ([self.activeNote.active integerValue] == 0 )
    {
        self.activeNote.active = @"1";
        NSString *query = [NSString stringWithFormat:@"update Notes set active = %@ where id = %@",self.activeNote.active, self.activeNote.idx];
        [SQLiteAccess updateWithSQL:query];
        NSLog(@"here is update active = 1 ");
        
    }
    else
    {
        self.activeNote.active = @"0";
        NSString *query = [NSString stringWithFormat:@"update Notes set active = %@ where id = %@",self.activeNote.active, self.activeNote.idx];
        [SQLiteAccess updateWithSQL:query];
         NSLog(@"here is update active = 0 ");

    }
    
    _chekButton.selected = !_chekButton.selected;
    
}


- (void)startEdition
{
    _priorityImage.image = [UIImage imageNamed:@""];
    [_chekButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    _blockImageView.hidden = NO;
}


-(void)endEdition
{
    _priorityImage.image = [UIImage imageNamed:@""];
    [_chekButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    _blockImageView.hidden = YES;
}

- (void)setNotePrioriety:(NotePriority)priority
{
    /*switch (priority) {
        case NotePriorityGray:
            _priorityImage.image = [UIImage imageNamed:@"priority_grey"];
            break;
            
        case NotePriorityGreen:
            _priorityImage.image = [UIImage imageNamed:@"priority_green"];
            break;
            
        case NotePriorityYellow:
            _priorityImage.image = [UIImage imageNamed:@"priority_yellow"];

            break;
            
        case NotePriorityRed:
            _priorityImage.image = [UIImage imageNamed:@"priority_red"];

            break;
            
        default:
            break;
    }*/
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
