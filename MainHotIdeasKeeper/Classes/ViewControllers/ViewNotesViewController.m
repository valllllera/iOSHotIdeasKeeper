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
    
    [[DataManager sharedInstance]  getNotesWithSucces:^(NSArray *notes)
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 70;
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
    noteInArray.idx = [NSNumber numberWithInteger: indexPath.row +1];
    NSLog(@"%@", noteInArray.date );
    

    cell.noteTextLabel.text = noteInArray.noteText;
    
    NSDate *date =noteInArray.date;
    
    cell.dateLabel.text = [date formatStringFromDb];
    return cell;
}

@end
