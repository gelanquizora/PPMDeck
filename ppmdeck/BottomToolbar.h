//
//  BottomToolbar.h
//  ppmdeck
//
//  Created by Gereldyn Quizora on 03/01/2016.
//  Copyright © 2016 Gereldyn Quizora. All rights reserved.
//

#import "UITransparentToolbar.h"
@class BottomToolbar;
@protocol BottomToolbarDelegate <NSObject>
    - (void)tappedInToolbar:(BottomToolbar *)toolbar videos:(UIButton *)button;
    - (void)tappedInToolbar:(BottomToolbar *)toolbar email:(UIButton *)button;
    - (void)tappedInToolbar:(BottomToolbar *)toolbar draw:(UIButton *)button;
    - (void)tappedInToolbar:(BottomToolbar *)toolbar note:(UIButton *)button;

@end


@interface BottomToolbar : UITransparentToolbar

@property (nonatomic, weak) id <BottomToolbarDelegate> delegate;
@property (nonatomic, strong) UIButton *btnVideos;
@property (nonatomic, strong) UIButton *btnEmail;
@property (nonatomic, strong) UIButton *btnComments;
@property (nonatomic, strong) UIButton *btnNotes;


@end
