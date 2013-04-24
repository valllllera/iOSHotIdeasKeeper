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

#pragma mark - Work with note in DB

- (void)getNotesWithSucces:(void (^)(NSMutableArray *notes))success
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

- (void)getNotesMapWithSucces:(void (^)(NSMutableArray *notes))success
                  failture:(void (^)(NSError *error))failture
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *notesArray;
        notesArray = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM noteWithMap "];
       
        
        NSMutableArray *notes = [NSMutableArray array];
        
        for(NSDictionary *noteDict in notesArray)
        {
            Note *note = [[Note alloc] init];
            
            note.noteText = [noteDict objectForKey:@"note"];
            note.idx = [noteDict objectForKey:@"id"];
            note.date = [[noteDict objectForKey:@"date"] dateDB];
            note.x = [noteDict objectForKey:@"x"];
            note.y = [noteDict objectForKey:@"y"];
            
            
            [notes addObject:note];
        }
        
         NSLog(@"in block %d",notesArray.count);
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

-(void)saveNewNote:(Note*)note
{
    NSDate *date = [NSDate date];

    NSString *query = [NSString stringWithFormat:@"insert into noteTable (note , date , imageUrlPath) values ('%@',%@  , '%@')",note.noteText, [date saveStringToDb] , note.imageUrlPath];
    
    [SQLiteAccess insertWithSQL:query];
    
   
}

-(void)updateNewNote:(Note *)note
{    
    NSString *query = [NSString stringWithFormat:@"update noteTable SET note = '%@' where id = %@",note.noteText ,note.idx];
    [SQLiteAccess updateWithSQL:query];
    
}

-(void)saveNewNoteWithMap:(Note *)note
{
    NSDate *date = [NSDate date];
    NSString *query = [NSString stringWithFormat:@"insert into noteWithMap (note , date , x, y ) values ('%@',%@  , %@ , %@)",note.noteText, [date saveStringToDb] , note.x , note.y];
    
    [SQLiteAccess insertWithSQL:query];
}

-(void)updateNewNoteWithMap:(Note *)note
{
    NSString *query = [NSString stringWithFormat:@"update noteWithMap SET note = '%@' , x = %@ , y = %@ where id = %@",note.noteText, note.x, note.y ,note.idx];
    
    [SQLiteAccess updateWithSQL:query];
    
}

-(void)deleteNote : (NSInteger )idx
{
    NSString *query = [NSString stringWithFormat:@"delete from noteTable where id  = %d" ,idx];
    NSLog(@"%d",idx);
    [SQLiteAccess deleteWithSQL:query];
}

-(void)deleteNoteWithMap:(NSInteger )idx
{
    NSString *query = [NSString stringWithFormat:@"delete from noteWithMap where id  = %d" , idx];
    [SQLiteAccess deleteWithSQL:query];
}
@end
