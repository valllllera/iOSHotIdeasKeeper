//
//  ViewNoteWithMapController.h
//  MainHotIdeasKeeper
//
//  Created by Alexandr Kolesnik on 22.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewNoteWithMapController : UIViewController <UITableViewDataSource , UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, retain) NSMutableArray *notesArray;

//@property(strong , nonatomic)

@end
