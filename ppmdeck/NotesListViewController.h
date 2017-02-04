//
//  NotesListViewController.h
//  ppmdeck
//
//  Created by Gereldyn Quizora on 05/03/2016.
//  Copyright © 2016 Gereldyn Quizora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <MessageUI/MessageUI.h>

@interface NotesListViewController : UIViewController< UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>

{
    UITableView *tableview;
   // NSFetchedResultsController *fetchedResultsController;
    //UISearchBar *searchbar;
    UITextView *txtNote;
    NSIndexPath *oldIndexPath;
    NSMutableArray *notes;
}


    @property (nonatomic, retain) NSArray *pages;
- (id)init;
- (NSManagedObjectContext *) managedObjectContext;


@end
