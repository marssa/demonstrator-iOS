//
//  SecondViewController.h
//  DemonstratorIOOS2011
//
//  Created by zak borg on 18/09/2011.
//  Copyright 2011 Intellimare Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecondViewController : UIViewController {
    IBOutlet UIButton  *navLightPort;
    IBOutlet UIButton  *navLightStarboard;
    IBOutlet UIButton  *navLightStern;
    IBOutlet UIButton  *underWaterLights;
    IBOutlet UISwitch  *navLightsSwitch;
    IBOutlet UISwitch  *underwaterLightsSwitch;
    NSTimer *myTimer;
}

-(IBAction)navLights;
-(IBAction)underwaterLights;
@property(nonatomic,retain)IBOutlet UIButton  *navLightPort;
@property(nonatomic,retain)IBOutlet UIButton  *navLightStarboard;
@property(nonatomic,retain)IBOutlet UIButton  *navLightStern;
@property(nonatomic,retain)IBOutlet UIButton  *underWaterLights;
@property(nonatomic,retain)IBOutlet UISwitch  *navLightsSwitch;
@property(nonatomic,retain)IBOutlet UISwitch  *underwaterLightsSwitch;
@property(nonatomic,retain)NSTimer *myTimer;

@end
