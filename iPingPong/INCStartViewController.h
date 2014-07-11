//
//  incStartViewController.h
//  iPingPong
//
//  Created by vlad on 6/16/14.
//  Copyright (c) 2014 vlad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "INCMainViewController.h"

@interface INCStartViewController : UIViewController
{
NSTimer *timer;
UIImageView *splashImageView;

//INCMainViewController *viewController;
}

@property(nonatomic,retain) NSTimer *timer;
@property(nonatomic,retain) UIImageView *splashImageView;
@property(nonatomic,retain) INCMainViewController *mainVC;

@end
