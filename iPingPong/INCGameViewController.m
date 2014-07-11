//
//  incGameViewController.m
//  iPingPong
//
//  Created by vlad on 6/16/14.
//  Copyright (c) 2014 vlad. All rights reserved.
//

#import "incGameViewController.h"
#import "incMainViewController.h"
#import "incLevelViewController.h"


#define Running 1
#define Paused  2
#define Center 120

@interface INCGameViewController ()
@property Level currentLevel;
@property BOOL isCompPlaying; //otherwise comp is second player
@end

@implementation INCGameViewController

@synthesize ball,platform_Player2,platform_Player1,player_score,computer_score,gameState,ballVelocity,tapToBegin;

@synthesize volleyFileID, clappingFileID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setBallSpeed:NO AndMaxScoreToWin:NO AndLevel:Easy AndIsCompPlaying:YES];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if(gameState == Paused) {
		tapToBegin.hidden = YES;
		gameState = Running;
	} else if(gameState == Running) {
		[self touchesMoved:touches withEvent:event];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:touch.view];
    if (self.isCompPlaying) {
	  CGPoint xLocation = CGPointMake(location.x,platform_Player2.center.y);
	  platform_Player2.center = xLocation;
    } else {
        if (location.y < self.view.bounds.size.height/2) {
            CGPoint xLocation = CGPointMake(location.x,platform_Player1.center.y);
            platform_Player1.center = xLocation;
        } else {
            CGPoint xLocation = CGPointMake(location.x,platform_Player2.center.y);
            platform_Player2.center = xLocation;
        }
    }
}

-(void) gameLoop {
    if(gameState == Running) {
        [self setBallCenter];
        [self intersectionWithPlayer2];
        [self intersectionWithPlayer1];
        if (self.isCompPlaying) {
          [self ai];         // AI
        }
        [self logic];      //Logic
    } else {
        if(tapToBegin.hidden) {
            tapToBegin.hidden = NO;
        }
    }
}


- (void) intersectionWithPlayer2 {
    if(CGRectIntersectsRect(ball.frame,platform_Player2.frame)) {
        if(ball.center.y < platform_Player2.center.y) {
            ballVelocity.y = -ballVelocity.y;
            AudioServicesPlaySystemSound (volleyFileID);
        }
    }
}

- (void) intersectionWithPlayer1 {
    if(CGRectIntersectsRect(ball.frame,platform_Player1.frame)) {
        if(ball.center.y > platform_Player1.center.y) {
            ballVelocity.y = -ballVelocity.y;
            AudioServicesPlaySystemSound (volleyFileID);
        }
    }
}

- (void) setBallCenter {
    ball.center = CGPointMake(ball.center.x + ballVelocity.x , ball.center.y + ballVelocity.y);
    if(ball.center.x > self.view.bounds.size.width || ball.center.x < 0) {
        ballVelocity.x = -ballVelocity.x;
    }
    if(ball.center.y > self.view.bounds.size.height || ball.center.y < 0) {
        ballVelocity.y = -ballVelocity.y;
    }
}

- (void) logic {
    if(ball.center.y <= 0) {
        player_score_value++;
        [self reset:(player_score_value >= self.maxScoreToWin)];
    }
    
    if(ball.center.y > self.view.bounds.size.height) {
        computer_score_value++;
        [self reset:(computer_score_value >= self.maxScoreToWin)];
    }
}

- (void) ai {
    if(ball.center.y <= self.view.center.y) {
        if(ball.center.x < platform_Player1.center.x) {
            CGPoint compLocation = CGPointMake(platform_Player1.center.x - self.compSpeed, platform_Player1.center.y);
            platform_Player1.center = compLocation;
        }
        
        if(ball.center.x > platform_Player1.center.x) {
            CGPoint compLocation = CGPointMake(platform_Player1.center.x + self.compSpeed, platform_Player1.center.y);
            platform_Player1.center = compLocation;
        }
    }
}
- (void)reset:(BOOL) newGame {
   
	self.gameState = Paused;
	AudioServicesPlaySystemSound (clappingFileID);
	ball.center = self.view.center;
	if(newGame) {
		if(computer_score_value > player_score_value) {
            if (self.isCompPlaying) {
			  tapToBegin.text = @"Computer Wins!";
            } else {
                tapToBegin.text = @"Second Player Wins!";
            }
		} else {
			tapToBegin.text = @"First Player Wins!";
		}
		 
		computer_score_value = 0;
		player_score_value = 0;
	} else {
        CGPoint resetCenter = CGPointMake(160, 32);
        
        platform_Player1.center = resetCenter;
  		tapToBegin.text = @"CONTINUE";
        
	}
	player_score.text = [NSString stringWithFormat:@"%@%ld",@"Score:",player_score_value];
	computer_score.text = [NSString stringWithFormat:@"%@%ld",@"Score:",computer_score_value];
}

- (void)setBallSpeed:(NSInteger)ballSpeed AndMaxScoreToWin:(NSInteger) maxScoreToWin AndLevel:(Level)level AndIsCompPlaying:(BOOL) isCompPlaying
{
    [self setBallSpeed:ballSpeed];
    [self setScoreToWin:maxScoreToWin];
    self.currentLevel = level;
    self.isCompPlaying = isCompPlaying;
}

- (void)setBallSpeed:(NSInteger)ballSpeed {
    if (ballSpeed == NO) {
        self.ballSpeedX = 3;
        self.ballSpeedY = 4;
        self.compSpeed  = 3;
    } else {
       self.ballSpeedX = ballSpeed;
       self.ballSpeedY = ballSpeed + 1;
       self.compSpeed =  ballSpeed;
    }
}

- (void)setScoreToWin:(NSInteger)scoreToWin {
    if (scoreToWin == NO) {
        self.maxScoreToWin = 5;
    }
    else {
       self.maxScoreToWin = scoreToWin;
    }
}

- (void)setLevel:(Level)level {
    switch (level) {
        case Easy:
            [self setImadesWidth:100];
            break;
        case Medium:
            [self setImadesWidth:70];
            break;
        case Strong:
            [self setImadesWidth:40];
            break;
    }
}

- (void) setImadesWidth:(NSInteger)width {
    self.platform_Player1.frame =  CGRectMake(self.platform_Player1.frame.origin.x,
                                              self.platform_Player1.frame.origin.y, width, 33);
    self.platform_Player2.frame =  CGRectMake(self.platform_Player2.frame.origin.x,
                                              self.platform_Player2.frame.origin.y, width, 33);
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.gameState = Paused;
	ballVelocity = CGPointMake(self.ballSpeedX,self.ballSpeedY);
	
  
	NSURL *clapPath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"aplause10" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)clapPath, &clappingFileID);
    
    NSURL *volleyPath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"clap" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)volleyPath, &volleyFileID);
    
	
	[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
   

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setLevel:self.currentLevel];
}

- (IBAction)buttonBackDidClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
   }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


@end
