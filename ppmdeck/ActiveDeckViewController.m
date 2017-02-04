//
//  ActiveDeckViewController.m
//  ppmdeck
//
//  Created by Gereldyn Quizora on 03/01/2016.
//  Copyright © 2016 Gereldyn Quizora. All rights reserved.
//

#import "ActiveDeckViewController.h"


#define TOPTOOLBARHEIGHT 55
#define TOOLBARHEIGHT 48


@interface ActiveDeckViewController ()

@end

@implementation ActiveDeckViewController
typedef enum
{
    mp4,  mpgeg, ogv
    
} VideoFomat;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated{
    
    //load WebView
    CGRect insetFrame = CGRectMake(0, 0, 1024, 768);
    
    
    if(_webView != nil)
    {
        [_webView removeFromSuperview];
        _webView =nil;
        
    }
    
    _webView = [[UIWebView alloc] initWithFrame:insetFrame];
 // [request setHTTPShouldHandleCookies:NO];
    [_webView loadRequest:  [NSURLRequest requestWithURL:[NSURL fileURLWithPath:self.pageURL ]]];
    _webView.delegate = self;
    [_webView.scrollView setBounces:NO];
    [_webView.scrollView setShowsHorizontalScrollIndicator:NO];
    
    [self.view addSubview:_webView];
    
    if([self.currentPage.filename isEqualToString:@"dt01.html"]){
        [_webView setHidden:YES];
        [self showMessage:@"Enter the passcode to continue" withTitle:@"Passcode"];
    }
    
    
    float y = self.view.frame.size.height - TOOLBARHEIGHT;
    self.bottomToolbar = [[BottomToolbar alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, TOOLBARHEIGHT)]; // At bottom
    _bottomToolbar.delegate = self;
    [_bottomToolbar setBackgroundColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottomtoolbarblue.png" ]]];
    //[_bottomToolbar setBackgroundColor: [UIColor colorWithRed:157.0f green:193.0f blue:219.0f alpha:1.0]];
    [_bottomToolbar setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth];
    //[_bottomToolbar loadThumbsWithLength:10];
    [self.view addSubview:_bottomToolbar];

    
    self.topToolbar = [[TopToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, TOPTOOLBARHEIGHT)]; // At top
    _topToolbar.delegate = self;
    [_topToolbar setBackgroundColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"top-bar-long.png" ]]];
    [_topToolbar setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth];
    
    [self.view addSubview:_topToolbar];
    
    
    
    
    UITapGestureRecognizer *singleTapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTapOne.numberOfTouchesRequired = 1; singleTapOne.numberOfTapsRequired = 2; singleTapOne.delegate = self;
    [self.view addGestureRecognizer:singleTapOne];  singleTapOne = nil;
    
    _bottomToolbar.hidden = YES;
    _topToolbar.hidden = YES;
    
 

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - TopToolbarDelegate's methods

- (void)tappedInToolbar:(TopToolbar *)toolbar dashboard:(UIButton *)button{
    
    
   [self performSegueWithIdentifier:@"ShowDashboard" sender:self];
}
- (void)tappedInToolbar:(TopToolbar *)toolbar logout:(UIButton *)button{
    
    NSUserDefaults *saveFile = [NSUserDefaults standardUserDefaults];
    [saveFile setBool:NO  forKey:@"LoggedIn"];
    [saveFile setObject:nil forKey:@"Videos"];
    [saveFile setObject:nil forKey:@"ActiveDeckTitle"];

    [saveFile setBool:nil  forKey:@"Passcode"];
    [saveFile synchronize];
    
    
    [self performSegueWithIdentifier:@"Logout" sender:self];
    
    
}
- (void)tappedInToolbar:(TopToolbar *)toolbar unlock:(UIButton *)button{
    [self showMessage:@"Enter the passcode to continue" withTitle:@"Passcode"];
    
}

