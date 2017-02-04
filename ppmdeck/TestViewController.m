//
//  TestViewController.m
//  PPMC Deck
//
//  Created by Gereldyn Quizora on 9/28/13.
//  Copyright (c) 2013 Gereldyn Quizora. All rights reserved.
//

#import "TestViewController.h"


@interface TestViewController ()

@end

@implementation TestViewController
@synthesize delegate = _delegate;
@synthesize videopath = _videopath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initializations
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *btnNext =   [UIButton buttonWithType:UIButtonTypeCustom];
    btnNext.frame = CGRectMake(450.00, 10,34.0, 22.0);
    [btnNext setBackgroundImage:[UIImage imageNamed:@"btnDoneA.png"] forState:UIControlStateNormal] ;
    
    [btnNext addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNext];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)playVideo{
  
    
  
  
    NSURL *tempURI = [NSURL fileURLWithPath: self.videopath];
    
    // create an AVPlayer
     player = [AVPlayer playerWithURL:tempURI];
    
    // create a player view controller
    AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
    controller.player = player;
     controller.view.frame = CGRectMake(0,50, 512, 500);
    [player play];
    
    // show the view controller
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
   // controller.view.frame = self.view.frame;
    
    
    
    
}
-(IBAction)done:(id)sender
{
    UIButton *button = (UIButton*)sender;
    [player pause];
    [_delegate done:self button:button];
    
    

}


@end
