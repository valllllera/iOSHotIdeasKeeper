//
//  AddNotesViewController.m
//  TaskNotifier
//
//  Created by Vlad Polupan - iOS on 16.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "AddNoteViewController.h"
#import "AddPlaceOnMapViewController.h"
#import "ChoiseView.h"
#import "SQLiteAccess.h"
#import "DateManager.h"
#import "MainViewController.h"

@interface AddNoteViewController ()

@end

@implementation AddNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"%ld",(long)[self countDB]);
    }
    return self;
}

- (id)initWithNote:(Remember *)note
{
    self = [super init];
    if(self)
    {
        self.activeNote = note;
        self.flagButton = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    _shortDescribeTextView.delegate = self;
    _flagView = NO;
    
    [super viewDidLoad];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit |NSMinuteCalendarUnit | NSHourCalendarUnit fromDate:[NSDate date]];
    NSInteger year = [components year];
    NSInteger day = [components day];
    int month = [components month];
    
    self.redPriorityButtonPressed.selected = YES;
    self.prioritet = 4;
    
    _insertYearLabel.text =[NSString stringWithFormat:@"%i" ,year];
    _insertDayLabel.text = [NSString stringWithFormat:@"%i" ,day];
    
    if ([components minute] <= 9)
        _minuteLabel.text =  [NSString stringWithFormat:@"0%i" ,[components minute]];
    else
        _minuteLabel.text =  [NSString stringWithFormat:@"%i" ,[components minute]];
    
    
    if ([components hour] <= 9)
        _hourLabel.text = [NSString stringWithFormat:@"0%i" ,[components hour]];
    else
        _hourLabel.text = [NSString stringWithFormat:@"%i" ,[components hour]];
    
    switch (month) {
        case 1:
            _insertMonthLabel.text = @"Январь";
            break;
        case 2:
            _insertMonthLabel.text = @"Февраль";
            break;
        case 3:
            _insertMonthLabel.text = @"Март";
            break;
        case 4:
            _insertMonthLabel.text = @"Апрель";
            break;
        case 5:
            _insertMonthLabel.text = @"Май";
            break;
        case 6:
            _insertMonthLabel.text = @"Июнь";
            break;
        case 7:
            _insertMonthLabel.text = @"Июль";
            break;
        case 8:
            _insertMonthLabel.text = @"Август";
            break;
        case 9:
            _insertMonthLabel.text = @"Сентябрь";
            break;
        case 10:
            _insertMonthLabel.text = @"Октябрь";
            break;
        case 11:
            _insertMonthLabel.text = @"Ноябрь";
            break;
        case 12:
            _insertMonthLabel.text = @"Декабрь";
            break;
            
        default:
            break;
    }
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(0, 0, 60, 31);
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveNewNote) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"edit_button_backround.png"] forState:UIControlStateNormal];
    saveButton.titleLabel.textColor = [UIColor blackColor];
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:saveButton] autorelease];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(19, 29, 65, 31);
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.textColor = [UIColor blackColor];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"edit_button_backround.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:cancelButton] autorelease];
    
    if(_activeNote)
    {
        NSLog(@"ololo2 %@", _activeNote.x);
        
        _flagView = YES;
        
        
        NSString *date = _activeNote.date;
        NSString *year = [date substringToIndex:4];
        NSString *date2 = [date substringFromIndex:4];
        NSString *month = [date2 substringToIndex:3];
        NSString *day = [date2 substringFromIndex:3];
        
        
         self.greyPriorityButtonPressed.selected = NO;
         self.greenPriorityButtonPressed.selected = NO;
         self.yellowPriorityButtonPressed.selected = NO;
         self.redPriorityButtonPressed.selected = NO;

        
        _notesNameTextField.text = _activeNote.name;
        
        NSString *newDay = [day stringByReplacingOccurrencesOfString: @" " withString:@""];
        
        NSLog(@"%@",month);
        if ([day intValue] <=9)
            _insertDayLabel.text = [NSString stringWithFormat:@"0%@",newDay];
        else
            _insertDayLabel.text = [NSString stringWithFormat:@"%@",newDay];\
        
        
        if ([month isEqual: @" 01"])
            _insertMonthLabel.text = @"Январь";
        else if ([month isEqual: @" 02"])
            _insertMonthLabel.text  = @"Февраль";
        else if ([month isEqual: @" 03"])
            _insertMonthLabel.text  = @"Март";
        else if ([month isEqual: @" 04"])
            _insertMonthLabel.text  = @"Апрель";
        else if ([month isEqual: @" 05"])
            _insertMonthLabel.text  = @"Май";
        else if ([month isEqual: @" 06"])
           _insertMonthLabel.text = @"Июнь";
        else if ([month isEqual: @" 07"])
            _insertMonthLabel.text  = @"Июль";
        else if ([month isEqual: @" 08"])
            _insertMonthLabel.text  = @"Август";
        else if ([month isEqual: @" 09"])
           _insertMonthLabel.text  = @"Сентябрь";
        else if ([month isEqual: @" 10"])
            _insertMonthLabel.text  = @"Октябрь";
        else if ([month isEqual: @" 11"])
            _insertMonthLabel.text  = @"Ноябрь";
        else if ([month isEqual: @" 12"])
          _insertMonthLabel.text  = @"Декабрь";
        
        //_insertMonthLabel.text = [NSString stringWithFormat:@"%@",month];
        _insertYearLabel.text = [NSString stringWithFormat:@"%@",year];
        if ([_activeNote.hour intValue] <= 9 )
            _hourLabel.text = [NSString stringWithFormat:@"0%@",_activeNote.hour];
        else
            _hourLabel.text = [NSString stringWithFormat:@"%@",_activeNote.hour];
        
        if ([_activeNote. min intValue] <=9)
            _minuteLabel.text = [NSString stringWithFormat:@"0%@",_activeNote.min];
        else
            _minuteLabel.text = [NSString stringWithFormat:@"%@",_activeNote.min];
        
        _shortDescribeTextView.text = _activeNote.description;
        
        
        switch ([_activeNote.remind intValue]) {
            case 1:
                _remindLabel.text = @"1 час";
                break;
            case 24:
                _remindLabel.text = @"1 сутки";
                break;
            case 168:
                _remindLabel.text = @"1 неделя";
                break;
            case 720:
                _remindLabel.text = @"1 месяц";
                break;
            default:
                break;
        }
        
        int proitiry = [_activeNote.prioritet intValue];
        
        switch (proitiry) {
            case 1:
                self.greyPriorityButtonPressed.selected = YES;
                break;
                
            case 2:
                self.greenPriorityButtonPressed.selected = YES;
                break;
                
            case 3:
                self.yellowPriorityButtonPressed.selected = YES;
                break;
                
            case 4:
                self.redPriorityButtonPressed.selected = YES;
                break;
                
            default:
                break;
        }
        
        Annotation *annotation = [Annotation new];
        annotation.title = @"Моя точка";
        annotation.subtitle = @"Место положение";
        annotation.coordinate = CLLocationCoordinate2DMake([_activeNote.x floatValue], [_activeNote.y floatValue]);
        [_placeOnMap addAnnotation:annotation];
        [annotation release];
        
        
        NSLog(@"%f",[_activeNote.x floatValue]);
        
        CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake([_activeNote.x floatValue], [_activeNote.y floatValue]);
        MKCoordinateRegion adjustedRegion = [_placeOnMap regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 1000000, 1000000)];
        [_placeOnMap setRegion:adjustedRegion animated:YES];
        
        
        _addPlaceOnMapLabel.text = @"Редактировать место на карте";
        
        
    }
}

