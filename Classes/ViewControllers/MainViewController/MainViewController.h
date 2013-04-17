//
//  MainViewController.h
//  TaskNotifier
//
//  Created by Evgeniy Tka4enko on 12.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotesCell.h"

@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITabBarDelegate,UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSString *listTitle;
    NSMutableArray *mainTableArray;
    
}

@property (retain, nonatomic) IBOutlet UISearchBar *searchBarMainView;
@property (nonatomic, retain) NSMutableArray *notes;
@property (retain, nonatomic) IBOutlet UITextField *searchTextField;
@property (retain, nonatomic) IBOutlet UIButton *searchButton;
@property (retain, nonatomic) IBOutlet UITableView *notesTableView;
@property (retain, nonatomic) IBOutlet UIToolbar *customToolbar;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *barButtonItem;
@property (strong,nonatomic) NSMutableArray *filteredNotes;
@property (copy, nonatomic)NSString *listTitle;
- (IBAction)searchButtonPressed:(id)sender;
- (IBAction)searchTextFieldDonePressed:(id)sender;
- (IBAction)addNoteButton:(id)sender;

@property (nonatomic,assign)NSString *idd;


@end
