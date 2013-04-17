//
//  PageAlarmClockViewController.m
//  View
//
//  Created by Edik Shovkovyi on 14.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "PageAlarmClockViewController.h"
#import "PageAlarmClockCell.h"
#import "UICustomSwitch.h"
#import "AddClockViewController.h"
#import "Clock.h"
#import "SQLiteAccess.h"
#import "NVSlideMenuController.h"
#import "NotificationsManager.h"

@interface PageAlarmClockViewController ()

@end

@implementation PageAlarmClockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        /*alarmClock = [[NSMutableArray alloc] initWithObjects:@"asd",@"asf",@"asf",@"asf",@"asf", nil];*/
        _filteredNotes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
   
    [super viewDidLoad];

    NSArray* editArray = [SQLiteAccess selectManyRowsWithSQL:@"select * from AlarmClock"];
    NSLog(@"%d",[SQLiteAccess selectManyRowsWithSQL:@"select * from AlarmClock"].count);
    
    UIButton *mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mainButton.frame = CGRectMake(0, 0, 50, 30);
    [mainButton setTitle:@"" forState:UIControlStateNormal];
    //[mainButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [mainButton setBackgroundImage:[UIImage imageNamed:@"menu_button.png"] forState:UIControlStateNormal];
    [mainButton setTitleColor:[UIColor blackColor] forState:normal];
    [mainButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:mainButton] autorelease];
    [mainButton addTarget:self.slideMenuController action:@selector(toggleMenuAnimated:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(0, 0, 50, 30);
    [editButton setTitle:@"Edit" forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [editButton setBackgroundImage:[UIImage imageNamed:@"edit_button_backround.png"] forState:UIControlStateNormal];
    [editButton setTitleColor:[UIColor blackColor] forState:normal];
    [editButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:editButton] autorelease];
    
    if(editArray.count==0)
    {
        self.navigationItem.rightBarButtonItem=nil;
    }
    
    /*UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 383, self.view.frame.size.width, 33);
    NSMutableArray *buttons = [[NSMutableArray alloc]init];
    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add_button"]style:UIBarButtonItemStyleBordered target:nil action:@selector(addButton:)];
                             [toolbar setItems:buttons animated:NO];
    
    [buttons release];
    [self.view addSubview:toolbar];
    [toolbar release];*/
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(searchTextFieldTextChanged)
     name:UITextFieldTextDidChangeNotification
     object:_searchTextField];
    
 
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddClockViewController *addClockViewController = [[AddClockViewController alloc]initWithClock:[_clocks objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:addClockViewController animated:YES];
    [addClockViewController release];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[DataManager sharedInstance]  getClocksWithSucces:^(NSArray *clocks) {
        self.clocks = clocks;
        
        [_filteredNotes removeAllObjects];
        [_filteredNotes addObjectsFromArray:_clocks];
        [_alarmClockTableView reloadData];
        
        [[NotificationsManager sharedInstance] sinhronizeNotification:_clocks];
        
    } failture:^(NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error" message:@"Не получилось загрузить данные" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        
    }];
}

- (void)dealloc {
    [_alarmClockTableView release];
    [lupaButton release];
    [searchTextField release];
    [_addToolbar release];
    [_filteredNotes release];
    [super dealloc];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_filteredNotes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PageAlarmClockCell";
    
    PageAlarmClockCell *cell = [_alarmClockTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PageAlarmClockCell" owner:nil options:nil]objectAtIndex:0];
    }
    
    //Clock *clocks;
    
    
    
    UICustomSwitch *cust=[[UICustomSwitch alloc]initWithFrame:CGRectMake(6, 31, 64, 33)];
    
    [cell addSubview:cust];
    
    Clock *clock = [_clocks objectAtIndex:indexPath.row];
    
    clock = [_filteredNotes objectAtIndex:indexPath.row];
    
    cell.nameClockLabel.text = clock.name;
    cell.descriptionClockLabel.text = clock.description;
    
    if ([clock.min intValue] <= 9 )
        cell.minuteLabel.text = [NSString stringWithFormat:@"0%@",clock.min];
    else
        cell.minuteLabel.text = clock.min;
    
    if ([clock.hour intValue] <=9)
        cell.hourLabel.text = [NSString stringWithFormat:@"0%@",clock.hour] ;
    else
        cell.hourLabel.text = clock.hour;
    
    cell.activeClock = clock;
    cust.activeClock = clock;
    

    
    if ([clock.mon intValue] == 1 )
        cell.monLabel.textColor = [UIColor blueColor];
    else
        cell.monLabel.textColor = [UIColor blackColor];
    
    if ([clock.tue intValue] == 1 )
        cell.tueLabel.textColor = [UIColor blueColor];
    else
        cell.tueLabel.textColor = [UIColor blackColor];
    
    if ([clock.wed intValue] == 1 )
        cell.wedLabel.textColor = [UIColor blueColor];
    else
        cell.wedLabel.textColor = [UIColor blackColor];
    
    if ([clock.thu intValue] == 1 )
        cell.thuLabel.textColor = [UIColor blueColor];
    else
        cell.thuLabel.textColor = [UIColor blackColor];
    
    if ([clock.fri intValue] == 1 )
        cell.friLabel.textColor = [UIColor blueColor];
    else
        cell.friLabel.textColor = [UIColor blackColor];
    
    if ([clock.sat intValue] == 1 )
        cell.satLabel.textColor = [UIColor blueColor];
    else
        cell.satLabel.textColor = [UIColor blackColor];
    
    if ([clock.sun intValue] == 1 )
        cell.sunLabel.textColor = [UIColor blueColor];
    else
        cell.sunLabel.textColor = [UIColor blackColor];
    
    if ([cell.activeClock.active  isEqual: @"1"])
        [cust setOn:YES animated:NO];
    else
        [cust setOn:NO animated:NO];
    
    return cell;
}
- (IBAction)lupaButtonPressed:(id)sender {
}

- (IBAction)searchTextFieldPressed:(id)sender
{
    NSLog(@"search");
}

- (IBAction)addButtonPressed:(id)sender
{
    AddClockViewController *addClockViewController = [[AddClockViewController alloc]init];
    [self.navigationController pushViewController:addClockViewController animated:YES];
    [addClockViewController release];
}

-(void) editButtonPressed
{
    [_alarmClockTableView setEditing:!self.alarmClockTableView.editing animated:YES];
}

-(void) nextButtonPressed
{
    NSLog(@"main");
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Clock *clock = [_clocks objectAtIndex:indexPath.row];
        [SQLiteAccess deleteWithSQL:[NSString stringWithFormat: @"delete from AlarmClock where id = %@",clock.idx]];
        [_clocks removeObject:clock];
        if([_filteredNotes containsObject:clock])
        {
            [_filteredNotes removeObject:clock];
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
        [_filteredNotes addObjectsFromArray:_clocks];
    }
    else
    {
        for(Clock *clock in _clocks)
        {
            if([clock.name rangeOfString:keyWord].location != NSNotFound)
            {
                [_filteredNotes addObject:clock];
            }
        }
    }
    NSLog(@"%@", _filteredNotes);
    [_alarmClockTableView reloadData];
}


-(IBAction)doneButtonPressed:(id)sender
{
    [searchTextField resignFirstResponder];
}

@end
