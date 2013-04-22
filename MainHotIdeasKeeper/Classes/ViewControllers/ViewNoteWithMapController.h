//
//  ViewNoteWithMapController.h
//  MainHotIdeasKeeper
//
//  Created by Alexandr Kolesnik on 22.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface ViewNoteWithMapController : UIViewController <UITableViewDataSource , UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *notesArray;




@end
