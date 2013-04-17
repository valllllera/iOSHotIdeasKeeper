//
//  DateManager.m
//  TaskNotifier
//
//  Created by Vlad Polupan - iOS on 21.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "DateManager.h"
#import "AddNoteViewController.h"
#import "SQLiteAccess.h"

@implementation DateManager

#pragma mark - Singleton

static DateManager *sharedInstance = nil;

+ (DateManager *)sharedInstance
{
    @synchronized(self)
    {
        if(!sharedInstance)
        {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if(self)
    {
        _years = [[self generateYears] retain];
        _monthArray = [[self generateMonth] retain];
        _minutesArray = [[self generateMin]retain];
        _hoursArray = [[self generateHours]retain];
        
    }
    return self;
}

- (NSArray *)generateYears
{
    NSMutableArray *years = [NSMutableArray array];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger year = [components year];
    
    for (int i = 0; i < 200; i++)
    {
        [years addObject:[NSString stringWithFormat:@"%d",(year+i)]];
    }
    
    return years;
}

-(NSArray*)generateHours
{
    NSArray*hoursArray = [ NSArray arrayWithObjects:@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23",  nil];
    
    return hoursArray;
}
-(NSArray *)generateDays:(NSInteger)days withCurrentYear:(NSInteger)currentYear
{
    NSMutableArray *daysCount = [NSMutableArray array];
    if (days == 1 || days == 3 || days == 5 || days == 7 || days ==8 || days == 10 || days == 12)
        for (int i =1;i<=31;i++)
        {
            if ( i <= 9 )
                [daysCount addObject:[NSString stringWithFormat:@"0%d",i]];
            else
                [daysCount addObject:[NSString stringWithFormat:@"%d",i]];
        }
    
    else if (days == 2)
    {
        NSLog(@"%ld",(long)currentYear);
        if ((currentYear % 4)==0)
            for (int i =1;i<=28;++i)
                [daysCount addObject:[NSString stringWithFormat:@"%d",i]];
        else
            for (int i =1;i<=29;i++)
                [daysCount addObject:[NSString stringWithFormat:@"%d",i]];
        
        NSLog(@"%i",daysCount.count);
    }
    else
        for (int i =1;i<=30;i++)
            [daysCount addObject:[NSString stringWithFormat:@"%d",i]];
    
    
    return daysCount;
    
}

-(NSArray *)generateMonth
{
    /*AddNoteViewController *addNoteViewController = [[AddNoteViewController alloc]init];
     
     int temp = [addNoteViewController.insertDayLabel.text intValue];
     
     if ([addNoteViewController.insertMonthLabel.text isEqual: @"Февраль"] && (temp >=28))
     {
     addNoteViewController.insertDayLabel.text = @"28";
     }*/
    
    NSMutableArray *monthArray = [[NSMutableArray alloc] initWithObjects: @"Январь", @"Февраль", @"Март", @"Апрель", @"Май", @"Июнь", @"Июль", @"Август", @"Сентябрь", @"Октябрь", @"Ноябрь", @"Декабрь", nil];
    
    return monthArray;
    
}

-(NSArray *)generateMin
{
    NSArray *minutesArray = [NSArray arrayWithObjects:@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59", nil];
    
    return minutesArray;
}

/*
-(void)dealloc
{
    [_years release];
    [_daysArray release];
    [_minutesArray release];
    [_monthArray release];
    [_hoursArray release];
    [super dealloc];
}
*/

+(NSArray *)generateRemindValues
{
    NSArray *remindArray = [NSArray arrayWithObjects:@"1 час",@"1 день" ,@"1 неделя",@"1 месяц", nil];
    return remindArray;
}

+(BOOL)insertNewClock:(NSString*)name description:(NSString*)description hour:(int)hours min:(int)min mon:(int)mon tue:(int)tue wen:(int)wen th:(int)th fri:(int)fri sut:(int)sut sun:(int)sun remind:(int)remind
{
    NSString *query = [NSString stringWithFormat:@"insert into AlarmClock (name, description,hour,min,monday,tuesday, wednesday,thursday,friday,saturday,sunday,remind,active) values('%@', '%@',%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d);",name,description,hours,min,mon,tue,wen,th,fri,sut,sun,remind,1];
    
    BOOL isSuccess = NO;
    
    if([SQLiteAccess insertWithSQL:query])
    {
        isSuccess = YES;
    }
    
    return isSuccess;
}



@end
