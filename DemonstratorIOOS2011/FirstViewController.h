//
//  FirstViewController.h
//  DemonstratorIOOS2011
//
//  Created by zak borg on 18/09/2011.
//  Copyright 2011 Intellimare Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController {

    NSTimer *myTimer;
    IBOutlet UIProgressView *RudderAngleGauge;
	IBOutlet UILabel  *RPMLabel;
    
}
-(IBAction)rudderPort;
-(IBAction)rudderFullPort;
-(IBAction)rudderStarboard;
-(IBAction)rudderFullStarboard;
-(IBAction)increaseRpm;
-(IBAction)increaseFullRpm;
-(IBAction)decreaseRpm;
-(IBAction)decreaseFullRpm;
@property(nonatomic,retain)NSTimer *myTimer;
@property(nonatomic,retain)IBOutlet UIProgressView *RudderAngleGauge;
@property(nonatomic,retain)IBOutlet UILabel  *RPMLabel;

@end
