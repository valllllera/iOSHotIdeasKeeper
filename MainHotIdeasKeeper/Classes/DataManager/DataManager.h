//
//  DataManager.h
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@interface DataManager : NSObject

@property (nonatomic, retain) NSMutableArray *notes;


+ (DataManager *)sharedInstance;

- (void)getNotesWithSucces:(void (^)(NSMutableArray *notes))success
                  failture:(void (^)(NSError *error))failture;
- (void)getNotesMapWithSucces:(void (^)(NSMutableArray *notes))success
                     failture:(void (^)(NSError *error))failture;

-(void)saveNewNote:(Note*)note;
-(void)updateNewNote:(Note *)note;
-(void)saveNewNoteWithMap:(Note *)note;
-(void)updateNewNoteWithMap:(Note *)note;
-(void)deleteNoteWithMap:(NSInteger )idx;
-(void)deleteNote : (NSInteger )idx;

@end
