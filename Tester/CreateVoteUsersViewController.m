//
//  CreateVoteUsersViewController.m
//  Tester
//
//  Created by Paige Ponzeka on 4/15/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "CreateVoteUsersViewController.h"
#import "TesterAppDelegate.h"

@implementation CreateVoteUsersViewController
@synthesize userNames;
@synthesize root;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
	
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/
/*Logouts a user and brings forward the main signin window from the app delegate*/
-(IBAction) goBack: (id)sender
{
    NSLog(@"Going Back");
    TesterAppDelegate* app = (TesterAppDelegate*)[UIApplication sharedApplication].delegate;
    app.window.rootViewController = app.tabBarController;
    [app release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidLoad {
    //set up pointer to the root
	root = (TesterAppDelegate*)[UIApplication sharedApplication].delegate;

	//index variables for sql results
	USERNAME = 0;
	USERID = 1;
	
	//title the selections
	self.title = NSLocalizedString(@"Select users", "add them to the list");
	
	//get all users from database --- later perhaps just users that have email/phone# in your contacts
	NSString* allUsers = [NSString stringWithString:@"action=LIST_ALL_USERS"];
	NSMutableArray* userValues = [root sendAndRetrieve:allUsers];
	
    //load the usernames
    userNames= [[NSMutableArray alloc] initWithCapacity:15]; 
	for(int user = 0; user< [userValues count]; user++){
	    [userNames addObject:[[userValues objectAtIndex:user] objectAtIndex:USERNAME] ];
	}
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// There is only one section.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of time zone names.
	return [userNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	// Try to retrieve from the table view a now-unused cell with the given identifier.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	// If no cell is available, create a new one using the given identifier.
	if (cell == nil) {
		// Use the default cell style.
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
	}
	
	// Set up the cell with the usernames
	cell.textLabel.text = [userNames objectAtIndex:indexPath.row];
  
	return cell;
}

/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
 */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    //give a check mark to selected rows
    if (cell.accessoryType == UITableViewCellAccessoryNone)
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	else
		cell.accessoryType = UITableViewCellAccessoryNone;
    
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	return indexPath;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
