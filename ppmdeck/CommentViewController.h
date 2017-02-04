//
//  CommentViewController.h
//  ppmdeck
//
//  Created by Gereldyn Quizora on 19/01/2016.
//  Copyright © 2016 Gereldyn Quizora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Page.h"

@class CommentViewController;
@protocol CommentViewControllerDelegate <NSObject>
    - (void)close:(CommentViewController *)commentViewController library:(UIButton *)button;
@end

@interface CommentViewController : UIViewController<UIActionSheetDelegate>

{
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
    
    NSString *noteFilename;

    
}

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (nonatomic, strong) NSString *pageURL;

@property (nonatomic, strong) UIImage *currentImage;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *drawing;


@property (weak, nonatomic) IBOutlet UISlider *brushControl;
@property (weak, nonatomic) IBOutlet UISlider *opacityControl;
@property (weak, nonatomic) IBOutlet UIImageView *brushPreview;
@property (weak, nonatomic) IBOutlet UIImageView *opacityPreview;
@property (weak, nonatomic) IBOutlet UILabel *brushValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *opacityValueLabel;

@property (weak, nonatomic) IBOutlet UISlider *redControl;
@property (weak, nonatomic) IBOutlet UISlider *greenControl;
@property (weak, nonatomic) IBOutlet UISlider *blueControl;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIView *settingsView;

@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@property (weak, nonatomic) id<CommentViewControllerDelegate> delegate;
@property (nonatomic, strong) Page *currentPage;

- (IBAction)pencilPressed:(id)sender;
- (IBAction)eraserPressed:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)settings:(id)sender;
- (IBAction)save:(id)sender;


@property CGFloat brush;
@property CGFloat opacity;
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;

- (IBAction)closeSettings:(id)sender;
- (IBAction)sliderChanged:(id)sender;
- (void)changeSettings:(id)sender;

+(NSString*)GUIDString;

@end
