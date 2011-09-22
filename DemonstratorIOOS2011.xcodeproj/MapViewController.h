//
//  MapViewController.h
//  DemonstratorIOOS2011
//
//  Created by zak borg on 20/09/2011.
//  Copyright 2011 Intellimare Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapViewController : UIViewController {
   IBOutlet MKMapView *mapView;
    NSTimer *myTimer;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property(nonatomic,retain)NSTimer *myTimer;

@end