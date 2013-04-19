//
//  AddPlaceOnMapViewController.h
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import <CoreLocation/CoreLocation.h>

@interface AddPlaceOnMapViewController : UIViewController <MKAnnotation, CLLocationManagerDelegate>
{
    Annotation *mapAnnotation;
}

@property (nonatomic, retain) IBOutlet MKMapView *map;
@property (strong, nonatomic) IBOutlet CLGeocoder *geoCoder;
@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;
@property (strong, nonatomic) MKPinAnnotationView *annotationView;

- (IBAction)mapButtonPressed:(id)sender;
- (IBAction)satelliteButtonPressed:(id)sender;
- (IBAction)hybridButtonPressed:(id)sender;
- (IBAction)mapTapped:(UITapGestureRecognizer *)recognizer;
- (IBAction)savePlaceButtonPressed:(id)sender;

+(float)GetX;
+(float)GetY;
@end