#pragma mark Director's Treatment PassCode
-(void)showMessage:(NSString*)message withTitle:(NSString *)title
{
    
    alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert]; // 7
   
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //check if has enter correct value
        
         NSUserDefaults *saveFile = [NSUserDefaults standardUserDefaults];
         NSLog(@"%@", [saveFile stringForKey: @"Passcode" ]);
         if ([currentPasscode isEqualToString:[saveFile stringForKey: @"Passcode" ]]) {
            [saveFile setObject:@"YES" forKey:@"CorrectPasscode"];
            [saveFile synchronize];
            
            [_webView setHidden:NO];
             
        }
        
     
        
    }]; // 8
    
    __block typeof(self) weakSelf = self;
    
    [alert addAction:defaultAction]; // 9
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Input Passcode...";
        textField.delegate = weakSelf;
        [textField addTarget:weakSelf action:@selector(alertTextFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];
        
    }]; // 10
    
    [self presentViewController:alert animated:YES completion:nil]; // 11
  
}
- (void)alertTextFieldDidChange:(UITextField *)sender
{
    alert = (UIAlertController *)self.presentedViewController;
    UITextField *firstTextField = alert.textFields[0];
    currentPasscode = firstTextField.text;
    
    
}

#pragma mark - BottomToolbarDelegate's methods
- (void)tappedInToolbar:(BottomToolbar *)toolbar videos:(UIButton *)button{
    
    NSArray *arrayofvideos = [[NSArray alloc] init];
    /*NSString *videosstring = [[NSUserDefaults standardUserDefaults] objectForKey:@"Videos"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Videos"] != NULL) {
        arayofvideos =  (NSArray*)videosstring;
    }else
        arayofvideos = nil;
    */
     NSString* folderName =  [[self.pageURL stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"repository"];
    
    //Temporary
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];

   
    NSLog(@"folderName %@", folderName);
    
     NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList =  [manager contentsOfDirectoryAtPath:folderName error:nil];
    
    
    
    for (NSString *file in fileList){
        
        if([[file pathExtension] compare: @"mp4"] == NSOrderedSame )
         {
             [tempArray addObject:[NSString stringWithFormat:@"%@|Video Title", file]];
            
         }else if ([[file pathExtension] compare: @"ogv"] == NSOrderedSame ){
           
             [tempArray addObject:[NSString stringWithFormat:@"%@|Video Title", file]];
         }else if ([[file pathExtension] compare: @"mpeg"] == NSOrderedSame ){
               [tempArray addObject:[NSString stringWithFormat:@"%@|Video Title", file]];
         }else if ([[file pathExtension] compare: @"m4v"] == NSOrderedSame ){
                [tempArray addObject:[NSString stringWithFormat:@"%@|Video Title", file]];
         }

        
    }
    
    arrayofvideos = [tempArray copy];
    
    VideolistScrollViewController* controller = [[VideolistScrollViewController alloc] initWithArary:arrayofvideos];
    
    controller.repositoryURL = [[self.pageURL stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"repository"];
 
    controller.view.frame = CGRectMake(0, 0, 1024,130.0);
    controller.modalPresentationStyle = UIModalPresentationPopover;
    CGSize size = CGSizeMake(1024, 130.0); // size of view in popover
    [controller setPreferredContentSize:size];
    controller.delegate = self;
    
    [self presentViewController:controller animated:YES completion:nil];
    
    // configure the Popover presentation controller
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    popController.delegate = self;
    
    // in case we don't have a bar button as reference
    popController.sourceView = button;
    popController.sourceRect = CGRectMake( 0, 0, 10, 10);
   

    
    
}
- (void)tappedInToolbar:(BottomToolbar *)toolbar email:(UIButton *)button{
    // Email Subject
    NSString *emailTitle = @"PPM Deck";
    // Email Content
    NSString *messageBody = @"Comment \n";
    // To address
    NSArray *toRecipents = nil; //[NSArray arrayWithObject:@"support@appcoda.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    
    
    NSString *UUID = [[NSUUID UUID] UUIDString];

    
    
    //remove toolbars
    _bottomToolbar.alpha = 0.0f;
    _topToolbar.alpha = 0.0f;
    
    _bottomToolbar.hidden = YES;
    _topToolbar.hidden = YES;
    
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *data = UIImagePNGRepresentation(imageView);
    
    [mc  addAttachmentData:data mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@.png", UUID]];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
    
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)tappedInToolbar:(BottomToolbar *)toolbar draw:(UIButton *)button{
    //remove toolbars
    _bottomToolbar.alpha = 0.0f;
    _topToolbar.alpha = 0.0f;
    
    _bottomToolbar.hidden = YES;
    _topToolbar.hidden = YES;

    
    
    [self showComment: self];
    
    
}

#pragma mark Segue's methods
-(IBAction)showComment:(id)sender{
    
    [self performSegueWithIdentifier:@"ShowComment" sender:self];
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([[segue identifier] isEqualToString:@"ShowComment"])
    {
        
        UIImage *imageView;
        
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        imageView = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CommentViewController *commentViewController = [segue destinationViewController];
        commentViewController.currentImage = imageView;
        commentViewController.pageURL = self.pageURL;
        commentViewController.currentPage = self.currentPage;
        
        NSLog(@"PAGE CODE %@", self.currentPage.code);

    }
    
    
    
}


- (void)tappedInToolbar:(BottomToolbar *)toolbar note:(UIButton *)button{
    [self showNotes:button];
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}


#pragma mark  -Gesture

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    
    if(_bottomToolbar.hidden == YES){
        [UIView animateWithDuration:0.25 delay:0.0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^(void)
         {
             [_bottomToolbar setHidden:NO];
             _bottomToolbar.alpha = 1.0f;
             
             [_topToolbar setHidden:NO];
             _topToolbar.alpha = 1.0f;
             
         }
                         completion:NULL
         ];
        
        
        
    }else{ //FULL SCREEN
        
        [UIView animateWithDuration:0.25 delay:0.0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^(void)
         {
             _bottomToolbar.alpha = 0.0f;
             _topToolbar.alpha = 0.0f;
         }
                         completion:^(BOOL finished)
         {
             _bottomToolbar.hidden = YES;
             _topToolbar.hidden = YES;
         }
         ];
        
        
        
    }

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

+(NSString*)GUIDString {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string ;
}

- (IBAction) showNotes:(id) sender
{
    
    NotesViewController *controller = [[NotesViewController alloc] init];
    
    controller.Pagename = [self.pageURL lastPathComponent];
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    // configure the Popover presentation controller
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    popController.delegate = self;
    
    // in case we don't have a bar button as reference
    popController.sourceView = ((UIButton*)sender);
    popController.sourceRect = CGRectMake( 0, 0, 10, 10);

    
}

#pragma mark -VideolistViewController's Delegate
- (void)didSelectRowAtIndex:(NSInteger) index andVideo:(NSString*) videopath{
    
    CGRect frame = CGRectMake(1024, 0, 512, 768);
   
    
    if(testViewController == nil){
        testViewController = [[TestViewController alloc] init];
        testViewController.view.frame = frame;
       // testViewController.view.backgroundColor = [UIColor blackColor];
        testViewController.delegate = self;
        
        
        [self.view addSubview:testViewController.view];
    }
    
    
    
    [testViewController setVideopath:videopath];
    [testViewController playVideo];
    
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         //videoView.frame = CGRectMake(512, 0, 512, 768);
                         testViewController.view.frame = CGRectMake(512 , 0, 512, 768);
                         
                     }
                     completion:^(BOOL finished){
                        
                     }];
    
    
}
- (void)done:(TestViewController *)toolbar button:(UIButton *)button{
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         testViewController.view.frame = CGRectMake(1024, 0, 512, 700);
                     }
                     completion:^(BOOL finished){
                         
                     }];

}


@end
