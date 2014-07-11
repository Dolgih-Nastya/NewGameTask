//
//  incGameViewController.h
//  iPingPong
//
//  Created by vlad on 6/16/14.
//  Copyright (c) 2014 vlad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
#import "incLevelViewController.h"

@interface INCGameViewController : UIViewController
{

IBOutlet UIImageView *ball;
IBOutlet UIImageView *platform_Player1;
IBOutlet UIImageView *platform_Player2;
IBOutlet UILabel     *tapToBegin;

IBOutlet UILabel *player_score;
IBOutlet UILabel *computer_score;

CGPoint ballVelocity;

NSInteger gameState;

NSInteger player_score_value;
NSInteger computer_score_value;

SystemSoundID volleyFileID;
SystemSoundID clappingFileID;
}

@property(nonatomic) SystemSoundID volleyFileID;
@property(nonatomic) SystemSoundID clappingFileID;

@property(nonatomic,retain) IBOutlet UIImageView *ball;
@property(nonatomic,retain) IBOutlet UIImageView *platform_Player1;
@property(nonatomic,retain) IBOutlet UIImageView *platform_Player2;
@property(nonatomic,retain) IBOutlet UILabel     *tapToBegin;

@property(nonatomic,retain) IBOutlet UILabel *player_score;
@property(nonatomic,retain) IBOutlet UILabel *computer_score;

@property(nonatomic) CGPoint ballVelocity;
@property(nonatomic) NSInteger gameState;

@property  NSInteger ballSpeedX;
@property  NSInteger ballSpeedY;
@property  NSInteger compSpeed;
@property  NSInteger maxScoreToWin;


- (void)reset:(BOOL) newGame;
- (void)setBallSpeed:(NSInteger)ballSpeed AndMaxScoreToWin:(NSInteger) maxScoreToWin AndLevel:(Level)level AndIsCompPlaying:(BOOL) isCompPlaying;


@end
