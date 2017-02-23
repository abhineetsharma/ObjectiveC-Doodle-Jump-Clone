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
    NSTimer *time1;
    float yMax;
}
@end

@implementation GameViewController


-(void) touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    UITouch * tuknutie = [touches anyObject];
    CGPoint bod = [tuknutie locationInView:self.view];
    
    if(bod.x < 160) {
        moveBallLeft = YES;
    }
    
    if (bod.x > 160) {
        moveBallRight = YES;
    }
    
}

-(void) touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
   // moveBallLeft = NO;
   // moveBallRight = NO;
    //stopMovement = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    yMax = screenSize.height;
    
    motion = [[CMMotionManager alloc] init];
    motion.deviceMotionUpdateInterval = 1/60;
    [motion startDeviceMotionUpdates];
    time1 = [NSTimer scheduledTimerWithTimeInterval:1/60 target:self selector:@selector(myFunc) userInfo:nil repeats:YES];
    
    if([motion isGyroAvailable]){
        if([motion isGyroActive]){
            [motion setGyroUpdateInterval:0.01];
        }
    }
    // Do any additional setup after loading the view.
    self.platform2.hidden = YES;
    self.platform3.hidden = YES;
    self.platform4.hidden = YES;
    self.platform5.hidden = YES;
    self.platform6.hidden = YES;
    
    
    
}

-(void)myFunc{
    CMAttitude * att;
    CMDeviceMotion * motionDevice = motion.deviceMotion;
    att = motionDevice.attitude;
    
    
    if(att.roll > 0){
        //move right
         moveBallRight = YES;
    }
    else if(att.roll < - 0.01){
        //move left
         moveBallLeft = YES;
    }
    else{
        moveBallLeft = NO;
        moveBallRight = NO;
        stopMovement = YES;
        
        //stop movement
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)StartGame:(id)sender {
    
    self.startButton.hidden = YES;
    upMovement = -5;
    
    _Casovac = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(Movement) userInfo:nil repeats:YES];
    
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







-(void) PlatformPad {
    
    if (self.ball.center.y > 500) {
        padaniePlatformy = 2;
    } else if (self.ball.center.y > 450) {
        padaniePlatformy = 4;
    } else if (self.ball.center.y > 400) {
        padaniePlatformy = 8;
    } else if (self.ball.center.y > 300) {
        padaniePlatformy = 10;
    } else if (self.ball.center.y > 250) {
        padaniePlatformy = 12;
    }
}


-(void) Movement {
    
    [self platformMovement];
    self.ball.center = CGPointMake(self.ball.center.x + sideMovement, self.ball.center.y - upMovement);
    
    if (self.ball.center.y < 100) {
        self.ball.center = CGPointMake(self.ball.center.x, 100);
    }
    
    
    if ((CGRectIntersectsRect(self.ball.frame, self.platform1.frame)) && (upMovement < -2) ) {
        
        [self Bounce];
        [self PlatformPad];
    }
    
    if ((CGRectIntersectsRect(self.ball.frame, self.platform2.frame)) && (upMovement < -2) ) {
        
        [self Bounce];
        [self PlatformPad];
    }
    
    if ((CGRectIntersectsRect(self.ball.frame, self.platform3.frame)) && (upMovement < -2) ) {
        
        [self Bounce];
        [self PlatformPad];
    }
    
    if ((CGRectIntersectsRect(self.ball.frame, self.platform4.frame)) && (upMovement < -2) ) {
        
        [self Bounce];
        [self PlatformPad];
    }
    
    if ((CGRectIntersectsRect(self.ball.frame, self.platform5.frame)) && (upMovement < -2) ) {
        
        [self Bounce];
        [self PlatformPad];
    }
    
    if ((CGRectIntersectsRect(self.ball.frame, self.platform6.frame)) && (upMovement < -2) ) {
        
        [self Bounce];
        [self PlatformPad];
    }
    if(self.ball.frame.origin.y > (float)yMax)
    {
        NSLog(@"Game over");
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
    
    if (self.ball.center.x < -11) {
        self.ball.center = CGPointMake(350, self.ball.center.y);
    } else if (self.ball.center.x > 350) {
        self.ball.center = CGPointMake(-11, self.ball.center.y);
    }
   
    
}

-(UIImage *) changeImageSize:(NSString *) imgName toWidth:(int)width andHeightto:(int) height
{
   
        CGRect rect = CGRectMake(0,0,width,height);
        UIGraphicsBeginImageContext( rect.size );
        [[UIImage imageNamed:imgName] drawInRect:rect];
        UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImagePNGRepresentation(picture1);
        UIImage *img=[UIImage imageWithData:imageData];
            
            return img;
        
}

-(void) Bounce {
    
    
    self.ball.animationImages = [NSArray arrayWithObjects:
                                  [self changeImageSize:@"football2.png" toWidth:40 andHeightto:40],
                                 [self changeImageSize:@"football3.png" toWidth:40 andHeightto:40]
                                 , nil ];
    
    [self.ball setAnimationRepeatCount:1];
    self.ball.animationDuration = 1.0;
    [self.ball startAnimating];
    
    //[self.view addSubview:self.ball];
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



- (void) platformMovement{
    
    
    self.platform1.center = CGPointMake(self.platform1.center.x, self.platform1.center.y + padaniePlatformy);
    self.platform2.center = CGPointMake(self.platform2.center.x, self.platform2.center.y + padaniePlatformy);
    self.platform3.center = CGPointMake(self.platform3.center.x + platform3pohyb, self.platform3.center.y + padaniePlatformy);
    self.platform4.center = CGPointMake(self.platform4.center.x, self.platform4.center.y + padaniePlatformy);
    self.platform5.center = CGPointMake(self.platform5.center.x + platform5pohyb, self.platform5.center.y + padaniePlatformy);
    self.platform6.center = CGPointMake(self.platform6.center.x, self.platform6.center.y + padaniePlatformy);
    
    //  Podmienka, aby sa platforma pri dotknuti rohu obratila na druhu stranu;
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
