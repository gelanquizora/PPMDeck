//
//  NotesListViewController.m
//  ppmdeck
//
//  Created by Gereldyn Quizora on 05/03/2016.
//  Copyright © 2016 Gereldyn Quizora. All rights reserved.
//

#import "NotesListViewController.h"

#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import "Page.h"


@interface NotesListViewController ()

    @property (nonatomic, retain) UITableView *tableview;
    @property (nonatomic, retain) UISearchBar *searchbar;


@end

@implementation NotesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"notesbackground.png"] ]];
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

- (id)init{
    self = [super init];
    if (self) {
        /*
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
               NSEntityDescription *entity =
        [NSEntityDescription entityForName:@"Note"
                    inManagedObjectContext:[self managedObjectContext]];
        
        
        
        NSSortDescriptor *datecreated = [[NSSortDescriptor alloc] initWithKey:@"datecreated"   ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: datecreated, nil];
        fetchRequest.sortDescriptors = sortDescriptors;
        
        // [fetchRequest setPredicate: [NSPredicate predicateWithFormat:@"spine ==%@ AND bookid=%@", spine, bookID]];
        
       
        
        [fetchRequest setEntity:entity];
        if([[searchbar text] length] > 0){
            [fetchRequest setPredicate: [NSPredicate predicateWithFormat:@"text==%@", [searchbar text]]];
        }
        
        
        fetchedResultsController =  [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest  managedObjectContext:[self managedObjectContext]  sectionNameKeyPath:nil  cacheName:nil];
        fetchedResultsController.delegate = self;
        
        NSError *fetchingError = nil;
        if ([fetchedResultsController performFetch:&fetchingError]){
            NSLog(@"Successfully fetched. %d", [fetchedResultsController.fetchedObjects count]);
        } else {
            NSLog(@"Failed to fetch.");
        }
        
        
        */
        
        
    }
    
    return self;
}




