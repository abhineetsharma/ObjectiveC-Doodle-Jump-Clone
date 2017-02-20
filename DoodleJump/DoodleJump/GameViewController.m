//
//  GameViewController.m
//  DoodleJump
//
//  Created by Abhineet Sharma on 2/20/17.
//  Copyright © 2017 Abhineet Sharma. All rights reserved.
//

#import "GameViewController.h"
#define degrees(x) 180 * x / M_PI


@interface GameViewController (){
CMMotionManager *motion;
NSOperationQueue *operation;
}
@end

@implementation GameViewController
-(void) touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"Touch Happened.");
}
-(void)read{
    CMAttitude *attitude;
    CMDeviceMotion * motionDevice = motion.deviceMotion;
    attitude = motionDevice.attitude;
    
    //_rollLabel.text = roll;
    
    NSLog(@" %f" , attitude.roll);
    //UITouch * tuknutie = [touches anyObject];
    //CGPoint bod = [tuknutie locationInView:self.view];
    if (attitude.roll > 0.01) {
        moveBallRight = YES;
    }
    else if(attitude.roll < -0.01) {
        moveBallLeft = YES;
    }
    
    
    else{
        moveBallLeft = NO;
        moveBallRight = NO;
        stopMovement = YES;
    }
    
}
//-(void) touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    moveBallLeft = NO;
//    moveBallRight = NO;
//    stopMovement = YES;
//}


//HLAVNY SPUSTAC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    motion = [[CMMotionManager alloc] init];
    motion.deviceMotionUpdateInterval = 1/60;
    [motion startDeviceMotionUpdates];
    _timer = [NSTimer scheduledTimerWithTimeInterval:(1/60) target:self selector:@selector(read) userInfo:nil repeats:YES];
    
    if([motion isGyroAvailable]){
        if([motion isGyroActive]){
            [motion setGyroUpdateInterval:(0.01)];
        }}
    
    // Do any additional setup after loading the view.
    self.platform2.hidden = YES;
    self.platform3.hidden = YES;
    self.platform4.hidden = YES;
    self.platform5.hidden = YES;
    self.platform6.hidden = YES;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)StartGame:(id)sender {
    
    self.startButton.hidden = YES;
    upMovement = -5;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(Pohyb) userInfo:nil repeats:YES];
    
    self.platform2.hidden = NO;
    self.platform3.hidden = NO;
    self.platform4.hidden = NO;
    self.platform5.hidden = NO;
    self.platform6.hidden = NO;
    
    number = arc4random()%206;
    number = number + 50;
    self.platform2.center = CGPointMake(number, 546);
    
    number = arc4random()%206;
    number = number + 50;
    self.platform3.center = CGPointMake(number, 449);
    
    number = arc4random()%206;
    number = number + 50;
    self.platform4.center = CGPointMake(number, 336);
    
    number = arc4random()%206;
    number = number + 50;
    self.platform5.center = CGPointMake(number, 231);
    
    number = arc4random()%206;
    number = number + 50;
    self.platform6.center = CGPointMake(number, 126);
    
    
    platform3pohyb = 2;
    platform5pohyb = -2;
    
}



-(void)PlatformaPad {
    
    if (self.ball.center.y > 500) {
        padaniePlatformy = 1;
    } else if (self.ball.center.y > 450) {
        padaniePlatformy = 2;
    } else if (self.ball.center.y > 400) {
        padaniePlatformy = 4;
    } else if (self.ball.center.y > 300) {
        padaniePlatformy = 5;
    } else if (self.ball.center.y > 250) {
        padaniePlatformy = 6;
    }
}


