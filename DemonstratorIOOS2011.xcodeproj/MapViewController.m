//
//  MapViewController.m
//  DemonstratorIOOS2011
//
//  Created by zak borg on 20/09/2011.
//  Copyright 2011 Intellimare Ltd. All rights reserved.
//

#import "MapViewController.h"
#import "AddressAnnotation.h"
#import <MapKit/MapKit.h>
#import "ASIHTTPRequest.h";
#import "ASIFormDataRequest.h";
#import "SBJson.h"//;

@implementation MapViewController
@synthesize mapView;

CLLocationCoordinate2D abc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    myTimer = [[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES]retain];
	
}
-(void) onTimer:(NSTimer *)theTimer 
{
	NSURL *url = [NSURL URLWithString:@"http://192.168.2.3:8182/navigationPage/gps"];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSString *responseString =  [request responseString];
    NSDictionary *json = [responseString JSONValue];
    NSString *login = [json objectForKey:@"NavLights"];
    NSString *latin = [json objectForKey:@"underwaterLights"];
    
    double log = [login doubleValue];
    double lat = [latin doubleValue];
    
    CLLocationCoordinate2D coordPosition = {.latitude= log, .longitude= lat};
    AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:coordPosition];
    [mapView addAnnotation:addAnnotation];
    [addAnnotation release];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType = MKMapTypeSatellite;
    
    CLLocationCoordinate2D coord = {.latitude= 35.889000, .longitude= 14.519000};
    MKCoordinateSpan span = {.latitudeDelta= 0.004, .longitudeDelta= 0.004};
    MKCoordinateRegion region = {coord, span};
    
    
	/*abc.latitude = 35.889000;
	abc.longitude =14.519000;
    
    AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:abc];
    [mapView addAnnotation:addAnnotation];
    [addAnnotation release];*/
    
    [mapView setRegion:region];
    // Do any additional setup after loading the view from its nib.
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
}

- (void)viewDidUnload {
    [self stopTimer];
}
- (void)stopTimer
{
	[myTimer invalidate];
	[myTimer release];
	//myTimer =nil;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stopTimer];
}
  

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc {
	[self stopTimer];
    [super dealloc];
}

@end
