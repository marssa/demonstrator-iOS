//
//  SecondViewController.m
//  DemonstratorIOOS2011
//
//  Created by zak borg on 18/09/2011.
//  Copyright 2011 Intellimare Ltd. All rights reserved.
//

#import "SecondViewController.h"
#import "ASIHTTPRequest.h"//;
#import "ASIFormDataRequest.h"//;
#import "SBJson.h"//;

@implementation SecondViewController
@synthesize navLightPort,navLightStarboard,navLightStern,underWaterLights,navLightsSwitch,underwaterLightsSwitch;

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    myTimer = [[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES]retain];
	
}

-(void) onTimer:(NSTimer *)theTimer 
{
	NSURL *url = [NSURL URLWithString:@"http://192.168.2.3:8182/lightpage/statusAll"];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSString *responseString =  [request responseString];
    NSDictionary *json = [responseString JSONValue];
    NSString *navLights = [json objectForKey:@"NavLights"];
    NSString *underwaterLights = [json objectForKey:@"underwaterLights"];
    
    if([navLights isEqualToString:@"False"])
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

    /*NSArray  *stringComponents = [responseString componentsSeparatedByString:@"@"];
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
    }*/

    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
}

- (void)sendNavLightsDataREST:(NSString *)NavLights {
	
	 
	NSString *urlString = [NSString stringWithFormat:@"http://192.168.2.3:8182/lighting/navigationLights/%@",NavLights];
	NSURL *url = [NSURL URLWithString:urlString];
	
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
    
}
- (void)sendUnderwaterLightsDataREST:(NSString *)UnderwaterLights {
	
	   
	NSString *urlString = [NSString stringWithFormat:@"http://192.168.2.3:8182/lighting/underwaterLights/%@",UnderwaterLights];
	NSURL *url = [NSURL URLWithString:urlString];
	
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
    
}

-(IBAction)navLights{
    if(navLightsSwitch.on)
    {
        navLightPort.hidden = NO;
        navLightStarboard.hidden =NO;
        navLightStern.hidden =NO;
        [self sendNavLightsDataREST:@"True"];
    }
    else
    {
        navLightPort.hidden = YES;
        navLightStarboard.hidden =YES;
        navLightStern.hidden =YES;
        [self sendNavLightsDataREST:@"False"];
    }
    
}
-(IBAction)underwaterLights{
    if(underwaterLightsSwitch.on)
    {
        underWaterLights.hidden = NO;
        [self sendUnderwaterLightsDataREST:@"True"];
    }
    else
    {
         underWaterLights.hidden = YES;
         [self sendUnderwaterLightsDataREST:@"False"];
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
