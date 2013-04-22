//
//  ViewNoteWithMapController.m
//  MainHotIdeasKeeper
//
//  Created by Alexandr Kolesnik on 22.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "ViewNoteWithMapController.h"

#import "NotesScreenViewController.h"
#import "DataManager.h"
#import "NotesCell.h"
#import "NSString+ExtString.h"
#import "NSDate+ExtDate.h"
#import "NVSlideMenuController.h"
#import "SQLiteAccess.h"

@interface ViewNoteWithMapController ()

@end

@implementation ViewNoteWithMapController

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
    _notesArray = [NSMutableArray array];
    
    UIButton *menuButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu_button_background.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self.slideMenuController action:@selector(toggleMenuAnimated:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuButton];
  }


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
    
    [[DataManager sharedInstance]  getNotesMapWithSucces:^(NSMutableArray *notes) {
         
        self.notesArray = notes;

        [_tableView reloadData];
        
    } failture:^(NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error" message:@"Не получилось загрузить данные" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles: nil];
        [alertView show];
        
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - Table

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NotesCell";
    
    NotesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NotesCell" owner:nil options:nil]objectAtIndex:0];
    }
    Note *noteInArray = [_notesArray objectAtIndex:indexPath.row];
    
    NSLog(@"aas %d",_notesArray.count);
    
    
    cell.noteTextLabel.text = noteInArray.noteText;
    
    cell.dateLabel.text = [noteInArray.date formatStringFromDb];
    
    cell.imageForNote.image = [UIImage imageNamed:@"v_icon.png"];

    
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_notesArray count];
}
@end
