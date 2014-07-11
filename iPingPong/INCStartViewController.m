//
//  incStartViewController.m
//  iPingPong
//
//  Created by vlad on 6/16/14.
//  Copyright (c) 2014 vlad. All rights reserved.
//

#import "INCStartViewController.h"
#import "INCMainViewController.h"

typedef int (^SomeBlock)(BOOL fl);

@interface INCStartViewController () {
    BOOL splashHiden;
    SomeBlock someBlock;
}
@end


@implementation INCStartViewController
@synthesize timer, splashImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES];
    
    splashImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Start"]];
	[self.view addSubview:splashImageView];
    
    _mainVC = [[INCMainViewController alloc] initWithNibName:NSStringFromClass([INCMainViewController class]) bundle:[NSBundle mainBundle]];
	[self.view addSubview:_mainVC.view];
    
    [self.view bringSubviewToFront:splashImageView];
    
	timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(fadeScreen) userInfo:nil repeats:NO];
    
    someBlock = ^ (BOOL fl) {
        if (fl) {
            return 1;
        } else {
            return 199;
        }
    };
}

- (void)myWithBlock:(void (^) (NSString *firstString, NSString *secondString))myBlock {
    myBlock(@"dfdf", @"aaa");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    splashImageView.frame = self.view.bounds;
    
    NSLog(@"%d", someBlock(YES));
    
    id myBlock = ^(NSString *firstString, NSString *secondString) {
        NSLog(@"%@, %@", firstString, secondString);
    };
    
    [self myWithBlock:myBlock];
}

- (void)fadeScreen {
	[UIView animateWithDuration:0.75 animations:^{
        splashImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [splashImageView removeFromSuperview];
        splashHiden = YES;
          [self.navigationController pushViewController:_mainVC animated:NO];
        if (finished) {
            NSLog(@"done");
        }
    }];
}

- (NSUInteger) supportedInterfaceOrientations {
    if (splashHiden) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (BOOL) shouldAutorotate {
    return YES;
}

@end