-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
    /*//Add Search bar
    self.searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(200, 190, 155, 23)];
    //  searchbar.tintColor = [UIColor whiteColor];
    [[[_searchbar subviews] objectAtIndex:0] setAlpha:0.0];
    _searchbar.placeholder = @"Search";
    _searchbar.backgroundImage = [UIImage imageNamed:@"notessearchblank.png"];
    _searchbar.clipsToBounds = YES;
    
    // Configure your images
    UIImage *backgroundImage = [UIImage imageNamed:@"notessearchblank.png"];
    UIImage *searchFieldImage = [[UIImage imageNamed:@"notessearchblank.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    // Set it to your UISearchBar appearance
    [[UISearchBar appearance] setBackgroundImage:backgroundImage];
    [[UISearchBar appearance] setSearchFieldBackgroundImage:searchFieldImage forState:UIControlStateNormal];
    
    _searchbar.backgroundColor = [UIColor whiteColor];
    _searchbar.layer.cornerRadius=1;
    _searchbar.layer.borderWidth= 1;
    _searchbar.layer.borderColor=[UIColor grayColor].CGColor;
    
    [self.view addSubview:_searchbar];
    
    
    
    UIButton *btnsearch = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnsearch.frame = CGRectMake(360, 190, 50, 23);
    [btnsearch addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnsearch setBackgroundImage:[UIImage imageNamed:@"notessearchbutton.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnsearch];
    
     */
    
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnClose.frame = CGRectMake(900, 45, 83, 48);
    [btnClose addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnClose setBackgroundImage:[UIImage imageNamed:@"top-button-done.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnClose];
    
    txtNote = [[UITextView alloc] init];
    txtNote.frame = CGRectMake(500, 250, 300, 300);
    
    [self.view addSubview:txtNote];
    
    [self loadData];
    
}


- (void)loadView
{
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    contentView.autoresizesSubviews = YES;
    contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    contentView.backgroundColor = [UIColor clearColor];
    
    [self setView:contentView];
    
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(200, 280, 210, 300) style:UITableViewStylePlain];
    [_tableview setAutoresizesSubviews:YES];
    [_tableview setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    
    
    [_tableview setDataSource:self];
    [_tableview setDelegate:self];
    _tableview.separatorColor = [UIColor clearColor];
    _tableview.rowHeight = 30.0f;
    [[self view] addSubview:_tableview];
}

-(void) loadData{
    /*NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
     
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"Note"
                inManagedObjectContext:[self managedObjectContext]];
    
    
    
    NSSortDescriptor *datecreated = [[NSSortDescriptor alloc] initWithKey:@"datecreated"   ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: datecreated, nil];
    
    fetchRequest.sortDescriptors = sortDescriptors;
    
    
    
    [fetchRequest setEntity:entity];
    
    if([[_searchbar text] length] > 0){
        
        NSString *searchText = [_searchbar text];
        
        NSString *complexPredicateFormat = [NSString stringWithFormat:@"text contains[cd] '%@'", searchText];
        [fetchRequest setPredicate: [NSPredicate predicateWithFormat:complexPredicateFormat]];
    }
   
    
    
    
    
    fetchedResultsController =  [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest  managedObjectContext:[self managedObjectContext]  sectionNameKeyPath:nil  cacheName:nil];
    fetchedResultsController.delegate = self;
    
    NSError *fetchingError = nil;
    if ([fetchedResultsController performFetch:&fetchingError]){
        NSLog(@"Successfully fetched. %d", [fetchedResultsController.fetchedObjects count]);
    } else {
        NSLog(@"Failed to fetch.");
    }
      */
    
    
    
    [_tableview reloadData];
    
    
}

- (NSString*)getTextWith:(NSString*) filepath
{
    NSString *path = [[[self ContentDirectory] stringByAppendingPathComponent:@"Notes"] stringByAppendingPathComponent: [filepath stringByAppendingPathExtension:@"txt"]];
    NSString *stringContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return stringContent;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
 //   id <NSFetchedResultsSectionInfo> sectionInfo = [fetchedResultsController.sections  objectAtIndex:section];
    return [self.pages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    Page *page = [self.pages objectAtIndex:indexPath.row];
     NSString *text = page.title;
    
    if([text length ] > 30)
        cell.textLabel.text =  [[text substringToIndex:30] stringByAppendingString:@"..."];
    else
    cell.textLabel.text =  text ;
  
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"m/d/yyyy"];
    
 //   cell.detailTextLabel.text = [formatter stringFromDate:note.datemodified];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
    
    
    //Create the button and add it to the cell
    UIButton *_btnEmail = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    _btnEmail.frame = CGRectMake(185, 8, 19, 16);
    [_btnEmail addTarget:self action:@selector(email:) forControlEvents:UIControlEventTouchUpInside];
    [_btnEmail setBackgroundImage:[UIImage imageNamed:@"cellemail.png"] forState:UIControlStateNormal];
    [_btnEmail setBackgroundImage:[UIImage imageNamed:@"cellemail.png"] forState:UIControlStateHighlighted];
    [cell addSubview:_btnEmail];
    
    
    
    
    return cell;
}


- (void)tableView: (UITableView *)tableView willDisplayCell: (UITableViewCell *)cell forRowAtIndexPath: (NSIndexPath *)indexPath {
    
    if (indexPath.row %2) { //change the "%2" depending on how many cells you want alternating.
        // UIColor *altCellColor = [UIColor colorWithRed:255/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]; //this can be changed, at the moment it sets the background color to red.
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"notescellB.png"]];//altCellColor;
        
    }
    else {
        // UIColor *altCellColor2 =  [UIColor colorWithRed:255/255.0 green:153/255.0 blue:102/255.0 alpha:1.0]; //this can be changed, at the moment it sets the background color to white.
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"notescellA.png"]];;
    }
    
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // A case was selected, so push into the CaseDetailViewController
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //if (![cell selectionStyle] == UITableViewCellSelectionStyleNone) {
    // Handle tap code here
    cell.backgroundColor = [UIColor colorWithRed:255/255.0 green:153/255.0 blue:102/255.0 alpha:1.0];
    //}
    
    
   // Note *note = [fetchedResultsController objectAtIndexPath:indexPath];
    
    Page *page = [self.pages objectAtIndex:indexPath.row];
    txtNote.text = [self getTextWith:page.filename];
    
    
    
    
    
    if(oldIndexPath != nil)
    {
        UITableViewCell *oldcell = [tableView cellForRowAtIndexPath:oldIndexPath];
        oldcell.backgroundColor = [UIColor clearColor];
        if (oldIndexPath.row %2)
            oldcell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"notescellB.png"]];
        else
            oldcell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"notescellA.png"]];;
        
    }
    
    oldIndexPath = indexPath;
    
}


#pragma mark Search
-(IBAction)search:(id)sender{
    
    
    [_searchbar resignFirstResponder];
    [self loadData];
    
    
}

- (IBAction)done:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.view removeFromSuperview];
}
#pragma mark Private methods
-(IBAction)email:(id)sender
{
    
    //Get the superview from this button which will be our cell
    UITableViewCell *owningCell = (UITableViewCell*)[sender superview];
    
    //From the cell get its index path.
    NSIndexPath *pathToCell = [self.tableview indexPathForCell:owningCell];
    
    Page *page = [self.pages objectAtIndex:[pathToCell row]];
    
    
    NSString *emailTitle =[NSString stringWithFormat:@"PPM Deck Notes - %@",  page.title];
    // Email Content
    NSString *messageBody = @"--------Notes here------";
    // To address
    NSArray *toRecipents = nil;
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    
    
  
    
    NSString* folderName = [[self ContentDirectory] stringByAppendingPathComponent:@"notes"];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList =  [manager contentsOfDirectoryAtPath:folderName error:nil];
    
 
    
    for (NSString *file in fileList){
        
        if( [[file pathExtension] compare: @"png"] == NSOrderedSame && [file hasPrefix:page.code])
        {
                NSLog(@"FILES %@", file);
            NSData *data = UIImagePNGRepresentation([UIImage imageWithContentsOfFile: [folderName stringByAppendingPathComponent:file]]);
            [mc  addAttachmentData:data mimeType:@"image/png" fileName:file];
            
        }
        
     }
    
    
    
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
    
}

#pragma mark - Email

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

#pragma mark - App's Directory

-(NSString*) ContentDirectory{
    
    
  return [[self CacheDirectory] stringByAppendingPathComponent:@"content"] ;
    
}

-(NSString*) CacheDirectory{
    
    
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}



@end
