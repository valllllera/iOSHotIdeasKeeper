//
//  DataManager.m
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "DataManager.h"
#import "SQLiteAccess.h"
#import "Note.h"
#import "NSString+ExtString.h"
#import "NSDate+ExtDate.h"

@implementation DataManager

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

- (void)getNotesWithSucces:(void (^)(NSArray *notes))success
                      failture:(void (^)(NSError *error))failture
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *notesArray;
            notesArray = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM noteTable "];

        NSMutableArray *notes = [NSMutableArray array];
        
        for(NSDictionary *noteDict in notesArray)
        {
            Note *note = [[Note alloc] init];
            
            note.noteText = [noteDict objectForKey:@"note"];
            note.idx = [noteDict objectForKey:@"id"];
            note.date = [[noteDict objectForKey:@"date"] dateDB];
            note.imageUrlPath = [noteDict objectForKey:@"imageUrlPath"];


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

#pragma mark - Work with note in DB

+(void)saveNewNote:(Note*)note
{
    NSDate *date = [NSDate date];

    NSString *query = [NSString stringWithFormat:@"insert into noteTable (note , date) values ('%@',%@ )",note.noteText, [date saveStringToDb]];
    
    [SQLiteAccess insertWithSQL:query];
    
   
}

+(void)updateNewNote:(Note *)note
{    
    NSString *query = [NSString stringWithFormat:@"update noteTable SET note = '%@' where id = %@",note.noteText ,note.idx];
    [SQLiteAccess updateWithSQL:query];
    
}
@end
