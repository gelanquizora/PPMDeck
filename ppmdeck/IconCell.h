//
//  IconCell.h
//  PPMC Deck
//
//  Created by Gereldyn Quizora on 3/3/14.
//  Copyright (c) 2014 Gereldyn Quizora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconCell;

@protocol IconCellDelegate <NSObject>
    - (void)select:(IconCell *)cell;
    - (void)activate:(IconCell *)cell;

@end

@interface IconCell : UIView
{
    UIImageView * _iconView;
    UILabel *lblTitle;
}

@property (nonatomic, retain) UIImage * icon;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * pageName;

@property (nonatomic) NSUInteger index;
@property (nonatomic) BOOL isChecked;
@property (nonatomic, weak) id <IconCellDelegate> delegate;

-(void) check;
//-(void) uncheck;
-(void) removeReflection:(BOOL)remove;
-(void) unselect;

@end
