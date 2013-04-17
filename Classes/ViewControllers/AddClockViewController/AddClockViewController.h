//
//  AddClockViewController.h
//  Clock
//
//  Created by Savva on 12.03.13.
//  Copyright (c) 2013 iOS - Evgeniy Lipskiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Clock.h"
#import "PageAlarmClockViewController.h"
typedef enum
{
    Monday = 1,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday,
    Sunday
} DayOfWeek;

typedef enum
{
    Five = 8,
    Ten,
    Fiveteen
}TimeRepeat;

@interface AddClockViewController : UIViewController <UITextViewDelegate>
{
    //IBOutlet UITextField *clockNameTextField;
    //IBOutlet UITextField *clockDescriptionTextField;
    IBOutlet UILabel *repeate1TextLabel;
    IBOutlet UILabel *repeate2TextLabel;
    IBOutlet UILabel *soundNameLabel;
    IBOutlet UILabel *mediaNameLabel;
    PageAlarmClockViewController *pageAlarmClockViewController;
}
-(id)initWithClock :(Clock *)clock;
@property (assign, nonatomic) NSInteger value;
@property (retain, nonatomic) IBOutlet UIButton *mondayButton;
@property (retain, nonatomic) IBOutlet UIButton *tuesdayButton;
@property (retain, nonatomic) IBOutlet UIButton *wednesdayButton;
@property (retain, nonatomic) IBOutlet UIButton *thursdayButton;
@property (retain, nonatomic) IBOutlet UIButton *saturdayButton;
@property (retain, nonatomic) IBOutlet UIButton *fridayButton;
@property (retain, nonatomic) IBOutlet UIButton *sundayButton;
@property(nonatomic, assign)NSMutableArray *timeRepeatArray;
@property(nonatomic, assign)NSMutableArray *dayArray;
@property (assign,nonatomic) int mon;
@property (assign,nonatomic) int tue;
@property (assign,nonatomic) int wed;
@property (assign,nonatomic) int thu;
@property (assign,nonatomic) int fri;
@property (assign,nonatomic) int sat;
@property (assign,nonatomic) int sun;
@property (assign,nonatomic) int remind;
- (IBAction)allDayButtonPressed:(id)sender;
- (IBAction)standartSoundButtonPressed:(id)sender;
- (IBAction)mediaSoundButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)hourButtonPressed:(id)sender;
- (IBAction)minuteButtonPressed:(id)sender;
- (IBAction)mondayButtonPressed:(id)sender;
- (IBAction)tuesdayButtonPressed:(id)sender;
- (IBAction)wednesdayButtonPressed:(id)sender;
- (IBAction)thursdayButtonPressed:(id)sender;
- (IBAction)fridayButtonPressed:(id)sender;
- (IBAction)saturdayButtonPressed:(id)sender;
- (IBAction)sundayButtonPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *minuteLabel;
@property (retain, nonatomic) IBOutlet UILabel *hourLabel;
@property (retain, nonatomic) IBOutlet UITextField *clockNameTextField;
@property (retain,nonatomic)  IBOutlet UITextView *clockDescriptionTextField;

@property (nonatomic, retain) Clock *activeClock;
- (IBAction)remindFive:(id)sender;
- (IBAction)remindTen:(id)sender;
- (IBAction)remindFiv:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *remindFiveButton;
@property (retain, nonatomic) IBOutlet UIButton *remindTenButton;
@property (retain, nonatomic) IBOutlet UIButton *remindFivButton;

@property (assign,nonatomic) BOOL flagView;


@end
