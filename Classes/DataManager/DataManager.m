//
//  DataManager.m
//  TaskNotifier
//
//  Created by Evgeniy Tka4enko on 12.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "DataManager.h"
#import "SQLiteAccess.h"
#import "Clock.h"
#import "Note.h"


@implementation DataManager

#pragma mark - Singleton
static NSInteger active;
static DataManager *sharedInstance = nil;

+ (DataManager *)sharedInstance
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
        _notes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Public
- (void)getRemembersWithSucces:(void (^)(NSArray *notes))success
                  failture:(void (^)(NSError *error))failture
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *notesArray;
        if (active == 0)
            notesArray = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM Notes ORDER BY prioritet DESC"];
        else
             notesArray = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM Notes where active = 1 ORDER BY prioritet DESC"];
        
        NSMutableArray *notes = [NSMutableArray array];
        
        for(NSDictionary *noteDict in notesArray)
        {
            Remember *note = [[[Remember alloc] init] autorelease];
            
            note.name = [noteDict objectForKey:@"name"];
            note.description  = [noteDict objectForKey:@"description"];
            note.min = [noteDict objectForKey:@"min"];
            note.hour = [noteDict objectForKey:@"hour"];
            note.prioritet = [noteDict objectForKey:@"prioritet"];
            note.active = [noteDict objectForKey:@"active"];
            note.date = [noteDict objectForKey:@"datastring"];
            note.idx = [NSNumber numberWithInteger:[[noteDict objectForKey:@"id"] integerValue]];
            note.remind = [noteDict objectForKey:@"remind"];
            note.x = [noteDict objectForKey:@"x"];
            note.y = [noteDict objectForKey:@"y"];
            
            
            [notes addObject:note];
        }
        
        if([notes count] > 0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(success)
                {
                    success(notes);
                }
            });
        }
    });
}

- (void)getNotesWithSucces:(void (^)(NSArray *))success failture:(void (^)(NSError *))failture
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray * notesArray = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM Remembers ORDER BY prioritet DESC"];
        NSLog(@"%i",notesArray.count);
        
        NSMutableArray *notes = [NSMutableArray array];
        
        for(NSDictionary *noteDict in notesArray)
        {
            Note *note = [[[Note alloc] init] autorelease];
            
            note.name = [noteDict objectForKey:@"name"];
            note.description  = [noteDict objectForKey:@"description"];
            note.prioritet = [noteDict objectForKey:@"prioritet"];
            note.idx = [noteDict objectForKey:@"id"];
                        
            [notes addObject:note];
        }
        
        if([notes count] > 0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(success)
                {
                    success(notes);
                }
            });
        }
    });
}

- (void)getClocksWithSucces:(void (^)(NSArray *clocks))success
                  failture:(void (^)(NSError *error))failture
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *notesArray = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM AlarmClock"];
        
        NSMutableArray *notes = [NSMutableArray array];
        
        for(NSDictionary *noteDict in notesArray)
        {
            Clock *alarmPage = [[[Clock alloc]init]autorelease];
            
            alarmPage.name = [noteDict objectForKey:@"name"];
            alarmPage.description = [noteDict objectForKey:@"description"];
            alarmPage.min = [noteDict objectForKey:@"min"];
            alarmPage.hour = [noteDict objectForKey:@"hour"];
            alarmPage.active = [noteDict objectForKey:@"active"];
            alarmPage.mon = [noteDict objectForKey:@"monday"];
            alarmPage.tue = [noteDict objectForKey:@"tuesday"];
            alarmPage.wed = [noteDict objectForKey:@"wednesday"];
            alarmPage.thu = [noteDict objectForKey:@"thursday"];
            alarmPage.fri = [noteDict objectForKey:@"friday"];
            alarmPage.sat = [noteDict objectForKey:@"saturday"];
            alarmPage.sun = [noteDict objectForKey:@"sunday"];
            alarmPage.remind = [noteDict objectForKey:@"remind"];
            alarmPage.idx = [NSNumber numberWithInteger:[[noteDict objectForKey:@"id"] integerValue]];
            
         
            [notes addObject:alarmPage];
        }
        
        if([notes count] > 0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(success)
                {
                    success(notes);
                }
            });
        }
    });
}

+(NSInteger)initWithActiveNote :(NSInteger) activate
{
    active = activate;
    return active;
}

+(void)saveNewRemember:(NSString *)name description:(NSString*)description proritet:(NSInteger)prioritet
{
    NSString *query = [NSString stringWithFormat:@"insert into Remembers (name,description,prioritet) values ('%@','%@',%d)",name,description,prioritet];
    [SQLiteAccess insertWithSQL:query];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Заметка успешно сохранена" delegate:self cancelButtonTitle:@"Oк" otherButtonTitles: nil];
    [alertView show];
    [alertView release];
}

+(BOOL)updateNewClock  :(NSString*)name description:(NSString*)description hour:(int)hours min:(int)min mon:(int)mon tue:(int)tue wen:(int)wen th:(int)th fri:(int)fri sut:(int)sut sun:(int)sun remind:(int)remind idx:(NSString*)idx
{
    
    
    NSString *query = [NSString stringWithFormat:@"update AlarmClock SET name = '%@', description = '%@',hour = %d,min = %d,monday = %d,tuesday = %d, wednesday = %d,thursday = %d,friday = %d,saturday = %d,sunday = %d,remind = %d ,active = %d where id = '%@';",name,description,hours,min,mon,tue,wen,th,fri,sut,sun,remind,1,idx];
    
    [SQLiteAccess updateWithSQL:query];

    
    return YES;
}

#pragma mark - Private

@end
