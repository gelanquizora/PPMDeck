//
//  BottomToolbar.m
//  ppmdeck
//
//  Created by Gereldyn Quizora on 03/01/2016.
//  Copyright © 2016 Gereldyn Quizora. All rights reserved.
//

#import "BottomToolbar.h"

@implementation BottomToolbar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.btnVideos = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _btnVideos.frame = CGRectMake(820, 3, 45, 44);
        [_btnVideos addTarget:self action:@selector(videosButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_btnVideos setBackgroundImage:[UIImage imageNamed:@"bottom-button-movie-selected.png"] forState:UIControlStateHighlighted];
        [_btnVideos setBackgroundImage:[UIImage imageNamed:@"bottom-button-movie.png"] forState:UIControlStateNormal];
        [self addSubview:_btnVideos];
        
        
        
        
        
        self.btnEmail = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _btnEmail.frame = CGRectMake(865, 3, 45, 44);
        [_btnEmail addTarget:self action:@selector(emailButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_btnEmail setBackgroundImage:[UIImage imageNamed:@"bottom-button-mail.png"] forState:UIControlStateNormal];
        [_btnEmail setBackgroundImage:[UIImage imageNamed:@"bottom-button-mail-selected.png"] forState:UIControlStateHighlighted];
        [self addSubview:_btnEmail];
        
        
        
        
        self.btnNotes = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _btnNotes.frame = CGRectMake(905, 3, 45, 44);
        [_btnNotes addTarget:self action:@selector(noteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_btnNotes setBackgroundImage:[UIImage imageNamed:@"bottom-button-edit.png"] forState:UIControlStateNormal];
        [_btnNotes setBackgroundImage:[UIImage imageNamed:@"bottom-button-edit-selected.png"] forState:UIControlStateHighlighted];
        [self addSubview:_btnNotes];
        
        
        
        
        
        self.btnComments = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _btnComments.frame = CGRectMake(950, 3, 45, 44);
        [_btnComments addTarget:self action:@selector(commentButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_btnComments setBackgroundImage:[UIImage imageNamed:@"bottom-button-dashboard.png"] forState:UIControlStateNormal];
        [self addSubview:_btnComments];
        
        
        
    }
    return self;
}


- (void)nextButtonTapped:(UIButton*)button
{
    //[_delegate tappedInToolbar:self library:button];
}
- (void)previousButtonTapped:(UIButton*)button
{
    //  [_delegate tappedInToolbar:self library:button];
}


- (void)videosButtonTapped:(UIButton*)button
{
    [_delegate tappedInToolbar:self videos:button];
    
}

- (void)emailButtonTapped:(UIButton*)button
{
    [_delegate tappedInToolbar:self email:button];
}

- (void)commentButtonTapped:(UIButton*)button
{
    [_delegate tappedInToolbar:self draw:button];
}
- (void)noteButtonTapped:(UIButton*)button
{
    [_delegate tappedInToolbar:self note:button];
}


@end
