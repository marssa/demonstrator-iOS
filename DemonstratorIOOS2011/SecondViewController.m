//
//  SecondViewController.m
//  DemonstratorIOOS2011
//
//  Created by zak borg on 18/09/2011.
//  Copyright 2011 Intellimare Ltd. All rights reserved.
//

#import "SecondViewController.h"
#import "ASIHTTPRequest.h";
#import "ASIFormDataRequest.h";

@implementation SecondViewController
@synthesize navLightPort,navLightStarboard,navLightStern,underWaterLights,navLightsSwitch,underwaterLightsSwitch;

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
    NSString* navLightStatus = [stringComponents objectAtIndex: 0];
    NSString* underwaterLightStatus = [stringComponents objectAtIndex: 1];
	if([navLightStatus isEqualToString:@"Off"])
    {
        navLightPort.hidden = YES;
        navLightStarboard.hidden =YES;
        navLightStern.hidden =YES;
        [navLightsSwitch setOn:NO animated:YES];

        
    }
    else
    {
        navLightPort.hidden = NO;
        navLightStarboard.hidden =NO;
        navLightStern.hidden =NO;
        [navLightsSwitch setOn:YES animated:YES];
       
    }
   
	if([underwaterLightStatus isEqualToString:@"Off"])
    {
        underWaterLights.hidden = YES;
        [underwaterLightsSwitch setOn:NO animated:YES];
    }
    else
    {
        underWaterLights.hidden = NO;
        [underwaterLightsSwitch setOn:YES animated:YES];
    }

    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
}

- (void)sendNavLightsDataREST:(NSString *)NavLights {
	
	 
	NSString *urlString = [NSString stringWithFormat:@"http://stratus.mise:4567/setEngineThrust/%@",NavLights];
	NSURL *url = [NSURL URLWithString:urlString];
	
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
    
}
- (void)sendUnderwaterLightsDataREST:(NSString *)UnderwaterLights {
	
	   
	NSString *urlString = [NSString stringWithFormat:@"http://stratus.mise:4567/setEngineThrust/%@",UnderwaterLights];
	NSURL *url = [NSURL URLWithString:urlString];
	
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
    
}

-(IBAction)navLights{
    if(navLightsSwitch.on)
    {
        navLightPort.hidden = YES;
        navLightStarboard.hidden =YES;
        navLightStern.hidden =YES;
        [self sendNavLightsDataREST:@"Off"];
    }
    else
    {
        navLightPort.hidden = NO;
        navLightStarboard.hidden =NO;
        navLightStern.hidden =NO;
        [self sendNavLightsDataREST:@"On"];
    }
    
}
-(IBAction)underwaterLights{
    if(underwaterLightsSwitch.on)
    {
        underWaterLights.hidden = YES;
        [self sendUnderwaterLightsDataREST:@"T"];
    }
    else
    {
         underWaterLights.hidden = NO;
         [self sendUnderwaterLightsDataREST:@"T"];
    }
    NSString *minusFiveDeg = @"5";
    
}


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
