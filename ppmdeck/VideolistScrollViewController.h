//
//  VideolistScrollViewController.h
//  PPMC Deck
//
//  Created by Gereldyn Quizora on 4/10/14.
//  Copyright (c) 2014 Gereldyn Quizora. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol VideolistScrollViewControllerDelegate <NSObject>
    - (void)didSelectRowAtIndex:(NSInteger) index;
    - (void)didSelectRowAtIndex:(NSInteger) index andVideo:(NSString*) videopath;

@end
@interface VideolistScrollViewController : UIViewController
{
    UIScrollView *scrollview;
    int pageNumber;
    UITapGestureRecognizer *tap;
    NSArray *videos;
    
}

@property (nonatomic, weak) id <VideolistScrollViewControllerDelegate> delegate;
@property(nonatomic, strong) NSString *repositoryURL;

- (id) initWithArary: (NSArray*)array;

@end
