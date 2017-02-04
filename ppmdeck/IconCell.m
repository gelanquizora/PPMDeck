//
//  IconCell.m
//  PPMC Deck
//
//  Created by Gereldyn Quizora on 3/3/14.
//  Copyright (c) 2014 Gereldyn Quizora. All rights reserved.
//

#import "IconCell.h"
#import <QuartzCore/QuartzCore.h>


#define ORIGINALIMAGE_WIDTH  168.0f //145.0f
#define ORIGINALIMAGE_HEIGHT 213.0f //110.0f

@implementation IconCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _iconView = [[UIImageView alloc] init];//(0.0, 0.0, 104, 163.0)];
        _iconView.backgroundColor = [UIColor clearColor];
        _iconView.opaque = NO;
        
        frame.origin = CGPointMake(0.0,  0.0);
       
        
        [_iconView setFrame: frame];
        
        
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
      
        
        
        
        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 170.0, self.frame.size.width, 40)];
        lblTitle.backgroundColor = [UIColor clearColor];
        lblTitle.textColor = [UIColor whiteColor];
        
        lblTitle.font = [UIFont fontWithName:@"Helvetica Neue" size:16.0f];
        
        [lblTitle setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        
        
        // [self addSubview:lblTitle];
        [self addSubview: _iconView];
        
        
        
        
        _isChecked = NO;
        //Tap
        UITapGestureRecognizer *singleTapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTapOne.numberOfTouchesRequired = 1;
        singleTapOne.numberOfTapsRequired = 1;
        singleTapOne.delegate = self;
        
        //[singleTapOne requireGestureRecognizerToFail:doubleTapOne]; // Single tap requires double tap to fail
        
        [self addGestureRecognizer:singleTapOne];  
        
        self.backgroundColor = [UIColor blackColor];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (UIImage *) icon
{
    return ( _iconView.image );
}

- (void) setIcon: (UIImage *) anIcon
{
    
    _iconView.image = anIcon;
    _iconView.backgroundColor = [UIColor clearColor];
    _iconView.layer.opacity = 0.5;
}

- (NSString *) title
{
    return lblTitle.text;
}

- (void) setTitle: (NSString *) anText
{
    
    lblTitle.text = anText;
    
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    
    [_delegate select:self];
    
    
}


 
 

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //This gets called for a touch anywhere
    
    _iconView.layer.opacity = 1.0;
    [_delegate activate:self];
}
 

-(void)unselect
{
    _iconView.layer.opacity = 0.5;
}


@end
