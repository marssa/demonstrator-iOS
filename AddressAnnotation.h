//
//  AddressAnnotation.h
//  DemonstratorIOOS2011
//
//  Created by zak borg on 21/09/2011.
//  Copyright 2011 Intellimare Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
}

@end
