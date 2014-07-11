//
//  incMainViewController.m
//  iPingPong
//
//  Created by Анастасия Долгих on 6/18/14.
//  Copyright (c) 2014 Анастасия Долгих. All rights reserved.
//

#import "INCMainViewController.h"
#import "INCSocialViewController.h"
#import "INCStartViewController.h"
#import "INCLevelViewController.h"
#import "INCGameViewController.h"


@interface INCMainViewController ()

@end

@implementation INCMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)optionsButtonDidClick:(id)sender {
    [self.navigationController pushViewController:[INCSocialViewController new] animated:YES];
}

- (IBAction)startButtonDidClick:(id)sender {
    [self.navigationController pushViewController:[INCGameViewController new] animated:YES];
}

- (IBAction)levelButtonDidClick:(id)sender {
    [self.navigationController pushViewController:[INCLevelViewController new] animated:YES];
}


@end
