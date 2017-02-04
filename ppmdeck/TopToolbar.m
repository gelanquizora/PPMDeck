//
//  TopToolbar.m
//  PPMC Deck
//
//  Created by Gereldyn Quizora on 7/14/13.
//  Copyright (c) 2013 Gereldyn Quizora. All rights reserved.
//

#import "TopToolbar.h"


@class Toolbar;
@implementation TopToolbar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // CGFloat viewWidth = self.bounds.size.width;
        
         CGRect titleRect = CGRectMake(0, 13, 100, 25);
        
        
         _label = [[UILabel alloc] initWithFrame:titleRect];
        CGPoint center = _label.center;
        center.x = self.center.x;
        _label.center = center;
       
        _label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont fontWithName:@"Helvetica Neue" size:16.0f];
        _label.textColor =  [UIColor whiteColor];
        _label.shadowColor = [UIColor colorWithWhite:0.65f alpha:1.0f];
		 	_label.backgroundColor = [UIColor clearColor];
		 	_label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		 	_label.adjustsFontSizeToFitWidth = YES;
	  	_label.text = @"SUN";
	 	//[self addSubview:_label];
        
        
        
        self.btnLibrary = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _btnLibrary.frame = CGRectMake(940, 0, 83, 55);
        [_btnLibrary addTarget:self action:@selector(doneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_btnLibrary setBackgroundImage:[UIImage imageNamed:@"top-button-done.png"] forState:UIControlStateNormal];
      //  [_btnLibrary setTitle:@"Done" forState:UIControlStateNormal];
        [self addSubview:_btnLibrary];
        
        
        self.btnLogout = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _btnLogout.frame = CGRectMake(844, 0, 96, 55);
        [_btnLogout addTarget:self action:@selector(logoutButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_btnLogout setBackgroundImage:[UIImage imageNamed:@"top-button-logout.png"] forState:UIControlStateNormal];
      //  [_btnLogout setTitle:@"Log Out" forState:UIControlStateNormal];
        [self addSubview:_btnLogout];
        
        
        self.btnPasscode = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _btnPasscode.frame = CGRectMake(739, 0, 105, 55);
        [_btnPasscode addTarget:self action:@selector(unlockPasscodeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
          [_btnPasscode setBackgroundImage:[UIImage imageNamed:@"top-button-passcode.png"] forState:UIControlStateNormal];
        //[_btnPasscode setTitle:@"Passcode" forState:UIControlStateNormal];
        [self addSubview:_btnPasscode];

        
        
    }
    return self;
}

/*- (void)libraryButtonTapped:(UIButton*)button
{
    [_delegate tappedInToolbar:self library:button];
    
}*/
- (void) doneButtonTapped:(UIButton*)button
{
    [_delegate tappedInToolbar:self dashboard:button];
    
}

- (void)logoutButtonTapped:(UIButton*)button
{
    
    //Delete
    [_delegate tappedInToolbar:self logout:button];
    
   // [self isFileDeleted:[DocumentsDirectory stringByAppendingPathComponent:@"content"]];

    [_delegate tappedInToolbar:self dashboard:button];
    
}

- (void)unlockPasscodeButtonTapped:(UIButton*)button
{
    
    
    [_delegate tappedInToolbar:self  unlock:button];
    
        
}


#pragma mark - Remove File
-(BOOL)isFileDeleted:(NSString *)fullpath{
	NSFileManager *fm = [NSFileManager defaultManager];
	NSError *error = nil;
	BOOL success = [fm removeItemAtPath:[NSString stringWithFormat:@"%@", fullpath] error:&error];
	if (!success || error) {
		return NO;
	}
	
	return YES;
}









/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


@end
