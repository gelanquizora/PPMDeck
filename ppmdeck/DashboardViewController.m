//
//  DashboardViewController.m
//  ppmdeck
//
//  Created by Gereldyn Quizora on 29/12/2015.
//  Copyright © 2015 Gereldyn Quizora. All rights reserved.
//

#import "DashboardViewController.h"
#import "NotesListViewController.h"
#import "Page.h"

#define ICONWIDTH  192.8f //188.0f //145.0f //135.0f //104.0f
#define ICONHEIGHTBIG 354.0f //269.0f
#define ICONHEIGHTSMALL 177.0f //134.5f
#define CELLPADDING 1.0f
#define ICONHEIGHT 213.0f

@interface DashboardViewController ()

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Welcome %@", self.currentUser.username);
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    self.view.autoresizesSubviews = YES;
    pages = [[NSMutableArray alloc] init];
    
    //Initialize Thumbnails---------------------------------
    float x = 30;
    float y = 30;
    float y2 = 30 + ICONHEIGHTSMALL + CELLPADDING;
    
    IconCell *iconCell;
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y, ICONWIDTH, ICONHEIGHTBIG)];
    iconCell.icon = [UIImage imageNamed:@"newcover.png"];
    iconCell.delegate = self;
    iconCell.tag = 100;
    iconCell.index = 0;
    iconCell.pageName = @"ct01.html";
    iconCell.title = @"Cover";
    [self.view addSubview:iconCell];
    Page *page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];
    
    
    x += ICONWIDTH + CELLPADDING ;
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y, ICONWIDTH, ICONHEIGHTSMALL)];
    iconCell.icon = [UIImage imageNamed:@"newattendees.png"];
    iconCell.delegate = self;
    iconCell.tag = 101;
    iconCell.index = 1;
    iconCell.pageName = @"at01.html";
    iconCell.title = @"Attendees";
    [self.view addSubview:iconCell];
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];

    
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y2, ICONWIDTH, ICONHEIGHTSMALL)];
    iconCell.icon = [UIImage imageNamed:@"newagenda.png"];
    iconCell.delegate = self;
    iconCell.tag = 102;
    iconCell.index = 2;
    iconCell.pageName = @"ag01.html";
      iconCell.title = @"Agenda";
    [self.view addSubview:iconCell];
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];

    
    x += ICONWIDTH + CELLPADDING ;
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y, ICONWIDTH, ICONHEIGHTBIG)];
    iconCell.icon = [UIImage imageNamed:@"newadvertising.png"];
    iconCell.delegate = self;
    iconCell.tag = 103;
    iconCell.index = 3;
    iconCell.pageName = @"ao01.html";
      iconCell.title = @"Advertising";
    [self.view addSubview:iconCell];
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];

    
    
    x += ICONWIDTH + CELLPADDING ;
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y, ICONWIDTH, ICONHEIGHTSMALL)];
    iconCell.icon = [UIImage imageNamed:@"newtarget.png"];
    iconCell.delegate = self;
    iconCell.tag = 105;
    iconCell.index = 5;
    iconCell.pageName = @"tm01.html";
      iconCell.title = @"Target";
    [self.view addSubview:iconCell];
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];

    
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y2, ICONWIDTH, ICONHEIGHTSMALL)];
    iconCell.icon = [UIImage imageNamed:@"newmood.png"];
    iconCell.delegate = self;
    iconCell.tag = 104;
    iconCell.index = 4;
    iconCell.pageName = @"mt01.html";
    iconCell.title = @"Mood";
    
    [self.view addSubview:iconCell];
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];

    
    x += ICONWIDTH + CELLPADDING ;
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y, ICONWIDTH, ICONHEIGHTBIG)];
    iconCell.icon = [UIImage imageNamed:@"newagency.png"];
    iconCell.delegate = self;
    iconCell.tag = 106;
    iconCell.index = 6;
     iconCell.pageName = @"ab01.html";
      iconCell.title = @"Agency";
    [self.view addSubview:iconCell];
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];

    
    //Second Row------------------
    
    y +=ICONHEIGHTBIG + CELLPADDING;
    x = 30;
    y2 = y + ICONHEIGHTSMALL + CELLPADDING;
    
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y, ICONWIDTH, ICONHEIGHTBIG)];
    iconCell.icon = [UIImage imageNamed:@"newdirectors.png"];
    iconCell.delegate = self;
    iconCell.tag = 107;
    iconCell.index = 7;
    iconCell.pageName = @"dt01.html";
    iconCell.title = @"Director's Treatment";
    [self.view addSubview:iconCell];
    
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];

    
    x += ICONWIDTH + CELLPADDING ;
    
    
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y, ICONWIDTH, ICONHEIGHTSMALL)];
    iconCell.icon = [UIImage imageNamed:@"newproduction.png"];
    iconCell.delegate = self;
    iconCell.tag = 108;
    iconCell.index = 8;
     iconCell.pageName = @"pd01.html";
    iconCell.title = @"Production";
    [self.view addSubview:iconCell];
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];

    
    
    
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y2 - CELLPADDING, ICONWIDTH, ICONHEIGHTSMALL)];
    iconCell.icon = [UIImage imageNamed:@"newnotes.png"];
    iconCell.delegate = self;
    iconCell.tag = 200;
    iconCell.index = 20;
    
    iconCell.title = @"Notes";
    [self.view addSubview:iconCell];
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];

    
    x += ICONWIDTH + CELLPADDING ;
    
    
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y, ICONWIDTH, ICONHEIGHTSMALL)];
    iconCell.icon = [UIImage imageNamed:@"newlocation.png"];
    iconCell.delegate = self;
    iconCell.tag = 109;
    iconCell.index = 9;
     iconCell.pageName = @"ln01.html";
    iconCell.title = @"Location";
    [self.view addSubview:iconCell];
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];
    
    
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y2 - CELLPADDING, ICONWIDTH, ICONHEIGHTSMALL)];
    iconCell.icon = [UIImage imageNamed:@"newsoundtrack.png"];
    iconCell.delegate = self;
    iconCell.tag = 110;
    iconCell.index = 10;
    iconCell.title = @"Soundtrack";
    [self.view addSubview:iconCell];
     iconCell.pageName = @"st01.html";
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];
    
    x += ICONWIDTH + CELLPADDING ;
    
    
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y2 - CELLPADDING, ICONWIDTH, ICONHEIGHTSMALL)];
    iconCell.icon = [UIImage imageNamed:@"newtimetable.png"];
    iconCell.delegate = self;
    iconCell.tag = 111;
    iconCell.index = 11;
    iconCell.title = @"Timetable";
     iconCell.pageName = @"tt01.html";
    [self.view addSubview:iconCell];
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];
    
    
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y, ICONWIDTH, ICONHEIGHTSMALL)];
    iconCell.icon = [UIImage imageNamed:@"newdirectory.png"];
    iconCell.delegate = self;
    iconCell.tag = 113;
    iconCell.index = 13;
     iconCell.pageName = @"dr01.html";
    iconCell.title = @"Directory";
    [self.view addSubview:iconCell];
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];
    
    
    x += ICONWIDTH + CELLPADDING ;
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y, ICONWIDTH, ICONHEIGHTSMALL)];
    iconCell.icon = [UIImage imageNamed:@"newmaps.png"];
    iconCell.delegate = self;
    iconCell.tag = 112;
    iconCell.index = 12;
    iconCell.pageName = @"mp01.html";
    iconCell.title = @"Maps";
    [self.view addSubview:iconCell];
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];
    
    
    iconCell = [[IconCell alloc] initWithFrame:CGRectMake(x, y2 - CELLPADDING, ICONWIDTH, ICONHEIGHTSMALL)];
    iconCell.icon = [UIImage imageNamed:@"time.png"];
    iconCell.tag = 114;
    iconCell.index = 14;
    iconCell.title = @"Time";
    [self.view addSubview:iconCell];
    page = [[Page alloc] init];
    page.title = iconCell.title;
    page.filename =  iconCell.pageName;
    [pages addObject:  page];
    
    
    
    //Label--------------------------------------------
    
    CGRect titleRect = CGRectMake(x + 100, y2 +  20, 50, 60);
    label = [[UILabel alloc] initWithFrame:titleRect];
    
    
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:50];
    label.textColor =  [UIColor colorWithWhite:1.0f alpha:.9f];
    label.backgroundColor = [UIColor clearColor];
    label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:label];
    
    
    lblTimeAM = [[UILabel alloc] initWithFrame:CGRectMake(x + 150, y2 + 20, 35, 30)];
    lblTimeAM.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0f];
    lblTimeAM.textColor =  [UIColor colorWithWhite:1.0f alpha:.6f];
    lblTimeAM.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblTimeAM];
    
    lblDay = [[UILabel alloc] initWithFrame:CGRectMake(x + 30, y2 + 70, 120, 30)];
    lblDay.font = [UIFont fontWithName:@"Helvetica Neue" size:13.0f];
    lblDay.textColor =  [UIColor colorWithWhite:1.0f alpha:.6f];
    lblDay.backgroundColor = [UIColor clearColor];
    lblDay.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:lblDay];
    
    lblDate = [[UILabel alloc] initWithFrame:CGRectMake(x + 30, y2 + 85, 120, 30)];
    lblDate.font = [UIFont fontWithName:@"Helvetica Neue" size:11.0f];
    lblDate.textColor =  [UIColor colorWithWhite:1.0f alpha:.6f];
    lblDate.backgroundColor = [UIColor clearColor];
    lblDate.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:lblDate];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewDidAppear:(BOOL)animated{
    
   
    
    
    
    
    
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(tick:) userInfo:NULL repeats:YES];
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IconCellDelegate's methods
- (void)select:(IconCell *)cell{
    cell.pageName = @"st01.html";
    pageURL =[NSString stringWithFormat:@"%@/%@", [self PagesDirectory] , cell.pageName];
    NSLog(@"SELCT %tu %@", cell.index, pageURL);
   
   // [_delegate select:self title:cell.title andIndex:cell.index];
    [self activate:cell];
    if(cell.index == 20)
          [self performSegueWithIdentifier:@"ShowCommentsList" sender:self];
    
    else
        [self showSelectedDeck: self];
    
    
}
- (void)activate:(IconCell *)cell{
    
    
    if(_currentPageIndex == cell.index)
        return;
   
    
    IconCell *oldCell = (IconCell*)[self.view viewWithTag:  _currentPageIndex + 100];
    [oldCell unselect];
    _currentPageIndex = cell.index;
    
}

