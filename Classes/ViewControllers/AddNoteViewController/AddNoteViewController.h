//
//  AddNotesViewController.h
//  TaskNotifier
//
//  Created by Vlad Polupan - iOS on 16.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface AddNoteViewController : UIViewController
{
    NSArray *dataHourse;
}


@property (retain, nonatomic) IBOutlet UITextField *notesNameTextField;
@property (retain, nonatomic) IBOutlet UITextView *shortDescribeTextView;
@property (retain, nonatomic) IBOutlet UILabel *insertDayLabel;
@property (retain, nonatomic) IBOutlet UILabel *insertMonthLabel;
@property (retain, nonatomic) IBOutlet UILabel *insertYearLabel;
@property (retain, nonatomic) IBOutlet UILabel *priorityLabel;
@property (retain, nonatomic) IBOutlet UIButton *redPriorityButtonPressed;
@property (retain, nonatomic) IBOutlet UIButton *yellowPriorityButtonPressed;
@property (retain, nonatomic) IBOutlet UIButton *greenPriorityButtonPressed;
@property (retain, nonatomic) IBOutlet UIButton *greyPriorityButtonPressed;
@property (retain, nonatomic) IBOutlet UILabel *addPlaceOnMapLabel;
@property (retain, nonatomic) IBOutlet UIButton *addPlaceOnMapButtonPressed;
@property (retain, nonatomic) IBOutlet MKMapView *placeOnMap;
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)redPriorityPressed:(id)sender;
- (IBAction)yellowPriorityPressed:(id)sender;
- (IBAction)greenPriorityPressed:(id)sender;
- (IBAction)greyPriorityPressed:(id)sender;
- (IBAction)addMapButtonPressed:(id)sender;
- (IBAction)insertHourButton:(id)sender;
- (IBAction)insertMinuteButton:(id)sender;
- (IBAction)insertDayButton:(id)sender;
- (IBAction)insertMonthButton:(id)sender;
- (IBAction)insertYearButton:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *hourLabel;
@property (retain, nonatomic) IBOutlet UILabel *minuteLabel;
@property (retain, nonatomic) IBOutlet UIButton *dayButton;
@property (retain, nonatomic) IBOutlet UIButton *monthButton;
@property (retain, nonatomic) IBOutlet UIButton *yearButton;
@property (assign , nonatomic) NSInteger prioritet;
@property (retain, nonatomic) IBOutlet UILabel *remindLabel;
@property (assign,nonatomic) int remind;
- (IBAction)remindButtonPressed:(id)sender;

@property (nonatomic, retain) Remember *activeNote;
@property (nonatomic , assign) BOOL flagView;
@property (nonatomic , assign) BOOL flagButton;
@property (retain, nonatomic) IBOutlet UIButton *hourButtonOutlet;


- (id)initWithNote:(Remember *)note;



@end


