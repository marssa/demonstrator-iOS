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
    myTimer = [[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES]retain];
	
}

-(void) onTimer:(NSTimer *)theTimer 
{
	NSURL *url = [NSURL URLWithString:@"http://stratus.mise:4567/getVoltage"];
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
	
	NSString *engineOutput = [NSString stringWithFormat:@"%.0f",engineRPM];
	
    
	NSString *urlString = [NSString stringWithFormat:@"http://stratus.mise:4567/setEngineThrust/%@",engineOutput];
	NSURL *url = [NSURL URLWithString:urlString];
	
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
    
}
- (void)sendRudderDataREST:(NSString *)rudderAngle {
	
	NSString *rudderOutputAngle = [NSString stringWithFormat:@"%.0f",rudderAngle];
	
    
	NSString *urlString = [NSString stringWithFormat:@"http://stratus.mise:4567/setEngineThrust/%@",rudderOutputAngle];
	NSURL *url = [NSURL URLWithString:urlString];
	
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
    
}

-(IBAction)rudderPort{
    NSString *plusFiveDeg = @"5";
    [self sendRudderDataREST:plusFiveDeg];
}
-(IBAction)rudderStarboard{
    NSString *minusFiveDeg = @"5";
    [self sendRudderDataREST:minusFiveDeg];
}

-(IBAction)increaseRpm{
    NSString *plusTen = @"10";
    [self sendEngineDataREST:plusTen];
}
-(IBAction)decreaseRpm{
    [self sendEngineDataREST:@"-10"];
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


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
}

@end
