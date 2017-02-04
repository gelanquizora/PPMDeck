//
//  LoginViewController.h
//  ppmdeck
//
//  Created by Gereldyn Quizora on 29/12/2015.
//  Copyright © 2015 Gereldyn Quizora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "DashboardViewController.h"
#import "SSZipArchive.h"

@interface LoginViewController : UIViewController<NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDelegate, NSURLSessionDownloadDelegate, SSZipArchiveDelegate, MFMailComposeViewControllerDelegate>
{
     
}
@property (nonatomic) User *currentUser;
@property (strong, nonatomic) NSURLSessionDownloadTask *resumableTask;
@property (strong, nonatomic) NSURLSessionDownloadTask *backgroundTask;
@property (strong, nonatomic, readonly) NSURLSession *backgroundSession;
@end
