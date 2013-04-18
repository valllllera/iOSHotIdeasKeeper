//
//  ViewNotesViewController.h
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface ViewNotesViewController : UIViewController<UITableViewDataSource, UITabBarDelegate>
{

}

@property(nonatomic, retain) NSMutableArray *notesArray;
@property (nonatomic, retain) IBOutlet UITableView *mainNotesTable;
@property (nonatomic, retain) Note *note;

@end
