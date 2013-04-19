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

+(void)saveNewRemember:(Note*)note
{
    NSString *query = [NSString stringWithFormat:@"insert into noteTable (note) values ('%@')",note.noteText];
    [SQLiteAccess insertWithSQL:query];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Заметка успешно сохранена" delegate:self cancelButtonTitle:@"Oк" otherButtonTitles: nil];
    [alertView show];
}

+(void)updateNewRemember:(Note *)note
{
    NSString *query = [NSString stringWithFormat:@"update noteTable SET note = '%@' where id = '%@'",note.noteText ,note.idx];
    [SQLiteAccess updateWithSQL:query];
}
@end
