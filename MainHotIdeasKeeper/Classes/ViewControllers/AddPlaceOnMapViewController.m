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

@synthesize locationManager;
@synthesize geoCoder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"";
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
    [self setLocationManager:nil];
    [self setGeoCoder:nil];
    self.map = nil;
}

- (void)viewDidUnload
{
    [self setLocationManager:nil];
    [self setGeoCoder:nil];
    [super viewDidUnload];
    self.map = nil;
    locationManager.delegate=self;
    [locationManager startUpdatingLocation];
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
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
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

- (IBAction)satelliteButtonPressed:(id)sender {
    _map.mapType = MKMapTypeSatellite;
}

- (IBAction)hybridButtonPressed:(id)sender {
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
}

- (IBAction)savePlaceButtonPressed:(id)sender
{
    NSLog(@"1");
    [self.geoCoder reverseGeocodeLocation: locationManager.location completionHandler:
     ^(NSArray *placemarks, NSError *error)
    {
        NSLog(@"2");
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         NSLog(@"I am currently at %@",locatedAt);
     }];
}

@end