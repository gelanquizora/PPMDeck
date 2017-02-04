//
//  CommentViewController.m
//  ppmdeck
//
//  Created by Gereldyn Quizora on 19/01/2016.
//  Copyright © 2016 Gereldyn Quizora. All rights reserved.
//

#import "CommentViewController.h"
#import "ActiveDeckViewController.h"
//@interface CommentViewController ()
/*@property (weak, nonatomic)
    IBOutlet UIImageView *imgScreenshot;

@end
*/
@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//   _imgScreenshot.image = _currentImage;
    self.mainImage.image = _currentImage;
    noteFilename = [[CommentViewController GUIDString]  stringByAppendingPathExtension:@"png"];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIImage *minImage = [[UIImage imageNamed:@"slider-bar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    UIImage *maxImage = [[UIImage imageNamed:@"slider-bar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    UIImage *thumbImage = [UIImage imageNamed:@"slide-holder.png"];
    
    [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];

    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    opacity = 1.0;
    
    
    
    int redIntValue = self.red * 255.0;
    self.redControl.value = redIntValue;
    [self sliderChanged:self.redControl];
    
    int greenIntValue = self.green * 255.0;
    self.greenControl.value = greenIntValue;
    [self sliderChanged:self.greenControl];
    
    int blueIntValue = self.blue * 255.0;
    self.blueControl.value = blueIntValue;
    [self sliderChanged:self.blueControl];
    
   // self.brushControl.value = brush;
    [self sliderChanged:self.brushControl];
    
    self.opacityControl.value = self.opacity;
    [self sliderChanged:self.opacityControl];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pencilPressed:(id)sender {
    
    UIButton * PressedButton = (UIButton*)sender;
    
    switch(PressedButton.tag)
    {
        case 0:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 1:
            red = 105.0/255.0;
            green = 105.0/255.0;
            blue = 105.0/255.0;
            break;
        case 2: //red
            red = 255.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 3: //blue
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 255.0/255.0;
            break;
        case 4: //green
            red = 102.0/255.0;
            green = 204.0/255.0;
            blue = 0.0/255.0;
            break;
        case 5: //yellow green
            red = 102.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
        case 6:
            red = 51.0/255.0;
            green = 204.0/255.0;
            blue = 255.0/255.0;
            break;
        case 7:
            red = 160.0/255.0;
            green = 82.0/255.0;
            blue = 45.0/255.0;
            break;
        case 8:
            red = 255.0/255.0;
            green = 102.0/255.0;
            blue = 0.0/255.0;
            break;
        case 9:
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
    }
}

- (IBAction)eraserPressed:(id)sender {
    
    red = 255.0/255.0;
    green = 255.0/255.0;
    blue = 255.0/255.0;
    opacity = 1.0;
}




+(NSString*)GUIDString {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string ;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.drawing.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    NSLog(@"TOUCH BRUSH %f OPACITY %f", brush, opacity);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.drawing.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.drawing setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
   /* if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.drawing.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.drawing.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
   UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.drawing.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    
   
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
   // self.drawing.image = nil;
    //  self.mainImage.image = [UIImage imageNamed:@"1.png"];
    UIGraphicsEndImageContext(); */
    
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.drawing.image drawInRect:CGRectMake(0, 0, 1024, 768)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.drawing.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
//     UIGraphicsBeginImageContext(self.mainImage.frame.size);
  //  [self.mainImage.image drawInRect:CGRectMake(0, 0, 1024, 768) blendMode:kCGBlendModeNormal alpha:1.0];
  //  [self.drawing.image drawInRect:CGRectMake(0, 0,  1024, 768) blendMode:kCGBlendModeNormal alpha:opacity];
//   self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    
    
   
       // self.mainImage.image = self.drawing.image;
   // self.drawing.image = nil;
    UIGraphicsEndImageContext();
    
}

#pragma Settings

- (IBAction)sliderChanged:(id)sender {
    
    NSLog(@"VALUE CHANGED");
    UISlider * changedSlider = (UISlider*)sender;
    
    if(changedSlider == self.brushControl) {
        
        self.brush = self.brushControl.value;
        self.brushValueLabel.text = [NSString stringWithFormat:@"%.1f", self.brush];
         NSLog(@"BRUSH %f", self.brush);
        
         self.opacity = self.opacityControl.value;
        
    } else if(changedSlider == self.opacityControl) {
       
        self.opacity = self.opacityControl.value;
        self.opacityValueLabel.text = [NSString stringWithFormat:@"%.1f", self.opacity];
       
        
    } else if(changedSlider == self.redControl) {
        
        self.red = self.redControl.value/255.0;
        self.redLabel.text = [NSString stringWithFormat:@"R: %d", (int)self.redControl.value];
        
    } else if(changedSlider == self.greenControl){
        
        self.green = self.greenControl.value/255.0;
        self.greenLabel.text = [NSString stringWithFormat:@"G: %d", (int)self.greenControl.value];
    } else if (changedSlider == self.blueControl){
        
        self.blue = self.blueControl.value/255.0;
        self.blueLabel.text = [NSString stringWithFormat:@"B: %d", (int)self.blueControl.value];
        
    }
    
    UIGraphicsBeginImageContext(self.brushPreview.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(),self.brush);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, 1.0);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 45, 45);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 45, 45);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.brushPreview.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.opacityPreview.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(),self.brush);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, self.opacity);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),45, 45);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),45, 45);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.opacityPreview.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    [self changeSettings:self];
}

