//
//  GameViewController.h
//  DoodleJump
//
//  Created by Abhineet Sharma on 2/20/17.
//  Copyright © 2017 Abhineet Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
float upMovement;
float sideMovement;
int platform3pohyb;
int platform5pohyb;
int number;
float padaniePlatformy;

BOOL moveBallLeft;
BOOL moveBallRight;
BOOL stopMovement;


@interface GameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *platform6;
@property (weak, nonatomic) IBOutlet UIImageView *platform5;
@property (weak, nonatomic) IBOutlet UIImageView *platform4;
@property (weak, nonatomic) IBOutlet UIImageView *platform3;
@property (weak, nonatomic) IBOutlet UIImageView *platform2;
@property (weak, nonatomic) IBOutlet UIImageView *platform1;
@property (weak, nonatomic) IBOutlet UIImageView *ball;
@property (weak, nonatomic) IBOutlet UIButton *startButton;


@property(nonatomic) BOOL *motionSwitch;

@property (strong, nonatomic) NSTimer * Casovac;

@property (strong, nonatomic) NSTimer * timer;
- (IBAction)StartGame:(id)sender;


- (void) Movement;
- (void) Bounce;
- (void) platformMovement;
- (void) PlatformPad;

@end

