//
//  LoginViewController.m
//  ppmdeck
//
//  Created by Gereldyn Quizora on 29/12/2015.
//  Copyright © 2015 Gereldyn Quizora. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController () <NSURLSessionDownloadDelegate> {
    NSURLSession *inProcessSession;
    NSURLSessionDownloadTask *cancellableTask;
    NSData *partialDownload;
}

    @property (weak, nonatomic) IBOutlet UITextField *txtUsername;
    @property (weak, nonatomic) IBOutlet UITextField *txtPassword;
    @property (nonatomic, retain) NSMutableData *dataToDownload;
    @property (weak, nonatomic) IBOutlet UIProgressView *ProgresDownload;
    @property (nonatomic) float downloadSize;
@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
  }
-(void) viewDidAppear:(BOOL)animated{
    
   NSLog(@"PATH %@",  [[NSBundle mainBundle] pathForResource:@"PAGES" ofType:nil]);
    
    // Do any additional setup after loading the view.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL bl = [defaults boolForKey:@"LoggedIn"];
    if(bl == YES){
        [self performSegueWithIdentifier:@"Login" sender:self];
        NSLog(@"GO");
        
    }else
    {
        NSLog(@"Not");
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to dos a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    DashboardViewController *dashboard = [segue destinationViewController];
    self.currentUser = [[User alloc] init];
    self.currentUser.username = _txtUsername.text;
    self.currentUser.password = _txtPassword.text;
    
    dashboard.currentUser = self.currentUser;
    
    
    
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
         return YES;
}

#pragma mark - App's Directory

-(NSString*) ContentDirectory{
  
 
    //return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"content"];
    return [[self CacheDirectory] stringByAppendingPathComponent:@"content"] ;

}

-(NSString*) CacheDirectory{
    
    
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}



-(NSString*) createContentFolder{
    
    NSString *path = [self ContentDirectory];
    
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

-(NSString*) PagesDirectory{
    
    
    
    return  [[self ContentDirectory] stringByAppendingString:@"/PAGES"] ;
    
}

 /*-(IBAction)login:(id)sender
{
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
    
} */
 -(IBAction)login:(id)sender
{
 
 
 
 
    [self startResumableDownloadWith:[userinfo objectForKey:@"ActiveDeckURL"]];
   // [self startResumableDownloadWith: @"http://192.168.254.103/PPM/27/1.zip"];
    
    NSUserDefaults *saveDetails = [NSUserDefaults standardUserDefaults];
    //Get Login name
    
    //Get and store Videos
    [saveDetails setObject:@""  forKey:@"Videos"];
    //Get Presentation name
    [saveDetails setObject:@"TEST"  forKey:@"ActiveDeckTitle"];
    
    //Get Director's Treatment Passcode
    [saveDetails setObject:@"TEST" forKey:@"Passcode"];
    [saveDetails synchronize];
    
    

}

#pragma mark Connection

/*- (void)getReceivedData:(NSMutableData *)data sender:(RestAPI *)sender{
    NSLog(@"TEST");
}*/

-(void) startDownloadWith:(NSString*) urlString{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:urlString ];
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL: url];
    
    [dataTask resume];
 
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    completionHandler(NSURLSessionResponseAllow);
    _ProgresDownload.progress = 0.10f;
    _downloadSize=[response expectedContentLength];
    _dataToDownload=[[NSMutableData alloc]init];
   
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [_dataToDownload appendData:data];
    _ProgresDownload.progress=[ _dataToDownload length ]/_downloadSize;
    
    NSLog(@"progress %f", [ _dataToDownload length ]/_downloadSize);
    
}




#pragma mark - Download
-(void) startResumableDownloadWith:(NSString*)urlString{
    if(!self.resumableTask) {
        if(!inProcessSession) {
            // Create a 'private browsing' ses
            NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
            inProcessSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
            inProcessSession.sessionDescription = @"in-process NSURLSession";
        }
        
        if(partialDownload) {
            self.resumableTask = [inProcessSession downloadTaskWithResumeData:partialDownload];
            NSLog(@"partialDownload");
        } else {
        
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
            self.resumableTask = [inProcessSession downloadTaskWithRequest:request];
              NSLog(@"resumableTask %@", urlString );
        }
        
             [self.resumableTask resume];
    }
}

#pragma mark - NSURLSessionDownloadDelegate methods
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double currentProgress = totalBytesWritten / (double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
      //  self.progressIndicator.hidden = NO;
       // self.progressIndicator.progress = currentProgress;
        _ProgresDownload.progress = currentProgress;
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    // Leave this for now
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    // We've successfully finished the download. Let's save the file
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
   NSArray *URLs = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
   NSURL *documentsDirectory = URLs[0];
    
    
    //NSURL *destinationPath =[[NSURL URLWithString:[self createContentFolder] ]URLByAppendingPathComponent:[location lastPathComponent]];]
   
    
    NSURL *destinationPath = [documentsDirectory URLByAppendingPathComponent: @"PAGES.zip"];//[location lastPathComponent]];
    NSError *error;
    
    // Make sure we overwrite anything that's already there
    [fileManager removeItemAtURL:destinationPath error:NULL];
    
    // Make sure we overwrite anything that's already there
    [fileManager removeItemAtURL:destinationPath error:NULL];
    BOOL success = [fileManager copyItemAtURL:location toURL:destinationPath error:&error];
    if (success)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            BOOL bl = [SSZipArchive unzipFileAtPath:[destinationPath path] toDestination:[[self createContentFolder] stringByAppendingPathComponent:@"PAGES"] delegate:self];
            if(bl ==YES){
                NSUserDefaults *saveFile = [NSUserDefaults standardUserDefaults];
                [saveFile setBool:YES  forKey:@"LoggedIn"];
                [saveFile synchronize];
                [self performSegueWithIdentifier:@"Login" sender:self];
            }
        });
    }
    else
    {
        NSLog(@"Couldn't copy the downloaded file");
    }
    
    if(downloadTask == cancellableTask) {
        cancellableTask = nil;
    } else if (downloadTask == self.resumableTask) {
        self.resumableTask = nil;
        partialDownload = nil;
    } else if (session == self.backgroundSession) {
        self.backgroundTask = nil;
        // Get hold of the app delegate
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.backgroundURLSessionCompletionHandler) {
            // Need to copy the completion handler
            void (^handler)() = appDelegate.backgroundURLSessionCompletionHandler;
            appDelegate.backgroundURLSessionCompletionHandler = nil;
            handler();
        }
    }
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
       // self.progressIndicator.hidden = YES;
      //  [self setDownloadButtonsAsEnabled:YES];
    });
}


#pragma mark Unzipping
- (void)UnzippingWith:(NSString*)filePath andOutputPath:(NSString*)outputPath {
    
     NSString *zipPath = filePath;
    
    [SSZipArchive unzipFileAtPath:zipPath toDestination:outputPath delegate:self];
    
}

@end
