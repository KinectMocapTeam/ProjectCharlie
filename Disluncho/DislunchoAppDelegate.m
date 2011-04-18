//
//  DislunchoAppDelegate.m
//  Disluncho
//
//  Created by Paige Ponzeka on 4/13/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "DislunchoAppDelegate.h"

@implementation DislunchoAppDelegate

@synthesize UserUNID;
@synthesize usernameInput;
@synthesize passwordInput;
@synthesize window=_window;

@synthesize tabBarController=_tabBarController;
@synthesize signinButton=_signinButton;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    //self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}
/*
 *will return 2D array of results[row,field] 
 *must send parameters as (@"action=____&otherParamName=___& ...")
 *all queries are therefore created and stored in the php file and called by their action= parameter
 *
 */
-(NSMutableArray*)sendAndRetrieve:(NSString *)parameters
{
	//set up urlRequest
	NSData *parametersData = [parameters dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:NO];
	NSMutableURLRequest *urlRequest = [[[NSMutableURLRequest alloc] 
										initWithURL:[NSURL URLWithString:@"http://ponzeka.com/iphone_disluncho/disluncho_test.php"]]
									   autorelease];
	[urlRequest setHTTPMethod:@"POST"];
	[urlRequest setHTTPBody:parametersData];
	
	//variables to store retrieved data
	NSData *urlData; 
	NSURLResponse *response; 
	NSError *error;
	
	//connect to url and get response
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error]; 
	
	//check for errors
	if(!urlData) NSLog(@"Connection Failed!");

	//turn response String stripped of \n characters
	NSString *urlString = [[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding] 
							stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] ; 
	

	NSMutableArray *returnValues = [NSMutableArray arrayWithCapacity:100];
	

	//make string into 2D array [rows, fields]
	[returnValues setArray:[urlString componentsSeparatedByString:@"|"]];
	for(int row=0; row< [returnValues count]; row++){
		[returnValues replaceObjectAtIndex:row withObject:
		[[returnValues objectAtIndex:row] componentsSeparatedByString:@","]];
	}
	
	//print out return string size, row and fields
	NSLog(@"returned string = %@\n",urlString);
	NSLog(@"returned array of size = [ %i , %i ]\n",[returnValues count], [[returnValues objectAtIndex:0]count]);
	for(int j = 0; j<[returnValues count]; j++){
		NSString* fields = [NSString  stringWithString:@""];
		for(int k = 0; k<[[returnValues objectAtIndex:0]count]; k++){
			fields = [fields stringByAppendingString:[@"[" stringByAppendingString:
													  [[[returnValues objectAtIndex:j]objectAtIndex:k] 
													   stringByAppendingString:@"]"]]];
		}
		NSLog(@"[%i]- %@ ",j,fields);
	}
	
	//Array of size [1,1] will be "" if there was no results, remove blank object for logic
	if (NSOrderedSame == [[[returnValues objectAtIndex:0]objectAtIndex:0] compare:@""]){
		[returnValues removeLastObject];
	}
	return returnValues;
}

-(IBAction) showWarning:(id)sender
{
	//things query will retrieve
	const int User_UNID = 0;
	
	//set up params for login query
	NSString *login = [[[[@"action=LOGIN" 
						stringByAppendingString:@"&username=" ] stringByAppendingString:usernameInput.text]
							 stringByAppendingString:@"&password="] stringByAppendingString:passwordInput.text];
	
	//create array and populate it with results from query
	NSMutableArray *user = [NSMutableArray arrayWithCapacity:100];
	[user setArray:[self sendAndRetrieve:login]];

	
	if([user count] == 0){
		NSLog(@"no record of that username and/or password");
		//set a warning for the user to try again
	}
	else{
		//set local user id  		
		UserUNID =  [[[user objectAtIndex:0] objectAtIndex:User_UNID] intValue];
		
		//switch to the user profile screen
		NSLog(@"Switching to User profile Screen for user #%i",UserUNID);
		self.window.rootViewController = self.tabBarController;
	}
	
}

- (void)dealloc
{	
    [_window release];
    [_tabBarController release];
	[super dealloc];
}
-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
	[theTextField resignFirstResponder];
	return TRUE;
}
/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
 }
 */

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */

@end
