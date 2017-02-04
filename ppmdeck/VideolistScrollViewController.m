//
//  VideolistScrollViewController.m
//  PPMC Deck
//
//  Created by Gereldyn Quizora on 4/10/14.
//  Copyright (c) 2014 Gereldyn Quizora. All rights reserved.
//

#import "VideolistScrollViewController.h"


@interface VideolistScrollViewController ()

@end

@implementation VideolistScrollViewController
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id) initWithArary: (NSArray*)array
{
	self = [super init];
	if ( self == nil )
		return ( nil );
	
    videos = array;
	return ( self );
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    


}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(scrollview != nil)
        return;
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(95.0, 0, 800, self.view.frame.size.height)];
    scrollview.pagingEnabled = YES;
    scrollview.scrollEnabled = YES;
   
    
    
    
    NSInteger numberOfViews = 0;
    
     if(videos != nil)
         numberOfViews = videos.count;
    
    
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width/4 * numberOfViews, self.view.frame.size.height);
    [self.view addSubview:scrollview];
    
    
    

    
    
    float x = 0.0;
    for (int i = 0; i < numberOfViews; i++)
    {
      
        
        UIView *awesomeView = [[UIView alloc] initWithFrame:CGRectMake(x, 5, 184, 101)];
        awesomeView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"video-thumb.png"]];
        awesomeView.userInteractionEnabled = TRUE;
        awesomeView.tag = i;
 
        
         UILabel *lbl  = [[UILabel alloc] initWithFrame:CGRectMake(x, 101 ,184 , 40)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textColor = [UIColor blackColor];
        [lbl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        
        NSArray *array = [[videos objectAtIndex:i] componentsSeparatedByString:@"|"];
        lbl.text = [array objectAtIndex:1];
        
        [scrollview addSubview:awesomeView];
        [scrollview addSubview:lbl];
        
        
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
        tap.cancelsTouchesInView = YES;
        tap.numberOfTapsRequired = 1;
        
        [awesomeView addGestureRecognizer:tap];
         
        x += 200;
    }
    
    
    UIButton *btnPrevious =   [UIButton buttonWithType:UIButtonTypeCustom];
    btnPrevious.frame = CGRectMake(50, 60,14.0, 19.0);
    [btnPrevious setBackgroundImage:[UIImage imageNamed:@"videoarrowleft.png"] forState:UIControlStateNormal] ;
    [btnPrevious setBackgroundImage:[UIImage imageNamed:@"videoarrowleft.png"] forState:UIControlStateHighlighted] ;
    [btnPrevious addTarget:self action:@selector(previous:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPrevious];
    
    
    UIButton *btnNext =   [UIButton buttonWithType:UIButtonTypeCustom];
    btnNext.frame = CGRectMake(905, 60,11.0, 19.0);
    [btnNext setBackgroundImage:[UIImage imageNamed:@"videoarrowright.png"] forState:UIControlStateNormal] ;
    [btnNext setBackgroundImage:[UIImage imageNamed:@"videoarrowright.png"] forState:UIControlStateHighlighted] ;
    [btnNext addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNext];
    
    pageNumber = 1;
    
   

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)next:(UIButton*)button
{
    [scrollview setContentOffset:CGPointMake(200 * 4, 0.0f) animated:YES];
    pageNumber++;
    CGRect frame = scrollview.frame;
    frame.origin.x = frame.size.width * pageNumber;
    frame.origin.y = 0;
    [scrollview scrollRectToVisible:frame animated:YES];
    
    
}
- (void)previous:(UIButton*)button
{
    [scrollview setContentOffset:CGPointMake(200 * 4, 0.0f) animated:YES];
    pageNumber--;
    CGRect frame = scrollview.frame;
    frame.origin.x = frame.size.width * pageNumber;
    frame.origin.y = 0;
    [scrollview scrollRectToVisible:frame animated:YES];
    
   
    
}

- (void) handleImageTap:(UIGestureRecognizer *)gestureRecognizer {
    UIView* view = gestureRecognizer.view;
    //object of view which invoked this
  
    NSInteger i = view.tag;
    
    
    NSArray *array = [[videos objectAtIndex:i] componentsSeparatedByString:@"|"];
    
    
    [_delegate didSelectRowAtIndex:i andVideo: [self.repositoryURL stringByAppendingPathComponent:[array  objectAtIndex:0]]];
     
}

@end
