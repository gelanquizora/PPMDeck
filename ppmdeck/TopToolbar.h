//
//  TopToolbar.h
//  PPMC Deck
//
//  Created by Gereldyn Quizora on 7/14/13.
//  Copyright (c) 2013 Gereldyn Quizora. All rights reserved.
//

#import "UITransparentToolbar.h"
@class TopToolbar;
@protocol TopToolbarDelegate <NSObject>
    - (void)tappedInToolbar:(TopToolbar *)toolbar dashboard:(UIButton *)button;
    - (void)tappedInToolbar:(TopToolbar *)toolbar logout:(UIButton *)button;
    - (void)tappedInToolbar:(TopToolbar *)toolbar unlock:(UIButton *)button;

@end



@interface TopToolbar : UITransparentToolbar



@property (nonatomic, weak) id <TopToolbarDelegate> delegate;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *btnLibrary;
@property (nonatomic, strong) UIButton *btnLogout;
@property (nonatomic, strong) UIButton *btnPasscode;

@end
