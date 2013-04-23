//
//  ViewNotesViewController.m
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "ViewNotesViewController.h"
#import "NotesScreenViewController.h"
#import "DataManager.h"
#import "NotesCell.h"
#import "NSString+ExtString.h"
#import "NSDate+ExtDate.h"
#import "NVSlideMenuController.h"

@interface ViewNotesViewController ()

@end

@implementation ViewNotesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIButton *menuButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu_button_background.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self.slideMenuController action:@selector(toggleMenuAnimated:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuButton];
    UIBarButtonItem *edit =[[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                            target:self
                            action:@selector(editing)];
    [edit setBackgroundImage:[UIImage imageNamed:@"button_item_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.rightBarButtonItem = edit;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMainNotesTable:nil];
    [super viewDidUnload];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_notesArray count];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    
    [[DataManager sharedInstance]  getNotesWithSucces:^(NSMutableArray *notes)
     {
         
         self.notesArray = notes;

         
         [_mainNotesTable reloadData];
         
     }
         failture:^(NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc]
                                   initWithTitle:@"Error" message:@"Не получилось загрузить данные" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles: nil];
         [alertView show];
     }];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotesScreenViewController *notesScreenViewController = [[NotesScreenViewController alloc]initWithNote:[_notesArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:notesScreenViewController animated:YES];
    
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_notesArray removeObjectAtIndex:indexPath.row];
        [[DataManager sharedInstance] deleteNote:indexPath.row+1];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (void)editing {
    [self.mainNotesTable setEditing:!self.mainNotesTable.editing animated:YES];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 94;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NotesCell";
    
    NotesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NotesCell" owner:nil options:nil]objectAtIndex:0];
    }
    Note *noteInArray = [_notesArray objectAtIndex:indexPath.row];

    

    cell.noteTextLabel.text = noteInArray.noteText;

    cell.dateLabel.text = [noteInArray.date formatStringFromDb];
    
    if ([noteInArray.imageUrlPath isEqualToString:@"nil"])
    {
        cell.imageForNote.image = [UIImage imageNamed:@"v_icon.png"];
    }
    else
    {
        NSURL *imageUrl = [NSURL URLWithString:noteInArray.imageUrlPath];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        cell.imageForNote.image = [UIImage imageWithData:imageData];
    }
    
    
    return cell;
}

@end
