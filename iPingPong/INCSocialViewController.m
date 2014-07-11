//
//  incSocialViewController.m
//  iPingPong
//
//  Created by Анастасия Долгих on 6/18/14.
//  Copyright (c) 2014 Анастасия Долгих. All rights reserved.
//

#import "INCSocialViewController.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface INCSocialViewController ()

@end

@implementation INCSocialViewController

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

- (void)sendMessageFromComposeController:(NSString *) serviceType {
    SLComposeViewController *sheet = [SLComposeViewController composeViewControllerForServiceType:serviceType];
    [sheet setInitialText:@"Today I'm a winner :)"];
    [self presentViewController:sheet animated:YES completion:nil];
}

- (IBAction)tweetTapped:(id)sender {
    [self sendMessageFromComposeController:SLServiceTypeTwitter];
}


- (IBAction)facebookTapped:(id)sender {
    [self sendMessageFromComposeController:SLServiceTypeFacebook];
}

- (IBAction)showEmail:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Test Email";
    // Email Content
    NSString *messageBody = @"iOS programming is so fun!";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)backButtonDidClick:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
