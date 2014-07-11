//
//  incLevelViewController.m
//  iPingPong
//
//  Created by Анастасия Долгих on 6/18/14.
//  Copyright (c) 2014 Анастасия Долгих. All rights reserved.
//

#import "INCLevelViewController.h"
#import "INCGameViewController.h"

@interface INCLevelViewController ()
@property(nonatomic, strong) IBOutlet UIPickerView *pickerCount;
@property(nonatomic, strong) IBOutlet UIPickerView *pickerBallSpeed;
@property(nonatomic, strong) IBOutlet UISwitch *firstPlayerSwitch;
@property(nonatomic, strong) IBOutlet UISwitch *secondPlayerSwitch;
@property(nonatomic, strong) NSMutableArray *countValues;
@property(nonatomic, strong) NSMutableArray *ballSpeedValues;
@property(nonatomic, strong) NSArray *levels;
@property BOOL isCompFirstPlayer;
@property NSInteger maxScoreToWin;
@property NSInteger ballSpeed;
@property Level level;
@end

@implementation INCLevelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupElements];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupElements
{
    self.countValues = [NSMutableArray new];
    self.ballSpeedValues =  [NSMutableArray new];
    for (int i=1; i<=200; i++) {
        [self.countValues addObject:@(i).stringValue];
    }
    for (int i=1; i<=20; i++) {
        [self.ballSpeedValues addObject:@(i).stringValue];
    }
    self.levels = @[@(Easy), @(Medium), @(Strong)];
    self.isCompFirstPlayer = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.pickerCount]) {
            return self.countValues.count;
        } else {
           return self.ballSpeedValues.count;
       }
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.pickerCount]) {
        return [self.countValues objectAtIndex:row];
    } else {
        return [self.ballSpeedValues objectAtIndex:row];
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.pickerCount]) {
        self.maxScoreToWin = [[self.countValues objectAtIndex:row] intValue];
    } else {
        self.ballSpeed = [[self.ballSpeedValues objectAtIndex:row] intValue];
    }
}

- (IBAction)okButtonDidPress:(id)sender
{
    INCGameViewController *gameController = [INCGameViewController new];
    [gameController setBallSpeed:self.ballSpeed AndMaxScoreToWin:self.maxScoreToWin AndLevel:self.level AndIsCompPlaying:self.isCompFirstPlayer];
    [self.navigationController pushViewController:gameController animated:YES];
}

- (IBAction)switchValueDidChanged:(UISwitch *)sender
{
   if ([sender isEqual:self.firstPlayerSwitch]) {
      self.secondPlayerSwitch.on = !self.secondPlayerSwitch.on;
   }
   else {
      self.firstPlayerSwitch.on  = !self.firstPlayerSwitch.on;
   }
    self.isCompFirstPlayer = !self.isCompFirstPlayer;
    
}

- (IBAction)backButtonDidClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sliderValueDidChanged:(UISlider *)sender {
    self.level = (Level) (sender.value + 0.5);
    [sender setValue:self.level animated:YES];
}

@end
