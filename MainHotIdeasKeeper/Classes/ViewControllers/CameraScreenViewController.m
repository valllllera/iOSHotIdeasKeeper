//
//  CameraScreenViewController.m
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "CameraScreenViewController.h"
@interface CameraScreenViewController ()

@end

@implementation CameraScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _images = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.images = [NSMutableArray array];
    
    UIBarButtonItem *photoItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePhoto)];
    self.navigationItem.rightBarButtonItem = photoItem;
    
    UISegmentedControl *contentPiacker = [[UISegmentedControl alloc] initWithItems:@[@"Image",@"Video"]];
    contentPiacker.selectedSegmentIndex = 0;
    contentPiacker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    contentPiacker.segmentedControlStyle = UISegmentedControlStyleBar;
    contentPiacker.frame = CGRectMake(0.0f, 0.0f, 180.0f, 30.0f);
    
    self.navigationItem.titleView = contentPiacker;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *pickedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if (pickedImage) {
        [self.images addObject:pickedImage];
    }
    
    NSURL *videoURL = [info objectForKey:@"UIImagePickerControllerMediaURL"];
    if (videoURL) {
        [self.images addObject:videoURL];
    }
    
    [picker dismissModalViewControllerAnimated:YES];
        
    [self.mediaTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    cell.imageView.image = [self.images objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Image %i", indexPath.row+1];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id item = [self.images objectAtIndex:indexPath.row];
    if ([item isKindOfClass:[UIImage class]]) {
        UIImageWriteToSavedPhotosAlbum(item, nil, nil, nil);
    } else {
        MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:item];
        [self presentMoviePlayerViewControllerAnimated:player];
        
        ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
        [library writeVideoAtPathToSavedPhotosAlbum:item
                                    completionBlock:^(NSURL *assetURL, NSError *error) {
                                        NSLog(@"Video Saved");
                                    }];
    }
}
- (void)viewDidUnload {
    [self setMediaTable:nil];
    [super viewDidUnload];
}

- (void)takePhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    UISegmentedControl *contentPiacker = (UISegmentedControl*)self.navigationItem.titleView;
    if (contentPiacker.selectedSegmentIndex) {
        picker.mediaTypes = @[(NSString *)kUTTypeMovie];
    }
    
    [self presentModalViewController:picker animated:YES];
}
@end
