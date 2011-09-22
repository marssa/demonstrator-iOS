//
//  FirstViewController.m
//  DemonstratorIOOS2011
//
//  Created by zak borg on 18/09/2011.
//  Copyright 2011 Intellimare Ltd. All rights reserved.
//

#import "FirstViewController.h"
#import "ASIHTTPRequest.h";
#import "ASIFormDataRequest.h";

@implementation FirstViewController
@synthesize RudderAngleGauge,RPMLabel;

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    myTimer = [[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES]retain];
	
}

-(void) onTimer:(NSTimer *)theTimer 
{
	NSURL *url = [NSURL URLWithString:@"http://localhost:8182/motionControlPage/rudderAndSpeed/"];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSString *responseString =  [request responseString];
    NSArray  *stringComponents = [responseString componentsSeparatedByString:@"@"];
    NSString* RPM = [stringComponents objectAtIndex: 0];
    NSString* Angle = [stringComponents objectAtIndex: 1];
	
    int RPMValue = [RPM doubleValue];
    int AngleValue = [Angle doubleValue];
	//BatteryVoltages.text =[NSString stringWithFormat:@"%1.1fV",response];
	RudderAngleGauge.progress=AngleValue;
    RPMLabel.text = RPM;
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
}

- (void)sendEngineDataREST:(NSString *)engineRPM {
	
	//NSString *engineOutput = [NSString stringWithFormat:@"%.0f",engineRPM];
	
    
	NSString *urlString = [NSString stringWithFormat:@"http://192.168.2.20:8182/motor/speed/%@",engineRPM];
	NSURL *url = [NSURL URLWithString:urlString];
	
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
    
}
- (void)sendRudderDataREST:(NSString *)rudderAngle {
	
	NSString *rudderOutputAngle = [NSString stringWithFormat:@"%.0f",rudderAngle];
	
    
	NSString *urlString = [NSString stringWithFormat:@"http://192.168.2.20:8182/rudders/rotate/%@",rudderAngle];
	NSURL *url = [NSURL URLWithString:urlString];
	
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
    
}

-(IBAction)rudderPort{
    [self sendRudderDataREST:@"True"];
}
-(IBAction)rudderFullPort{
     [self sendRudderDataREST:@"-45"];
}
-(IBAction)rudderStarboard{
    [self sendRudderDataREST:@"False"];
}
-(IBAction)rudderFullStarboard{
    [self sendRudderDataREST:@"+45"];
}

-(IBAction)increaseRpm{
    NSString *plusTen = @"Increase";
    [self sendEngineDataREST:plusTen];
}
-(IBAction)increaseFullRpm{
[self sendRudderDataREST:@"+100"];
}
-(IBAction)decreaseFullRpm{
[self sendRudderDataREST:@"-100"];
}
-(IBAction)decreaseRpm{
    [self sendEngineDataREST:@"Decrease"];
}
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
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

- (void)dealloc {
	[self stopTimer];
    [super dealloc];
}

@end