#pragma mark - Timer's method

-(void) tick:(NSTimer*)t{
    NSDate *now =[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];//@"MM-dd-yy HH:mm:ss"];
    
     label.text = [dateFormatter stringFromDate:now];
    [dateFormatter setDateFormat:@"a"];
     lblTimeAM.text =  [dateFormatter stringFromDate:now];
    
    [dateFormatter setDateFormat:@"EEEE"];
     lblDay.text =  [[dateFormatter stringFromDate:now] uppercaseString];
    
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
     lblDate.text =  [[dateFormatter stringFromDate:now] uppercaseString];
    
}
#pragma mark Segue's methods
-(IBAction)showSelectedDeck:(id)sender{
    
    [self performSegueWithIdentifier:@"ShowSelectedDeck" sender:self];
    
    
}
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
    
     NSString *viewControllerString = NSStringFromClass([[segue destinationViewController] class])  ;
     if([viewControllerString isEqualToString:@"ActiveDeckViewController"] )
     {
         ActiveDeckViewController *activeDeck = [segue destinationViewController];
         activeDeck.pageURL = pageURL;
         activeDeck.currentPage = [pages objectAtIndex:_currentPageIndex];
     }else //notes
     {
         NotesListViewController *notesViewController = [segue destinationViewController];
         notesViewController.pages  = [pages copy];
     }
   
     
}


-(NSString*) ContentDirectory{
    
    
    //return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"content"];
    
    return [[self CacheDirectory] stringByAppendingPathComponent:@"content"] ;
    
}

-(NSString*) PagesDirectory{
   //NSString *str=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"PAGES"];
    
    
    //return str;
    return  [[self ContentDirectory] stringByAppendingString:@"/PAGES"] ;
}
-(NSString*) CacheDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}


@end
