//
//  NotesViewController.h
//  TaskNotifier
//
//  Created by iOS - Evgeniy Lipskiy on 30.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NotesViewController : UIViewController <UITableViewDelegate , UITableViewDataSource>

@property (retain, nonatomic) NSMutableArray *notesMainArray;
@property (retain, nonatomic) IBOutlet UITableView *mainNotesTable;
@property (retain, nonatomic) IBOutlet UITextField *searchNotesTextField;
@property (retain, nonatomic) IBOutlet UIButton *searchButton;
@property (retain, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong,nonatomic) NSMutableArray *filteredNotes;

@property (retain,nonatomic) Note * note;

- (IBAction)addNoteButtonPressed:(id)sender;

@end
