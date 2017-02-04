//
//  NotesViewController.m
//  ppmdeck
//
//  Created by Gereldyn Quizora on 14/02/2016.
//  Copyright © 2016 Gereldyn Quizora. All rights reserved.
//

#import "NotesViewController.h"

@interface NotesViewController ()
   
@end



@implementation NotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    txtView = [[UITextView alloc] init];
    txtView.textAlignment = NSTextAlignmentLeft;
    txtView.frame = CGRectMake(10, 10, 355, 590);
    txtView.text =  [self getText];
    [self.view addSubview:txtView];
   
   
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(saveFile:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Save" forState:UIControlStateNormal];
    button.frame = CGRectMake(5.0, 610, 160.0, 40.0);
    [self.view addSubview:button];
    
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnCancel addTarget:self  action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    btnCancel.frame = CGRectMake(210.0, 610, 160.0, 40.0);
    [self.view addSubview:btnCancel];
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

-(IBAction)saveFile:(id)sender{
    
    [self saveText];
}


-(IBAction)cancel:(id)sender
{
    NSLog(@"CANCEL");
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)saveText{
    NSString *someText = txtView.text;
    NSString *path = [[self createNotesFolder] stringByAppendingPathComponent:  [self.Pagename stringByAppendingPathExtension:@"txt"]];
    [someText writeToFile:path atomically:YES
                   encoding:NSUTF8StringEncoding error:nil];
}


- (NSString*)getText
{
    NSString *path = [[self createNotesFolder] stringByAppendingPathComponent:  [self.Pagename stringByAppendingPathExtension:@"txt"]];
    NSString *stringContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return stringContent;
}

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