//HLAVNY POHYB
-(void) Pohyb {
    
    [self PohybPlatformy];
    self.ball.center = CGPointMake(self.ball.center.x + sideMovement, self.ball.center.y - upMovement);
    
    if (self.ball.center.y < 100) {
        self.ball.center = CGPointMake(self.ball.center.x, 100);
    }
    
    
    //    INTERSECT, odrazenie od platformy.
    if ((CGRectIntersectsRect(self.ball.frame, self.platform1.frame)) && (upMovement < -2) ) {
        
        [self Bounce];
        [self PlatformaPad];
    }
    
    if ((CGRectIntersectsRect(self.ball.frame, self.platform2.frame)) && (upMovement < -2) ) {
        
        [self Bounce];
        [self PlatformaPad];
    }
    
    if ((CGRectIntersectsRect(self.ball.frame, self.platform3.frame)) && (upMovement < -2) ) {
        
        [self Bounce];
        [self PlatformaPad];
    }
    
    if ((CGRectIntersectsRect(self.ball.frame, self.platform4.frame)) && (upMovement < -2) ) {
        
        [self Bounce];
        [self PlatformaPad];
    }
    
    if ((CGRectIntersectsRect(self.ball.frame, self.platform5.frame)) && (upMovement < -2) ) {
        
        [self Bounce];
        [self PlatformaPad];
    }
    
    if ((CGRectIntersectsRect(self.ball.frame, self.platform6.frame)) && (upMovement < -2) ) {
        
        [self Bounce];
        [self PlatformaPad];
    }
    
    upMovement = upMovement - 0.3;
    
    if (moveBallLeft == YES) {
        sideMovement = sideMovement - 0.2;
        
        if (sideMovement < -5) {
            sideMovement = -5;
        }
    }
    
    if (moveBallRight == YES) {
        sideMovement = sideMovement + 0.2;
        
        if (sideMovement > 5) {
            sideMovement = 5;
        }
    }
    
    if((stopMovement == YES) && (sideMovement < 0)) {
        sideMovement = sideMovement + 0.1;
        if (sideMovement > 0 ) {
            sideMovement = 0;
            stopMovement = NO;
        }
    }
    
    if ((stopMovement == YES) && (sideMovement > 0)) {
        sideMovement = sideMovement - 0.1;
        if (sideMovement < 0) {
            sideMovement = 0;
            stopMovement = NO;
        }
    }
    
    //    Kontrola, ci lopta neprekrocila okraje
    if (self.ball.center.x < -11) {
        self.ball.center = CGPointMake(350, self.ball.center.y);
    } else if (self.ball.center.x > 350) {
        self.ball.center = CGPointMake(-11, self.ball.center.y);
    }
    //    KONIEC KONTROLY
    
}

-(void) Bounce {
    self.ball.animationImages = [NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"football2.png"],
                                  [UIImage imageNamed:@"football3.png"],
                                  [UIImage imageNamed:@"football2.png"],
                                  [UIImage imageNamed:@"football1.png"], nil ];
    
    [self.ball setAnimationRepeatCount:1];
    self.ball.animationDuration = 0.2;
    [self.ball startAnimating];
    
    if (self.ball.center.y > 600) {
        upMovement = 10;
    } else if (self.ball.center.y > 500) {
        upMovement = 9;
    } else if (self.ball.center.y > 400) {
        upMovement = 8;
    } else {
        upMovement = 7;
    }
    
}


//POHYB PLATFORMY KOD
- (void) PohybPlatformy {
    
    //   Pohyb platformy do stran a dole (ked skocime na platformu)
    
    self.platform1.center = CGPointMake(self.platform1.center.x, self.platform1.center.y + padaniePlatformy);
    self.platform2.center = CGPointMake(self.platform2.center.x, self.platform2.center.y + padaniePlatformy);
    self.platform3.center = CGPointMake(self.platform3.center.x + platform3pohyb, self.platform3.center.y + padaniePlatformy);
    self.platform4.center = CGPointMake(self.platform4.center.x, self.platform4.center.y + padaniePlatformy);
    self.platform5.center = CGPointMake(self.platform5.center.x + platform5pohyb, self.platform5.center.y + padaniePlatformy);
    self.platform6.center = CGPointMake(self.platform6.center.x, self.platform6.center.y + padaniePlatformy);
    
    
    if (self.platform3.center.x > 320 ) {
        platform3pohyb = -2;
    } else if(self.platform3.center.x < 60) {
        platform3pohyb = 2;
    }
    
    if (self.platform5.center.x < 60) {
        platform5pohyb = 2;
    } else if (self.platform5.center.x > 320) {
        platform5pohyb = -2;
    }
    
    padaniePlatformy =  padaniePlatformy - 0.1;
    
    if (padaniePlatformy < 0) {
        padaniePlatformy = 0;
    }
    
    //    Nahodne generovanie novych platforiem
    
    if (self.platform1.center.y > 670 ) {
        number = arc4random()% 320;
        number = number + 50;
        self.platform1.center = CGPointMake(number, -6);
    }
    
    if (self.platform2.center.y > 670 ) {
        number = arc4random()% 320;
        number = number + 50;
        self.platform2.center = CGPointMake(number, -6);
    }
    
    if (self.platform3.center.y > 670 ) {
        number = arc4random()% 320;
        number = number + 50;
        self.platform3.center = CGPointMake(number, -6);
    }
    
    if (self.platform4.center.y > 670 ) {
        number = arc4random()% 320;
        number = number + 50;
        self.platform4.center = CGPointMake(number, -6);
    }
    
    if (self.platform5.center.y > 670 ) {
        number = arc4random()% 320;
        number = number + 50;
        self.platform5.center = CGPointMake(number, -6);
    }
    
    if (self.platform6.center.y > 670 ) {
        number = arc4random()% 320;
        number = number + 50;
        self.platform6.center = CGPointMake(number, -6);
    }
    
}



@end
