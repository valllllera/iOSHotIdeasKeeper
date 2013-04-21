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
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.map = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_map.showsUserLocation = YES;
    [_map setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    

}




- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if (annotation == mapView.userLocation) {
        return nil;
    }

    static NSString* annotationIdentifier = @"annotationIdentifier";
    _annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
    if (!_annotationView)
    {
        _annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
        
        if([[annotation title] isEqualToString:@"Annotation1"]) {
            [_annotationView setPinColor:MKPinAnnotationColorRed];
        }
        else
        {
            [_annotationView setPinColor:MKPinAnnotationColorGreen];
            _annotationView.animatesDrop = YES;
            _annotationView.canShowCallout = YES;
        }
    }
    
    return _annotationView;
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
    mapAnnotation.title = @"Точка";
    NSLog(@"%@", _locationString);
    mapAnnotation.coordinate = coorditate;
    [_map addAnnotation:mapAnnotation];
    NSLog(@"%f %f",mapAnnotation.coordinate.longitude , mapAnnotation.coordinate.latitude);
     CLLocation *newwLocation = [[CLLocation alloc]initWithLatitude:mapAnnotation.coordinate.latitude longitude:mapAnnotation.coordinate.longitude];
    [self getPlacemakerAdress:newwLocation withSuccess:^(NSString *adress) {
        
        NSLog(@"adress %@", adress);
        mapAnnotation.subtitle = adress;
    }];

     [_map addAnnotation:mapAnnotation];
}

- (IBAction)savePlaceButtonPressed:(id)sender
{
   
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
}

- (void)getPlacemakerAdress:(CLLocation *)location
             withSuccess:(void (^)(NSString *adress))success
{
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            NSString *adress = [NSString stringWithFormat:@"%@ %@\n %@\n%@\n%@",
                               placemark.subThoroughfare, placemark.thoroughfare,
                               placemark.locality,
                               placemark.administrativeArea,
                               placemark.country];
            if(success)
            {
                success(adress);
            }
        } else {
            NSLog(@"%@", error.debugDescription);
            if(success)
            {
                success(nil);
            }
        }
    }];
}

@end