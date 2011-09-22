//
//  AddressAnnotation.m
//  DemonstratorIOOS2011
//
//  Created by zak borg on 21/09/2011.
//  Copyright 2011 Intellimare Ltd. All rights reserved.
//

#import "AddressAnnotation.h"

@implementation AddressAnnotation
@synthesize coordinate;

- (NSString *)subtitle{
	return nil;
}

- (NSString *)title{
	return nil;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	return self;
}

@end