- (void)saveNewNote
{
    [_shortDescribeTextView resignFirstResponder];
    NSString * index = nil;
    if ([self.insertMonthLabel.text isEqual: @"Январь"])
        index = @"01";
    else if ([self.insertMonthLabel.text isEqual: @"Февраль"])
        index = @"02";
    else if ([self.insertMonthLabel.text isEqual: @"Март"])
        index = @"03";
    else if ([self.insertMonthLabel.text isEqual: @"Апрель"])
        index = @"04";
    else if ([self.insertMonthLabel.text isEqual: @"Май"])
        index = @"05";
    else if ([self.insertMonthLabel.text isEqual: @"Июнь"])
        index = @"06";
    else if ([self.insertMonthLabel.text isEqual: @"Июль"])
        index = @"07";
    else if ([self.insertMonthLabel.text isEqual: @"Август"])
        index = @"08";
    else if ([self.insertMonthLabel.text isEqual: @"Сентябрь"])
        index = @"09";
    else if ([self.insertMonthLabel.text isEqual: @"Октябрь"])
        index = @"10";
    else if ([self.insertMonthLabel.text isEqual: @"Ноябрь"])
        index = @"11";
    else if ([self.insertMonthLabel.text isEqual: @"Декабрь"])
        index = @"12";
    else
        index = self.insertMonthLabel.text;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit fromDate:[NSDate date]];
    NSInteger year = [components year];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger hour = [components hour];
    NSInteger min = [components minute];
    
    
    if ([_insertDayLabel.text intValue]== day && [index intValue] == month && [_insertYearLabel.text intValue]==year && [_minuteLabel.text intValue]==min && [_hourLabel.text intValue] == hour)
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error" message:@"Нельзя выставить заметку на текущее время" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        
        float x =  [AddPlaceOnMapViewController GetX];
        float y = [AddPlaceOnMapViewController GetY];
        
        NSLog(@"ololo %f %f", x, y);
        
        UIAlertView *alertView;
        
        @try {
            NSString *dateString = [NSString stringWithFormat:@"%@%@%@",self.insertYearLabel.text,index,self.insertDayLabel.text];
            NSString *dataString = [NSString stringWithFormat:@"%@ %@ %@",self.insertYearLabel.text,index,self.insertDayLabel.text];
            if (_flagView == NO)
            {
            NSString *query = [NSString stringWithFormat:@"insert into Notes (name, description,date,hour,min,prioritet,x,y,active,remind,datastring) values('%@', '%@',%@,%@,%@,%d,'%f','%f',%d,%i,'%@');",self.notesNameTextField.text,self.shortDescribeTextView.text,dateString,self.hourLabel.text,self.minuteLabel.text,self.prioritet,x,y,1,self.remind,dataString];
                
                
                 [SQLiteAccess updateWithSQL:query];
                
                alertView = [[UIAlertView alloc]
                             initWithTitle:@"" message:@"Заметка успешно сохранена" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles: nil];
            }
            else
            {
                NSString *query = [NSString stringWithFormat:@"update Notes set name='%@', description ='%@',date = %@,hour =%@,min =%@ ,prioritet = %d,x = '%f',y = '%f',active = %d,remind = %i,datastring = '%@' where id = %@;",self.notesNameTextField.text,self.shortDescribeTextView.text,dateString,self.hourLabel.
                                   text,self.minuteLabel.text,self.prioritet,x,y,1,self.remind,dataString,_activeNote.idx];
                [SQLiteAccess updateWithSQL:query];
                

               
                alertView = [[UIAlertView alloc]
                                          initWithTitle:@"" message:@"Заметка успешно изменина" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles: nil];
            }
            
            NSLog(@"%i",self.remind);
            [alertView show];
            [alertView release];
                                   
                                   
            
        }
        @catch (NSException *exception) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Error" message:@"Не получилось сохранить заметку" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles: nil];
            [alertView show];
            [alertView release];
        }

        
        
    }
    
    //[self.tableView reloadData];(name,description,date,hour,min,prioritet,x,y,active)
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *cancelTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if([cancelTitle isEqualToString:@"Ок"])
    {
        MainViewController *mainViewController = [[MainViewController alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
        [mainViewController release];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)countDB
{
    NSArray * mom = [SQLiteAccess selectManyValuesWithSQL:@"select remind from Notes where id = 2"];
    NSLog(@"%@",mom);
    return mom.count;
}
- (void)dealloc {
    [_activeNote release];
    [_notesNameTextField release];
    [_insertDayLabel release];
    [_insertMonthLabel release];
    [_insertYearLabel release];
    [_priorityLabel release];
    [_redPriorityButtonPressed release];
    [_yellowPriorityButtonPressed release];
    [_greenPriorityButtonPressed release];
    [_greyPriorityButtonPressed release];
    [_addPlaceOnMapLabel release];
    [_addPlaceOnMapButtonPressed release];
    [_placeOnMap release];
    [_shortDescribeTextView release];
    [_hourLabel release];
    [_minuteLabel release];
    [_dayButton release];
    [_monthButton release];
    [_yearButton release];
    [_remindLabel release];
    [super dealloc];
}

- (IBAction)doneButtonPressed:(id)sender
{
    [_shortDescribeTextView resignFirstResponder];
    [_notesNameTextField resignFirstResponder];
}

- (IBAction)redPriorityPressed:(id)sender
{
    if (_redPriorityButtonPressed.selected == NO)
    {
        _yellowPriorityButtonPressed.selected = NO;
        _greenPriorityButtonPressed.selected = NO;
        _greyPriorityButtonPressed.selected = NO;
    }
    _redPriorityButtonPressed.selected = !_redPriorityButtonPressed.selected;
    self.prioritet = 4;
}

- (IBAction)yellowPriorityPressed:(id)sender
{
    if (_yellowPriorityButtonPressed.selected == NO)
    {
        _greenPriorityButtonPressed.selected = NO;
        _greyPriorityButtonPressed.selected = NO;
        _redPriorityButtonPressed.selected = NO;
    }
    _yellowPriorityButtonPressed.selected = !_yellowPriorityButtonPressed.selected;
    self.prioritet = 3;
}

- (IBAction)greenPriorityPressed:(id)sender
{
    if (_greenPriorityButtonPressed.selected == NO)
    {
        _yellowPriorityButtonPressed.selected = NO;
        _greyPriorityButtonPressed.selected = NO;
        _redPriorityButtonPressed.selected = NO;
    }
    _greenPriorityButtonPressed.selected = !_greenPriorityButtonPressed.selected;
    self.prioritet = 2;
}

- (IBAction)greyPriorityPressed:(id)sender
{
    if (_greyPriorityButtonPressed.selected == NO)
    {
        _yellowPriorityButtonPressed.selected = NO;
        _greenPriorityButtonPressed.selected = NO;
        _redPriorityButtonPressed.selected = NO;
    }
    _greyPriorityButtonPressed.selected = !_greyPriorityButtonPressed.selected;
    self.prioritet = 1;
}

- (IBAction)addMapButtonPressed:(id)sender
{
    AddPlaceOnMapViewController *addMapViewController = [[AddPlaceOnMapViewController alloc] init];
    [self.navigationController pushViewController:addMapViewController animated:YES];
    [addMapViewController release];
}



/*- (IBAction)selectTimeButtonPressed:(id)sender
 {
 ChoiseView *choiseView = [[ChoiseView alloc] initWithItems:[NSArray arrayWithObjects:@"asdsadas", @"asdasdfadfgdf df ", @"df fgh fg f", nil] andWithIndexOfActiveIndex:0];
 [choiseView setSelectedItemBlock:^(id item) {
 NSLog(@"select item: %@", self.item);
 [choiseView removeFromSuperview];
 }];
 choiseView.frame = CGRectMake(0, 200, 320, 150);
 [self.view addSubview:choiseView];
 [choiseView release];
 }*/

- (IBAction)insertHourButton:(id)sender
{
    if([self isHasChoiseView])
    {
        return;
    }
    
    _hourButtonOutlet.selected = !_hourButtonOutlet.selected;

        
    
    ChoiseView *choiseView = [[ChoiseView alloc] initWithItems:[NSArray arrayWithArray: [DateManager sharedInstance].hoursArray]  andWithIndexOfActiveIndex:0];

    
    [choiseView setSelectedItemBlock:^(id item) {
        NSLog(@"select item: %@", item);
        [choiseView removeFromSuperview];
        self.hourLabel.text = item;

    }];
    choiseView.frame = CGRectMake(0, 210, 158, 150);
    [self.view addSubview:choiseView];
    [choiseView release];
    
}

- (IBAction)insertMinuteButton:(id)sender
{
    if([self isHasChoiseView])
    {
        return;
    }
    
    ChoiseView *choiseView = [[ChoiseView alloc] initWithItems:[NSArray arrayWithArray:[DateManager sharedInstance].minutesArray] andWithIndexOfActiveIndex:0];
    [choiseView setSelectedItemBlock:^(id item) {
        NSLog(@"select item: %@", item);
        [choiseView removeFromSuperview];
        self.minuteLabel.text = item;
        
    }];
    choiseView.frame = CGRectMake(162, 210, 158, 150);
    [self.view addSubview:choiseView];
    [choiseView release];
    
}

- (IBAction)insertDayButton:(id)sender
{
    if([self isHasChoiseView])
    {
        return;
    }
    
    int index = 0;
    if ([self.insertMonthLabel.text isEqual: @"Январь"])
        index = 1;
    if ([self.insertMonthLabel.text isEqual: @"Февраль"])
        index = 2;
    if ([self.insertMonthLabel.text isEqual: @"Март"])
        index = 3;
    if ([self.insertMonthLabel.text isEqual: @"Апрель"])
        index = 4;
    if ([self.insertMonthLabel.text isEqual: @"Май"])
        index = 5;
    if ([self.insertMonthLabel.text isEqual: @"Июнь"])
        index = 6;
    if ([self.insertMonthLabel.text isEqual: @"Июль"])
        index = 7;
    if ([self.insertMonthLabel.text isEqual: @"Август"])
        index = 8;
    if ([self.insertMonthLabel.text isEqual: @"Сентябрь"])
        index = 9;
    if ([self.insertMonthLabel.text isEqual: @"Октябрь"])
        index = 10;
    if ([self.insertMonthLabel.text isEqual: @"Ноябрь"])
        index = 11;
    if ([self.insertMonthLabel.text isEqual: @"Декабрь"])
        index = 12;
    
    DateManager *dManager = [[DateManager alloc]init];
    NSArray *dayArray = [dManager generateDays:index withCurrentYear:[self.insertYearLabel.text intValue]];
    ChoiseView *choiseView = [[ChoiseView alloc] initWithItems:[NSArray arrayWithArray:dayArray] andWithIndexOfActiveIndex:0];
    [choiseView setSelectedItemBlock:^(id item) {
        NSLog(@"select item: %@", item);
        [choiseView removeFromSuperview];
        self.insertDayLabel.text = item;
    }];
    choiseView.frame = CGRectMake(4, 165, 89, 150);
    [self.view addSubview:choiseView];
    [choiseView release];
    [dManager release];
    
}

- (IBAction)insertMonthButton:(id)sender
{
    if([self isHasChoiseView])
    {
        return;
    }
    
    
    ChoiseView *choiseView = [[ChoiseView alloc] initWithItems:[NSArray arrayWithArray:[DateManager sharedInstance].monthArray] andWithIndexOfActiveIndex:0];
    [choiseView setSelectedItemBlock:^(id item) {
        int temp = [_insertDayLabel.text intValue];
        
        if ([item isEqual:  @"Февраль"] && (temp >=28))
        {
            _insertDayLabel.text = @"28";
        }
        NSLog(@"select item: %@", item);
        [choiseView removeFromSuperview];
        self.insertMonthLabel.text = item;
    }];
    choiseView.frame = CGRectMake(101, 165, 121, 150);
    [self.view addSubview:choiseView];
    [choiseView release];
    
    
    
}

- (IBAction)insertYearButton:(id)sender
{
    if([self isHasChoiseView])
    {
        return;
    }
    
    
    ChoiseView *choiseView = [[ChoiseView alloc] initWithItems:[DateManager sharedInstance].years andWithIndexOfActiveIndex:0];
    [choiseView setSelectedItemBlock:^(id item) {
        NSLog(@"select item: %@", item);
        [choiseView removeFromSuperview];
        self.insertYearLabel.text = item;
    }];
    choiseView.frame = CGRectMake(230, 165, 89, 150);
    [self.view addSubview:choiseView];
    [choiseView release];
}

- (BOOL)isHasChoiseView
{
    BOOL isHasChoiseView = NO;
    
    for(UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[ChoiseView class]])
        {
            isHasChoiseView = YES;
            break;
        }
    }
    
    return isHasChoiseView;
}


- (IBAction)searchTextFieldDonePressed:(id)sender
{
    [_shortDescribeTextView resignFirstResponder];
}

-(IBAction)buttonClicked:(id)sender
{
    [_shortDescribeTextView resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)remindButtonPressed:(id)sender
{
    if([self isHasChoiseView])
    {
        return;
    }
    
    ChoiseView *choiseView = [[ChoiseView alloc] initWithItems:[DateManager generateRemindValues] andWithIndexOfActiveIndex:0];
    [choiseView setSelectedItemBlock:^(id item) {
        NSLog(@"select item: %@", item);
        
        if ([item isEqual: @"1 день"])
            self.remind = 24;
        
        else if ([item isEqual: @"1 час"])
            self.remind = 1;
        else if ([item isEqual: @"1 неделя"])
            self.remind = 168;
        else
            self.remind = 720;
        
        
       [choiseView removeFromSuperview];
        self.remindLabel.text = item;
    }];
    choiseView.frame = CGRectMake(131, 249, 153, 120);
    [self.view addSubview:choiseView];
    [choiseView release];

}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