- (void)changeSettings:(id)sender { 
    brush = self.brush;
    opacity =  self.opacity;
    red =  self.red;
    green = self.green;
    blue = self.blue;
    
    
}


#pragma mark - toolbars
-(IBAction)showSettings:(id)sender{
    if(_settingsView.hidden == YES){
        [UIView animateWithDuration:0.25 delay:0.0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^(void)
         {
             [_settingsView setHidden:NO];
             _settingsView.alpha = 1.0f;
             
             
         }
                         completion:NULL
         ];
        
        
        
    }else{ //FULL SCREEN
        [UIView animateWithDuration:0.25 delay:0.0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^(void)
         {
             _settingsView.alpha = 0.0f;
             
         }
                         completion:^(BOOL finished)
         {
               _settingsView.hidden = YES;
             
             
             
         }
         ];
        
        
        
        
    }
}
-(IBAction)closeSettings:(id)sender{
    [self performSegueWithIdentifier:@"BackActiveDeck" sender:self];
}

- (IBAction)reset:(id)sender {
    
    self.mainImage.image = _currentImage;
   
    //_imgScreenshot.image = _currentImage;
    _drawing.image = nil;

    
}
-(IBAction)saveImage:(id)sender{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Save"
                                  message:@""
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Yes"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             [self saveImage];
                             NSLog(@"Saving.....");
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"No"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}



#pragma mark -Seque
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    
        ActiveDeckViewController *activeViewController = [segue destinationViewController];
        activeViewController.pageURL = self.pageURL;
    
    
}
-(void)saveImage{
  
    
    UIImage *image;
    
    _settingsView.hidden = YES;
    _saveButton.hidden = YES;
    _refreshButton.hidden = YES;
    _closeButton.hidden = YES;
    _settingsButton.hidden = YES;
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
   // _settingsView.hidden = NO;
     _settingsButton.hidden = NO;
    _saveButton.hidden = NO;
    _refreshButton.hidden = NO;
    _closeButton.hidden = NO;
    
    NSString *filePath = [[self createNotesFolder] stringByAppendingPathComponent: [NSString stringWithFormat:@"%@_%@"  ,self.currentPage.code, noteFilename ]];
    NSLog(@"IMAGE PATH %@", filePath);
    
    // Save image.
    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];

}

#pragma mark - App's Directory

-(NSString*) NotesDirectory{
    
    
     return [[self CacheDirectory] stringByAppendingPathComponent:@"content/Notes"] ;
    
}

-(NSString*) CacheDirectory{
    
    
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

-(NSString*) createNotesFolder{
    
    NSString *path = [self NotesDirectory];
    
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])	//Does directory already exist?
    {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:path
                                       withIntermediateDirectories:NO
                                                        attributes:nil
                                                             error:&error])
        {
            NSLog(@"Create directory error: %@", error);
            path = @"";
        }
    }
    
    
    return path;
}

@end
