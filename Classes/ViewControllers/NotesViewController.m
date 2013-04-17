//
//  NotesViewController.m
//  TaskNotifier
//
//  Created by iOS - Evgeniy Lipskiy on 30.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NotesViewController.h"
#import "NVSlideMenuController.h"
#import "AddNotesViewController.h"
#import "Remember.h"
#import "NotesViewCell.h"
#import "NotificationsManager.h"

@interface NotesViewController ()

@end

@implementation NotesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _filteredNotes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(0, 0, 60, 31);
    [editButton setTitle:@"Edit" forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editButton:) forControlEvents:UIControlEventTouchUpInside];
    [editButton setBackgroundImage:[UIImage imageNamed:@"edit_button_backround.png"] forState:UIControlStateNormal];
    editButton.titleLabel.textColor = [UIColor blackColor];
    [editButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:editButton] autorelease];
    
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(19, 29, 50, 31);
    [menuButton setTitle:@"" forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu_button.png"] forState:UIControlStateNormal];
    [menuButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:menuButton] autorelease];
    
    [menuButton addTarget:self.slideMenuController action:@selector(toggleMenuAnimated:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(searchTextFieldTextChanged)
     name:UITextFieldTextDidChangeNotification
     object:_searchTextField];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_filteredNotes count];
}
-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:YES];
    
    [[DataManager sharedInstance]  getNotesWithSucces:^(NSArray *notes)
    {

        self.notesMainArray = notes;
        
        [_filteredNotes removeAllObjects];
        [_filteredNotes addObjectsFromArray:_notesMainArray];
        [_mainNotesTable reloadData];
        
        [[NotificationsManager sharedInstance] sinhronizeNotification:_notesMainArray];
        

        
    } failture:^(NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc]
                                   initWithTitle:@"Error" message:@"Не получилось загрузить данные" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles: nil];
         [alertView show];
         [alertView release];
     }];

}



- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"NotesViewCell";
    
    NotesViewCell *cell = [_mainNotesTable dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NotesViewCell" owner:nil options:nil] objectAtIndex:0];
    }

    Note *remembers = [_notesMainArray objectAtIndex:indexPath.row];
    remembers = [_filteredNotes objectAtIndex:indexPath.row];

    cell.titleLabel.text = remembers.name;
    cell.descriptionLabel.text = remembers.description;
    
    //NSLog(@"%@",remembers.prioritet);
    /*int proitiry = [remembers.prioritet intValue];
    
    switch (proitiry) {
        case 1:
            cell.priorityImage.image = [UIImage imageNamed:@"priority_grey.png"];
            break;
            
        case 2:
            cell.priorityImage.image = [UIImage imageNamed:@"priority_green.png"];
            break;
            
        case 3:
            cell.priorityImage.image = [UIImage imageNamed:@"priority_yellow.png"];
            break;
            
        case 4:
            cell.priorityImage.image = [UIImage imageNamed:@"priority_red.png"];
            break;
            
        default:
            break;
    }*/
    
    return cell;
}



- (void)dealloc {
    [_filteredNotes release];
    [_mainNotesTable release];
    [_searchNotesTextField release];
    [_searchButton release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainNotesTable:nil];
    [self setSearchNotesTextField:nil];
    [self setSearchButton:nil];
    [super viewDidUnload];
}


- (IBAction)addNoteButtonPressed:(id)sender
{
    AddNotesViewController *addNotesViewController = [[AddNotesViewController alloc]init];
    [self.navigationController pushViewController:addNotesViewController animated:YES];
    [addNotesViewController release];
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note *note = [_notesMainArray objectAtIndex:indexPath.row];
       //[SQLiteAccess deleteWithSQL:[NSString stringWithFormat: @"delete from Notes where id = %@",note.idx]];
        [_notesMainArray removeObject:note];
        if([_filteredNotes containsObject:note])
        {
            [_filteredNotes removeObject:note];
        }
    }
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
}


- (void)searchTextFieldTextChanged
{
    NSString *keyWord = _searchTextField.text;
    [_filteredNotes removeAllObjects];
    
    if([keyWord length] == 0)
    {
        [_filteredNotes addObjectsFromArray:_notesMainArray];
    }
    else
    {
        for(Note *remember in _notesMainArray)
        {
            if([remember.name rangeOfString:keyWord].location != NSNotFound)
            {
                [_filteredNotes addObject:remember];
            }
        }
    }
    NSLog(@"%@", _filteredNotes);
    [_mainNotesTable reloadData];
}


-(IBAction)editButton:(id)sender
{
    [self.mainNotesTable setEditing:!self.mainNotesTable.editing animated:YES];
}

@end
