//
//  TestViewController.h
//  PPMC Deck
//
//  Created by Gereldyn Quizora on 9/28/13.
//  Copyright (c) 2013 Gereldyn Quizora. All rights reserved.
//

#import <UIKit/UIKit.h> 
@import AVFoundation;
@import AVKit;

@class TestViewController;
@protocol TestViewControllerDelegate <NSObject>

- (void)done:(TestViewController *)toolbar button:(UIButton *)button;


@end

@interface TestViewController : UIViewController
{
    AVPlayer *player;
}

@property (nonatomic, weak) id <TestViewControllerDelegate> delegate;

@property(nonatomic, retain) NSString *videopath;

-(void)playVideo;
-(IBAction)done:(id)sender;


@end
