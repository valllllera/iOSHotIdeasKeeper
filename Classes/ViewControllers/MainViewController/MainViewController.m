//
//  MainViewController.m
//  TaskNotifier
//
//  Created by Evgeniy Tka4enko on 12.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "MainViewController.h"
#import "AddNoteViewController.h"
#import "NVSlideMenuController.h"
#import "NotesCell.h"
#import "SQLiteAccess.h"
#import "Remember.h"

@interface MainViewController ()


@property (nonatomic, strong)UIBarButtonItem *leftBarButtonItem;

@end

@implementation MainViewController
@synthesize listTitle;

#pragma mark - View lifecyrcle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Notes";        
                
    }
    _filteredNotes = [[NSMutableArray alloc]init];
    //_notes = [[NSMutableArray alloc]init];
    
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
    [editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:editButton] autorelease];
        
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(19, 29, 50, 31);     [menuButton setTitle:@"" forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu_button.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:menuButton] autorelease];
    
    [menuButton addTarget:self.slideMenuController action:@selector(toggleMenuAnimated:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray* array = [SQLiteAccess selectManyRowsWithSQL:@"select remind from Notes"];
    NSLog(@"%@",array);
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(searchTextFieldTextChanged)
     name:UITextFieldTextDidChangeNotification
     object:_searchTextField];
}

- (void)choise
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_searchTextField release];
    [_searchButton release];
    [_notesTableView release];
    [_customToolbar release];
    [_barButtonItem release];
    [_searchBarMainView release];
    [super dealloc];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_filteredNotes count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"NotesCell";
    
    NotesCell *cell = [_notesTableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NotesCell" owner:nil options:nil] objectAtIndex:0];        
    }
    
    Remember *note;
    
    note = [_filteredNotes objectAtIndex:indexPath.row];
    
    NSString *date = note.date;
    NSString *year = [date substringToIndex:4];
    NSString *date2 = [date substringFromIndex:4];
    NSString *month = [[date2 substringToIndex:3] substringFromIndex:1];
    NSString *day = [date2 substringFromIndex:3];
    
    
    cell.notesDescribeLabel.text = note.description;
    cell.titleLabel.text = note.name;
    
    int minute = [note.min intValue];
    int hours = 0;
    hours = [note.hour intValue];
    
    if (minute < 10)
    {
        if(hours < 10)
        {
            cell.hourLabel.text = [NSString stringWithFormat:@"0%@:0%@",note.hour, note.min];
        }
        else
        {
            cell.hourLabel.text = [NSString stringWithFormat:@"%@:0%@",note.hour, note.min];
        }
    }
    else
    {
        if(hours < 10)
        {
            cell.hourLabel.text = [NSString stringWithFormat:@"0%@:0%@",note.hour, note.min];
        }
        else
        {
            cell.hourLabel.text = [NSString stringWithFormat:@"%@:%@",note.hour, note.min];
        }
    }
    cell.notesDataLabel.text = [NSString stringWithFormat: @"%@.%@.%@", day, month, year];
    cell.activeNote = note;
    

    
    
    if ([note.active integerValue] == 0 )
        cell.chekButton.selected = NO;
    else
        cell.chekButton.selected= YES;
    
    
    int proitiry = [note.prioritet intValue];
    
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
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddNoteViewController *addNoteViewController = [[AddNoteViewController alloc] initWithNote:[_notes objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:addNoteViewController animated:YES];
    [addNoteViewController release];
}

- (IBAction)searchButtonPressed:(id)sender
{
    [self startSearch];
}

- (IBAction)searchTextFieldDonePressed:(id)sender
{
    [self startSearch];
}

- (IBAction)addNoteButton:(id)sender
{
    AddNoteViewController *addNote = [[AddNoteViewController alloc] init];
    [self.navigationController pushViewController:addNote animated:YES];
    [addNote release];
}

- (void)startSearch
{
    [_searchTextField resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[DataManager sharedInstance] getRemembersWithSucces:^(NSArray *notes) {
        
        self.notes = notes;
        [_filteredNotes removeAllObjects];
        [_filteredNotes addObjectsFromArray:_notes];
        [_notesTableView reloadData];
        
    } failture:^(NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error" message:@"Не получилось загрузить данные" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        
    }];
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
         Remember *note = [_notes objectAtIndex:indexPath.row];
        [SQLiteAccess deleteWithSQL:[NSString stringWithFormat: @"delete from Notes where id = %@",note.idx]];
        [_notes removeObject:note];
        if([_filteredNotes containsObject:note])
        {
            [_filteredNotes removeObject:note];
        }
    }
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
}

-(IBAction)editButton:(id)sender
{
    [self.notesTableView setEditing:!self.notesTableView.editing animated:YES];
}

- (void)viewDidUnload {
    [self setSearchBarMainView:nil];
    [super viewDidUnload];
}

- (void)searchTextFieldTextChanged
{
    NSString *keyWord = _searchTextField.text;
    [_filteredNotes removeAllObjects];
    
    if([keyWord length] == 0)
    {
        [_filteredNotes addObjectsFromArray:_notes];
    }
    else
    {    
        for(Remember *note in _notes)
        {
            if([note.name rangeOfString:keyWord].location != NSNotFound)
            {
                [_filteredNotes addObject:note];
            }
        }
    }
    NSLog(@"%@", _filteredNotes);
    [_notesTableView reloadData];
}

@end
