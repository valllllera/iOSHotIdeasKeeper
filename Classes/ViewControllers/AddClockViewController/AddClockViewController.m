//
//  AddClockViewController.m
//  Clock
//
//  Created by Savva on 12.03.13.
//  Copyright (c) 2013 iOS - Evgeniy Lipskiy. All rights reserved.
//

#import "AddClockViewController.h"
#import "MainViewController.h"
#import "DateManager.h"
#import "ChoiseView.h"
#import "SQLiteAccess.h"
#import "NVSlideMenuController.h"
#import "PageAlarmClockViewController.h"

@interface AddClockViewController ()

@end

@implementation AddClockViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dayArray = [[NSMutableArray alloc] init];
        _timeRepeatArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)initWithClock :(Clock *)clock
{
    self = [super init];
    if (self)
    {
        self.activeClock = clock;
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.flagView = NO;
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(0, 0, 50, 31);
    [editButton setTitle:@"cancel" forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [editButton setBackgroundImage:[UIImage imageNamed:@"edit_button_backround.png"] forState:UIControlStateNormal];
    [editButton setTitleColor:[UIColor blackColor] forState:normal];
    [editButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:editButton] autorelease];
    UIButton *edit2Button = [UIButton buttonWithType:UIButtonTypeCustom];
    edit2Button.frame = CGRectMake(0, 0, 50, 31);
    [edit2Button setTitle:@"save" forState:UIControlStateNormal];
    [edit2Button addTarget:self action:@selector(saveButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [edit2Button.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [edit2Button setBackgroundImage:[UIImage imageNamed:@"edit_button_backround.png"] forState:UIControlStateNormal];
    [edit2Button setTitleColor:[UIColor blackColor] forState:normal];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:edit2Button] autorelease];
    
    
    NSLog(@"%lu",(unsigned long)[SQLiteAccess selectManyRowsWithSQL:@"SELECT hour FROM AlarmClock where id = 4 "].count);
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit fromDate:[NSDate date]];
    
    if ([components minute] <= 9)
        _minuteLabel.text = [NSString stringWithFormat:@"0%i",[components minute]];
    else
        _minuteLabel.text = [NSString stringWithFormat:@"%i",[components minute]];
    _hourLabel.text = [NSString stringWithFormat: @"%i",[components hour]];
    
    
    if (_activeClock) // СДЕСЬ ЕСЛИ УЖЕ ЕСТЬ
    {
        self.flagView = YES;
        
        if ([_activeClock.mon intValue] == 1)
        {
            self.mondayButton.selected = YES;
            self.mon = 1;
        }
        if ([_activeClock.tue intValue] == 1)
        {
            self.tuesdayButton.selected = YES;
            self.tue = 1;
        }
        if ([_activeClock.wed intValue] == 1)
        {
             self.wednesdayButton.selected = YES;
            self.wed = 1;
        }
        if ([_activeClock.thu intValue] == 1)
        {
            self.thursdayButton.selected = YES;
            self.thu = 1;
        }
        if ([_activeClock.fri intValue] == 1)
        {
            self.fridayButton.selected = YES;
            self.fri = 1;
        }
        if ([_activeClock.sat intValue] == 1)
        {
            self.saturdayButton.selected =YES;
            self.sat = 1;
        }
        if ([_activeClock.sun intValue] == 1)
        {
            self.sundayButton.selected = YES;
            self.sun = 1;
        }
        
        NSLog(@"%@",_activeClock.remind);
        
        self.clockNameTextField.text  = _activeClock.name;
        self.clockDescriptionTextField.text= _activeClock.description;
        self.minuteLabel.text = _activeClock.min;
        self.hourLabel.text = _activeClock.hour;
        
        if ([_activeClock.remind intValue] == 5)
            self.remindFiveButton.selected = YES;
        if([_activeClock.remind intValue] == 10)
            self.remindTenButton.selected = YES;
        if ([_activeClock.remind intValue] == 15)
            self.remindFivButton.selected = YES;
        
        
        
    }
    _clockDescriptionTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    [_clockDescriptionTextField release];
    [repeate1TextLabel release];
    [repeate2TextLabel release];
    [soundNameLabel release];
    [mediaNameLabel release];
    [_dayArray release];
    [_timeRepeatArray release];
    [_minuteLabel release];
    [_hourLabel release];
    [_mondayButton release];
    [_tuesdayButton release];
    [_wednesdayButton release];
    [_thursdayButton release];
    [_fridayButton release];
    [_saturdayButton release];
    [_sundayButton release];
    [_fridayButton release];
    [_fridayButton release];
    [_clockNameTextField release];
    [_remindFiveButton release];
    [_remindTenButton release];
    [_remindFivButton release];
    [super dealloc];
}

/*- (IBAction)timeButtonPressed:(id)sender {
    UIButton *button = sender;
    button.selected = !button.selected;
    if(button.selected == YES)
    {
        [_timeRepeatArray removeAllObjects];
        TimeRepeat timeRepeat = [sender tag];
        for(int i=8; i<11; i++)
        {
            UIButton *button3 = (UIButton *)[self.view viewWithTag:i];
            if([button3 isKindOfClass:[UIButton class]])
            {
                button3.selected = NO;
            }
        }
        button.selected = YES;
        [self removeTime:timeRepeat];
        [_timeRepeatArray addObject:[NSNumber numberWithInteger:timeRepeat]];
    }
    else
    {
        button.selected = NO;
        [_timeRepeatArray removeAllObjects];
    }
    NSLog(@"%@", _timeRepeatArray);
}
*/
- (IBAction)dayButtonPressed:(id)sender {
    UIButton *temp = sender;
    temp.selected = !temp.selected;
    DayOfWeek dayOfWeek = [sender tag];
    [self removeDay:dayOfWeek];
    if(temp.selected)
    {
        [_dayArray addObject:[NSNumber numberWithInteger:dayOfWeek]];
    }
    NSLog(@"%@", _dayArray);
}

- (IBAction)standartSoundButtonPressed:(id)sender {
    UIButton *temp = sender;
    temp.selected = !temp.selected;
}

- (IBAction)mediaSoundButtonPressed:(id)sender {
    UIButton *temp = sender;
    temp.selected = !temp.selected;
}

- (IBAction)allDayButtonPressed:(id)sender {
    UIButton *temp = sender;
    temp.selected = !temp.selected;
    if(temp.selected == YES)
    {
        [_dayArray removeAllObjects];
        for(int i=1; i<8; i++)
        {
            DayOfWeek dayOfWeek = i;
            [_dayArray addObject:[NSNumber numberWithInteger:dayOfWeek]];
            UIButton *button = (UIButton *)[self.view viewWithTag:dayOfWeek];
            if([button isKindOfClass:[UIButton class]])
            {
                button.selected = YES;
            }
        }
        self.mon = 1 ,self.tue =1 , self.wed = 1 , self.thu = 1 , self.fri = 1 , self.sat = 1 , self.sun = 1;
    }
    else
    {
        [_dayArray removeAllObjects];
        for(int i=1; i<8; i++)
        {
            DayOfWeek dayOfWeek = i;
            UIButton *button = (UIButton *)[self.view viewWithTag:dayOfWeek];
            if([button isKindOfClass:[UIButton class]])
            {
                button.selected = NO;
            }
        }
        
       
         self.mon = 0 ,self.tue =0 , self.wed = 0 , self.thu = 0 , self.fri = 0 , self.sat = 0 , self.sun = 0;
    }
    NSLog(@"%@", _dayArray);
}

-(IBAction)doneButtonPressed:(id)sender{
    [_clockNameTextField resignFirstResponder];
    [_clockDescriptionTextField resignFirstResponder];
}

- (IBAction)hourButtonPressed:(id)sender
{
    
    if([self isHasChoiseView])
    {
        return;
    }
    
    ChoiseView *choiseView = [[ChoiseView alloc] initWithItems:[NSArray arrayWithArray: [DateManager sharedInstance].hoursArray]  andWithIndexOfActiveIndex:0];
    [choiseView setSelectedItemBlock:^(id item) {
        NSLog(@"select item: %@", item);
        [choiseView removeFromSuperview];
        self.hourLabel.text = item;
    }];
    choiseView.frame = CGRectMake(0, 264, 158, 150);
    [self.view addSubview:choiseView];
    [choiseView release];

}

- (IBAction)minuteButtonPressed:(id)sender
{
    if([self isHasChoiseView])
    {
        return;
    }
    
    ChoiseView *choiseView = [[ChoiseView alloc] initWithItems:[NSArray arrayWithArray: [DateManager sharedInstance].minutesArray]  andWithIndexOfActiveIndex:0];
    [choiseView setSelectedItemBlock:^(id item) {
        NSLog(@"select item: %@", item);
        [choiseView removeFromSuperview];
        self.minuteLabel.text = item;
    }];
    choiseView.frame = CGRectMake(163, 264, 158, 150);
    [self.view addSubview:choiseView];
    [choiseView release];
}

- (IBAction)mondayButtonPressed:(id)sender
{
    if (_mondayButton.selected == YES)
        self.mon = 0;
    
    else
        self.mon = 1;
    
    _mondayButton.selected = !_mondayButton.selected;
}

- (IBAction)tuesdayButtonPressed:(id)sender
{
    if (_tuesdayButton.selected == YES)
        self.tue = 0;
    
    else
        self.tue = 1;
    
    _tuesdayButton.selected = !_tuesdayButton.selected;
}

- (IBAction)wednesdayButtonPressed:(id)sender
{
    if (_wednesdayButton.selected == YES)
        self.wed = 0;
    
    else
        self.wed = 1;
    
    _wednesdayButton.selected = !_wednesdayButton.selected;
}

- (IBAction)thursdayButtonPressed:(id)sender
{

    if (_thursdayButton.selected == YES)
        self.thu = 0;
    
    else
        self.thu = 1;
    
    _thursdayButton.selected = !_thursdayButton.selected;
}

- (IBAction)fridayButtonPressed:(id)sender
{
    if (_fridayButton.selected == YES)
        self.fri = 0;

    else
        self.fri = 1;
    
    _fridayButton.selected = !_fridayButton.selected;
}

- (IBAction)saturdayButtonPressed:(id)sender
{
    if (_saturdayButton.selected == YES)
        self.sat = 0;
    
    else
        self.sat = 1;
    
    _saturdayButton.selected = !_saturdayButton.selected;
}

- (IBAction)sundayButtonPressed:(id)sender
{
    if (_sundayButton.selected == YES)
        self.sun = 0;
    
    else
        self.sun = 1;
    
    _sundayButton.selected = !_sundayButton.selected;
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



- (void)removeDay:(DayOfWeek)dayOfWeek
{
    NSMutableArray *daysForRemoving = [NSMutableArray array];
    for(NSNumber *day in _dayArray)
    {
        if([day isKindOfClass:[NSNumber class]])
        {
            if([day integerValue] == dayOfWeek)
            {
                [daysForRemoving addObject:day];
            }
        }
    }
    [_dayArray removeObjectsInArray:daysForRemoving];
}

-(void)removeTime:(TimeRepeat)timeRepeat
{
    NSMutableArray *timesForRemoving = [NSMutableArray array];
    for(NSNumber *time in _timeRepeatArray)
    {
        if([time isKindOfClass:[NSNumber class]])
        {
            if([time integerValue] == timeRepeat)
            {
                [timesForRemoving addObject:time];
            }
        }
    }
    [_timeRepeatArray removeObjectsInArray:timesForRemoving];
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [_clockNameTextField resignFirstResponder];
    [_clockDescriptionTextField resignFirstResponder];
    if (_value == 1 )
    {
        [self.slideMenuController showMenuAnimated:YES completion:nil];
        _value = 0;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveButtonPressed
{
    NSLog(@"%d",self.remind);
    
    if (self.flagView == NO)
    {
        if([DateManager insertNewClock:_clockNameTextField.text description:_clockDescriptionTextField.text hour:[_hourLabel.text intValue] min:[_minuteLabel.text intValue] mon:self.mon tue:self.tue wen:self.wed th:self.thu fri:self.fri sut:self.sat sun:self.sun remind:self.remind] == true)
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                 initWithTitle:@"" message:@"Будильник успешно сохранен" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles: nil];
            [alertView show];
            [alertView release];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Ошибка" message:@"Будильник не сохранен" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles: nil];
            [alertView show];
            [alertView release];
        }
    }
    else
    {
        if([DataManager updateNewClock:_clockNameTextField.text description:_clockDescriptionTextField.text hour:[_hourLabel.text intValue] min:[_minuteLabel.text intValue] mon:self.mon  tue:self.tue wen:self.wed th:self.thu fri:self.fri sut:self.sat sun:self.sun remind:self.remind idx:[NSString stringWithFormat:@"%@", _activeClock.idx]]  == true)
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"" message:@"Будильник успешно изменен" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles: nil];
            [alertView show];
            [alertView release];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Ошибка" message:@"Будильник не изменен" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles: nil];
            [alertView show];
            [alertView release];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *cancelTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if([cancelTitle isEqualToString:@"Ок"])
    {
        PageAlarmClockViewController *pageAlarmClockViewController = [[PageAlarmClockViewController alloc]init];
        [self.navigationController pushViewController:pageAlarmClockViewController animated:YES];
        [pageAlarmClockViewController release];
    }
}

- (void)viewDidUnload
{
    [self setMinuteLabel:nil];
    [self setHourLabel:nil];
    [self setMondayButton:nil];
    [self setTuesdayButton:nil];
    [self setWednesdayButton:nil];
    [self setThursdayButton:nil];
    [self setFridayButton:nil];
    [self setSaturdayButton:nil];
    [self setSundayButton:nil];
    [self setFridayButton:nil];
    [self setFridayButton:nil];
    [self setClockNameTextField:nil];
    [self setRemindFiveButton:nil];
    [self setRemindTenButton:nil];
    [self setRemindFivButton:nil];
    [super viewDidUnload];
}

- (IBAction)remindFive:(id)sender
{
    self.remindFiveButton.selected = YES;
    self.remindFivButton.selected = NO;
    self.remindTenButton.selected = NO;
    
    self.remind = 5;
}

- (IBAction)remindTen:(id)sender
{
    self.remindFiveButton.selected = NO;
    self.remindFivButton.selected = NO;
    self.remindTenButton.selected = YES;
    
    self.remind = 10;
}

- (IBAction)remindFiv:(id)sender
{
    self.remindFiveButton.selected = NO;
    self.remindFivButton.selected = YES;
    self.remindTenButton.selected = NO;
    
    self.remind = 15;
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
