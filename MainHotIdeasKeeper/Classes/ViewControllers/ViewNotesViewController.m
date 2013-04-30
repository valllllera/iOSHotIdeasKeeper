//
//  ViewNotesViewController.m
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "ViewNotesViewController.h"
#import "NotesScreenViewController.h"
#import "DataManager.h"
#import "NotesCell.h"
#import "NSString+ExtString.h"
#import "NSDate+ExtDate.h"
#import "NVSlideMenuController.h"
#import "AddNoteWithPhotoViewController.h"

@interface ViewNotesViewController ()

@end

@implementation ViewNotesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Заметки", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIButton *menuButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu_button_background.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self.slideMenuController action:@selector(toggleMenuAnimated:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuButton];
    edit=[[UIBarButtonItem alloc]initWithTitle:@"Edit"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                        action:@selector(editing)];
    

    [edit setBackgroundImage:[UIImage imageNamed:@"button_item_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.rightBarButtonItem = edit;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMainNotesTable:nil];
    [super viewDidUnload];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_notesArray count];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    
    [[DataManager sharedInstance]  getNotesWithSucces:^(NSMutableArray *notes)
     {
         
         self.notesArray = notes;

         
         [_mainNotesTable reloadData];
         
     }
         failture:^(NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc]
                                   initWithTitle:@"Error" message:@"Не получилось загрузить данные" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles: nil];
         [alertView show];
     }];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Note *note = [_notesArray objectAtIndex:indexPath.row];
    if ([note.imageUrlPath isEqualToString:@"nil"])
    {
        NotesScreenViewController *notesScreenViewController = [[NotesScreenViewController alloc]initWithNote:[_notesArray objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:notesScreenViewController animated:YES];
    }
    else
    {
        AddNoteWithPhotoViewController *addNote = [[AddNoteWithPhotoViewController alloc]initWithNote:note];
        [self.navigationController pushViewController:addNote animated:YES];
                                                   
    }
    
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [_notesArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note *noteInArray = [_notesArray objectAtIndex:indexPath.row];
        [[DataManager sharedInstance] deleteNote:[noteInArray.idx integerValue]];
        [_notesArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (void)editing {
    
    [self.mainNotesTable setEditing:!self.mainNotesTable.editing animated:YES];
    
    if (self.mainNotesTable.editing)
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    else
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 94;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NotesCell";
    
    NotesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NotesCell" owner:nil options:nil]objectAtIndex:0];
    }
    Note *noteInArray = [_notesArray objectAtIndex:indexPath.row];

    

    cell.noteTextLabel.text = noteInArray.noteText;

    cell.dateLabel.text = [noteInArray.date formatStringFromDb];
    
    if ([noteInArray.imageUrlPath isEqualToString:@"nil"])
    {
        cell.imageForNote.image = [UIImage imageNamed:@"v_icon.png"];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
        {
            CGImageRef iref = [myasset thumbnail];
            UIImage *largeimage = [UIImage imageWithCGImage:iref];
            dispatch_async(dispatch_get_main_queue(), ^{
            if (iref) {
                
                cell.imageForNote.image = largeimage;
            }
            else
                cell.imageForNote.image = [UIImage imageNamed:@"v_icon.png"];
            });
                
        };
        
        
        ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
        {
            NSLog(@"booya, cant get image - %@",[myerror localizedDescription]);
        };
        
        if(noteInArray.imageUrlPath)
        {
            NSURL *imageUrl = [NSURL URLWithString:noteInArray.imageUrlPath];
            ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
            [assetslibrary assetForURL: imageUrl
                           resultBlock:resultblock
                          failureBlock:failureblock];
        }
        
        NSURL *imageUrl = [NSURL URLWithString:noteInArray.imageUrlPath];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        cell.imageForNote.image = [UIImage imageWithData:imageData];
        });
    }
    
    
    return cell;
}

@end
