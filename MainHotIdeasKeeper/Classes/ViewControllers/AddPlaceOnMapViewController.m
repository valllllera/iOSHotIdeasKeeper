//
//  AddPlaceOnMapViewController.m
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "AddPlaceOnMapViewController.h"
#import "DataManager.h"
#import "Note.h"
#import "ViewNoteWithMapController.h"
#import "NVSlideMenuController.h"
#import "MainScreenViewController.h"
#import "ViewNoteWithMapController.h"

@interface AddPlaceOnMapViewController ()

@end

@implementation AddPlaceOnMapViewController

@synthesize locationManager;
@synthesize geoCoder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Геозаметка", nil);
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
        self.mapButton.selected = YES;
        
    }
    return self;
}

-(id)initWithNote:(Note *)note
{
    self =  [super init];
    if (self)
    {
        self.note = note;
        self.flagView = YES;
    }
    return  self;
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
    [self setNoteTextView:nil];
    [self setScrollView:nil];
    [self setMapButton:nil];
    [self setSitButton:nil];
    [self setHibridButton:nil];
    [self setScrollView:nil];
    [self setSaveButton:nil];
    [super viewDidUnload];
    self.map = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_map.showsUserLocation = YES;
    
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
    locationManager.delegate = self;
    self.mapButton.selected = YES;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self fixButton:_saveButton];
    [self fixButton:_mapButton];
    [self fixButton:_sitButton];
    [self fixButton:_saveButton];
    
    
    _scrollView.contentSize = CGSizeMake(320, 408);
    if (_note)
    {
        _noteTextView.text = _note.noteText;
        
        mapAnnotation = [Annotation new];
        mapAnnotation.title = @"My point";
        mapAnnotation.subtitle = @"Place";
        mapAnnotation.coordinate = CLLocationCoordinate2DMake([_note.x floatValue], [_note.y floatValue]);
        [_map addAnnotation:mapAnnotation];
    
        
        CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake([_note.x floatValue], [_note.y floatValue]);
        MKCoordinateRegion adjustedRegion = [_map regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 10000, 10000)];
        [_map setRegion:adjustedRegion animated:YES];
        
        
        
    }
    else
    {
        [_map setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    }
    
    
    UIBarButtonItem *homeNaviButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"home_navi_button_bg.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(homeNaviButton:)];
    
    [homeNaviButton setBackgroundImage:[UIImage imageNamed:@"navi_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = homeNaviButton;
    
    self.slideMenuController.panGestureEnabled = NO;

}



- (void)keyboardWasShown:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, IS_IPHONE_5 ? keyboardSize.height + 100 : keyboardSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, _noteTextView.frame.origin) )
    {
        CGPoint scrollPoint = CGPointMake(0.0, _noteTextView.frame.origin.y - (keyboardSize.height-15));
        [_scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void) keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
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

    self.mapButton.selected = YES;
    self.sitButton.selected = NO;
    self.hibridButton.selected = NO;
    
    _map.mapType = MKMapTypeStandard;
}

- (IBAction)satelliteButtonPressed:(id)sender {

    self.sitButton.selected = YES;
    self.mapButton.selected = NO;
    self.hibridButton.selected = NO;
    _map.mapType = MKMapTypeSatellite;
}

- (IBAction)hybridButtonPressed:(id)sender {

    self.hibridButton.selected = YES;
    self.sitButton.selected = NO;
    self.mapButton.selected = NO;
    _map.mapType = MKMapTypeHybrid;
}

- (void)mapTapped:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:_map];
    CLLocationCoordinate2D coorditate = [_map convertPoint:point toCoordinateFromView:_map];
    
    NSLog(@"long: %f, lat: %f", coorditate.longitude, coorditate.latitude);
    

    
    if(mapAnnotation)
    {
        [_map removeAnnotation:mapAnnotation];
    }
    mapAnnotation = [Annotation new];
    mapAnnotation.title = @"Точка";
    mapAnnotation.coordinate = coorditate;
    [_map addAnnotation:mapAnnotation];
   
    newLocation = [[CLLocation alloc]initWithLatitude:mapAnnotation.coordinate.latitude longitude:mapAnnotation.coordinate.longitude];
    [self getPlacemakerAdress:newLocation withSuccess:^(NSString *adress) {
        
        mapAnnotation.subtitle = adress;
    }];

     [_map addAnnotation:mapAnnotation];
    x = mapAnnotation.coordinate.latitude;
    y = mapAnnotation.coordinate.longitude;
}

- (IBAction)savePlaceButtonPressed:(id)sender
{
    if (_flagView == NO)
    {
        _note = [[Note alloc]init];
        self.note.noteText = _noteTextView.text;
        self.note.x = [NSNumber numberWithFloat:x];
        self.note.y = [NSNumber numberWithFloat:y];
        [[DataManager sharedInstance] saveNewNoteWithMap:_note];
        ViewNoteWithMapController *viewNotesViewController = [[ViewNoteWithMapController alloc]init];
        [self.slideMenuController setContentViewController:[[UINavigationController alloc] initWithRootViewController:viewNotesViewController] animated:YES completion:nil];
    }
    else
    {
        self.note.noteText = _noteTextView.text;
        self.note.x = [NSNumber numberWithFloat: x];
        self.note.y = [NSNumber numberWithFloat: y];

        [[DataManager sharedInstance] updateNewNoteWithMap:_note];
        ViewNoteWithMapController *viewNotesViewController = [[ViewNoteWithMapController alloc]init];
        [self.slideMenuController setContentViewController:[[UINavigationController alloc] initWithRootViewController:viewNotesViewController] animated:YES completion:nil];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}


- (void)getPlacemakerAdress:(CLLocation *)location
             withSuccess:(void (^)(NSString *adress))success
{

    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            
            NSString *subThoroughfare;
            if (placemark.subThoroughfare == nil)
                subThoroughfare = @"";
            else
                subThoroughfare = placemark.subThoroughfare;
            
            NSString *locality;
            if (placemark.locality == nil)
                locality = @"";
            else
                locality = placemark.locality;
            
            NSString *thoroughfare;
            if (placemark.thoroughfare == nil)
                thoroughfare = @"";
            else
                thoroughfare = placemark.thoroughfare;
            
            NSString *administrativeArea;
            if (placemark.administrativeArea == nil)
                administrativeArea = @"";
            else
                administrativeArea = placemark.administrativeArea;
            
            NSString *country;
            if (placemark.country == nil)
                country = @"";
            else
                country = placemark.country ;
            
            NSString *adress = [NSString stringWithFormat:@"%@ %@\n %@\n%@\n%@",
                                subThoroughfare, thoroughfare,
                                locality,
                                administrativeArea,
                                country];
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

-(IBAction)homeNaviButton:(id)sender
{
    ViewNoteWithMapController *viewNotesWithMapController = [[ViewNoteWithMapController alloc]init];
    [UIView animateWithDuration:0.75
                     animations:^{
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                         [self.navigationController pushViewController:viewNotesWithMapController animated:NO];
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                     }];}

- (void)fixButton:(UIButton *)button
{
    [button setBackgroundImage:[[button backgroundImageForState:UIControlStateNormal] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)] forState:UIControlStateNormal];
    [button setBackgroundImage:[[button backgroundImageForState:UIControlStateHighlighted] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)] forState:UIControlStateHighlighted];
}

@end