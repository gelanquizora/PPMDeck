//
//  UITransparentToolbar.m
//  cne
//
//  Created by Admin on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITransparentToolbar.h"
#import <QuartzCore/QuartzCore.h>

@implementation UITransparentToolbar

+ (Class)layerClass
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif
    
	return [CAGradientLayer class];
}

#pragma mark UIXToolbarView instance methods

- (id)initWithFrame:(CGRect)frame
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif
    
	if ((self = [super initWithFrame:frame]))
	{
		self.autoresizesSubviews = YES;
		self.userInteractionEnabled = YES;
		self.contentMode = UIViewContentModeRedraw;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor clearColor];
        
        
        
	}
    
	return self;
}

 


@end
