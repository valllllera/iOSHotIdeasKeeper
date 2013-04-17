//
//  ViewController.m
//  MapExample
//
//  Created by Alximik on 16.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AddPlaceOnMapViewController.h"

@implementation AddPlaceOnMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Map";
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        editButton.frame = CGRectMake(0, 0, 50, 31);
        [editButton setTitle:@"Back" forState:UIControlStateNormal];
        [editButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [editButton setBackgroundImage:[UIImage imageNamed:@"edit_button_backround.png"] forState:UIControlStateNormal];
        [editButton setTitleColor:[UIColor blackColor] forState:normal];
        [editButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:editButton] autorelease];
    }
    return self;
}

static float x;
static float y;

+(float)GetX
{
    return x;
}

+(float)GetY
{
    return y;
}

- (void)dealloc
{
    self.map = nil;
    [_savePlaceOnMapButton release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setSavePlaceOnMapButton:nil];
    [super viewDidUnload];
    self.map = nil;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	_map.showsUserLocation = YES;
    [_map setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if (annotation == mapView.userLocation) {
        return nil;
    }
    
    
    
    static NSString* annotationIdentifier = @"annotationIdentifier";
    MKPinAnnotationView* annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
    if (!annotationView) {
        annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:nil] autorelease];
        if([[annotation title] isEqualToString:@"Annotation1"]) {
            [annotationView setPinColor:MKPinAnnotationColorRed];
        } else {
            [annotationView setPinColor:MKPinAnnotationColorGreen];
            annotationView.animatesDrop = YES;
            annotationView.canShowCallout = YES;
        }
    }
    
    return annotationView;
}

- (IBAction)mapButtonPressed:(id)sender {
    _map.mapType = MKMapTypeStandard;
}

- (IBAction)sputnikButtonPressed:(id)sender {
    _map.mapType = MKMapTypeSatellite;
}

- (IBAction)hibridButtonPressed:(id)sender {
    _map.mapType = MKMapTypeHybrid;
}

- (void)mapTapped:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:_map];
    
    CLLocationCoordinate2D coorditate = [_map convertPoint:point toCoordinateFromView:_map];
    
    NSLog(@"long: %f, lat: %f", coorditate.longitude, coorditate.latitude);
    
    x = coorditate.latitude;
    y = coorditate.longitude;
    
    if(mapAnnotation)
    {
        [_map removeAnnotation:mapAnnotation];
    }
    mapAnnotation = [Annotation new];
    mapAnnotation.title = @"Место";
    mapAnnotation.subtitle = @"Здесь вы должны быть";
    mapAnnotation.coordinate = coorditate;
    [_map addAnnotation:mapAnnotation];
    [mapAnnotation release];
}

- (IBAction)savePlaceButtonPressed:(id)sender {
}


- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
