//
//  DashboardViewController.h
//  ppmdeck
//
//  Created by Gereldyn Quizora on 29/12/2015.
//  Copyright © 2015 Gereldyn Quizora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "IconCell.h"
#import "ActiveDeckViewController.h"

@interface DashboardViewController : UIViewController<IconCellDelegate>
{
    
    UILabel *lblDate;
    UILabel  *lblDay;
    UILabel *lblTimeAM;
    UILabel *label;
    
    NSTimer *timer;
    NSString *pageURL;
    NSMutableArray *pages;
}
@property (nonatomic) User *currentUser;

@property(nonatomic) NSInteger currentPageIndex;


@end
