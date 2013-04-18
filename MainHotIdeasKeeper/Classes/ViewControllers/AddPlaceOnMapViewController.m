//
//  AddPlaceOnMapViewController.m
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "AddPlaceOnMapViewController.h"

@interface AddPlaceOnMapViewController ()

@end

@implementation AddPlaceOnMapViewController

@synthesize map;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

static float x;
static float y;

+(float)GetX
{
    NSLog(@"%f", x);
    return x;
}

+(float)GetY
{
    NSLog(@"%f", y);
    return y;
}

- (void)viewDidLoad
{
    map.showsUserLocation = YES;
    [map setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapTapped:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:map];
    
    CLLocationCoordinate2D coorditate = [map convertPoint:point toCoordinateFromView:map];
    
    NSLog(@"long: %f, lat: %f", coorditate.longitude, coorditate.latitude);
    
    x = coorditate.latitude;
    y = coorditate.longitude;
    
}

- (void)viewDidUnload {
    [self setMap:nil];
    [super viewDidUnload];
}
- (IBAction)mapButtonPressed:(id)sender {
    map.mapType = MKMapTypeStandard;
}

- (IBAction)satelliteButtonPressed:(id)sender {
    map.mapType = MKMapTypeSatellite;
}

- (IBAction)hybridButtonPressed:(id)sender {
    map.mapType = MKMapTypeHybrid;
}

- (IBAction)saveButtonPressed:(id)sender {
    
}
@end
