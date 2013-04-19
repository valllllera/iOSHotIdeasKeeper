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
    

    cell.noteTextLabel.text = noteInArray.noteText;
    
    
    NSString *month ;
    NSLog(@"%@",noteInArray.month);
    if ([noteInArray.month intValue] < 10 )
        month = [NSString stringWithFormat:@"0%d",[noteInArray.month intValue]];
    else
         month = [NSString stringWithFormat:@"%d",[noteInArray.month intValue]];
    
    NSString *day ;
    if ([noteInArray.day intValue] < 10 )
        month = [NSString stringWithFormat:@"0%d",[noteInArray.day intValue]];
    else
        month = [NSString stringWithFormat:@"%d",[noteInArray.day intValue]];
    
    NSString *hour ;
    if ([noteInArray.hour intValue] < 10 )
        month = [NSString stringWithFormat:@"0%d",[noteInArray.hour intValue]];
    else
        month = [NSString stringWithFormat:@"%d",[noteInArray.hour intValue]];
    
    NSString *min ;
    if ([noteInArray.min intValue] < 10 )
        month = [NSString stringWithFormat:@"0%d",[noteInArray.min intValue]];
    else
        month = [NSString stringWithFormat:@"%d",[noteInArray.min intValue]];
        
    cell.dateLabel.text = [NSString stringWithFormat:@"%@.%@.%@     %@:%@",noteInArray.year ,month,day,hour,min];
    
    
    return cell;
}

@end
