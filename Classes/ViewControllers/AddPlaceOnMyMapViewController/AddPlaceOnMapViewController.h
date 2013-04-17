//
//  ViewController.h
//  MapExample
//
//  Created by Alximik on 16.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"

@interface AddPlaceOnMapViewController : UIViewController <MKAnnotation>
{
    Annotation *mapAnnotation;
    
}
@property (retain, nonatomic) IBOutlet UIButton *savePlaceOnMapButton;
@property (nonatomic, retain) IBOutlet MKMapView *map;

- (IBAction)mapButtonPressed:(id)sender;
- (IBAction)sputnikButtonPressed:(id)sender;
- (IBAction)hibridButtonPressed:(id)sender;
- (IBAction)mapTapped:(UITapGestureRecognizer *)recognizer;
- (IBAction)savePlaceButtonPressed:(id)sender;

+(float)GetX;
+(float)GetY;
@end
