//
//  ActiveDeckViewController.h
//  ppmdeck
//
//  Created by Gereldyn Quizora on 03/01/2016.
//  Copyright © 2016 Gereldyn Quizora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopToolbar.h"
#import "BottomToolbar.h"  
#import "CommentViewController.h"
#import  <MessageUI/MessageUI.h>
#import "NotesViewController.h"
#import "VideolistScrollViewController.h"
#import "Page.h"
#import "TestViewController.h"

@interface ActiveDeckViewController : UIViewController<TopToolbarDelegate, BottomToolbarDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate, UIPopoverPresentationControllerDelegate, VideolistScrollViewControllerDelegate, TestViewControllerDelegate, UITextFieldDelegate>
{
       TestViewController *testViewController;
    UIAlertController *alert;
    NSString *currentPasscode;
    
}


@property (nonatomic, strong) TopToolbar *topToolbar;
@property (nonatomic, strong) BottomToolbar *bottomToolbar;
@property (nonatomic, strong) CommentViewController *commentViewController;
@property (nonatomic, strong) NSString *pageURL;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) Page *currentPage;

+(NSString*)GUIDString;

@end
