//
//  TesterAppDelegate.m
//  Disluncho
//
//  Created by Paige Ponzeka on 4/13/11.
//  Copyright 2011 NYU. All rights reserved.
//
/*This is the heart of the Disluncho application*/

#import "TesterAppDelegate.h"

@implementation TesterAppDelegate


@synthesize window=_window;
@synthesize tabBarController=_tabBarController;
@synthesize createVoteTabBarController= __createVoteTabBarController;
@synthesize signinButton=_signinButton;
@synthesize UserUNID;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    //self.window.rootViewController = self.tabBarController;
    
    // Override point for customization after application launch.
    // Override point for customization after application launch.
    NSLog(@"Starting Up");
    //initialize warning messages 
    CONNECTION_ERROR = 0;
    USERNAME_ERROR = 1;
    PASSWORD_ERROR = 2;
    NOINPUT_ERROR = 3;
    CONNECTION_SUCCESS = 4;
	SENDING_DATA = 5;
	USERNAME_OR_PASSWORD_ERROR = 6;
    
    //creating warning messages array
    login_warnings =  [[NSMutableArray alloc] init];
    [login_warnings addObject:@"Connection Failed"];
    [login_warnings addObject:@"User Does Not Exist"];
    [login_warnings addObject:@"Password Invalid"];
    [login_warnings addObject:@"Please Input a Username and Password"];
    [login_warnings addObject:@"Connection Successful!"];
    [login_warnings addObject:@"Searching for your account . . ."];
    [login_warnings addObject:@"Username or Password is Incorrect"];

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
	if(!urlData) {
		NSLog(@"Connection Failed!");
		NSMutableArray *returnValues = [NSMutableArray arrayWithCapacity:0];
		return returnValues;
	}
	//turn response into String stripped of \n characters
	NSString *urlString = [[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding] 
						   stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] ; 
	
	//make string into 2D array [rows, fields]
	NSMutableArray *returnValues = [NSMutableArray arrayWithCapacity:100];
	
	[returnValues setArray:[urlString componentsSeparatedByString:@"|"]];
	for(int row=0; row< [returnValues count]; row++){
		[returnValues replaceObjectAtIndex:row withObject:
		 [[returnValues objectAtIndex:row] componentsSeparatedByString:@","]];
	}
	
	//Array of size [1,1] will be "" if there was no results, remove blank object for logic
	NSString* string = [NSString stringWithString:[[returnValues objectAtIndex:0]objectAtIndex:0]];
	if (NSOrderedSame == [string compare:@""]){
		[returnValues removeLastObject];
		NSLog(@"return arry of size [0,0] - NO RESULTS");
	}
	else{
	//print out return string size, row and fields
		[self printResults:returnValues];
	}
	
	return returnValues;
}/*
  *	prints out the result array to Log 
  */
-(void)printResults:(NSMutableArray*)results{
	NSLog(@"returned array of size = [ %i , %i ]\n",[results count], [[results objectAtIndex:0]count]);
	for(int j = 0; j<[results count]; j++){
		NSString* fields = [NSString  stringWithString:@""];
		for(int k = 0; k<[[results objectAtIndex:0]count]; k++){
			fields = [fields stringByAppendingString:[@"[" stringByAppendingString:
													  [[[results objectAtIndex:j]objectAtIndex:k] 
													   stringByAppendingString:@"]"]]];
		}
		NSLog(@"[row #%i]- %@ ",j,fields);
	}
}
-(IBAction) showWarning:(id)sender
{  
	NSLog(@"Logging into Username: %@, Password: %@", login_username.text, login_password.text);

	int sql_status = SENDING_DATA;
	
	//display a message to the user based on the connection results 
	[login_feedback setText:[login_warnings objectAtIndex: sql_status]];
	
	//things query will retrieve
	const int User_UNID = 0;
	
	//set up params for login query
	NSString *login = [[[[@"action=LOGIN" 
						  stringByAppendingString:@"&username=" ] stringByAppendingString:login_username.text]
						stringByAppendingString:@"&password="] stringByAppendingString:login_password.text];
	
	//create array and populate it with results from query
	NSMutableArray *user = [NSMutableArray arrayWithCapacity:100];
	[user setArray:[self sendAndRetrieve:login]];
	
	
	if([user count] == 0){
		NSLog(@"no record of that username and/or password LOGIN FAILED");
		//set a warning for the user to try again 
		//the results from the current SQL query
		int sql_status = USERNAME_OR_PASSWORD_ERROR;

		//display a message to the user based on the connection results 
		[login_feedback setText:[login_warnings objectAtIndex: sql_status]];
	}
	else{
		//set local user id  		
		UserUNID =  [[[user objectAtIndex:0] objectAtIndex:User_UNID] intValue];
		
		//switch to the user profile screen
		NSLog(@"Switching to User profile Screen for user #%i",UserUNID);
		self.window.rootViewController = self.tabBarController;
	}
    /*   
   
    
    if(sql_status == CONNECTION_SUCCESS)
    {//if the user has signed in show the user screen
        
        self.window.rootViewController = self.tabBarController;
    }*/
}

/*Called when the user presses the logout button*/
-(IBAction) logOut:(id)sender
{
    
}
- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}
/*Called when the user pressed the setLogout Button, 
 Brings the main signin window forward*/
-(void) setLogout
{
    self.window = _window;
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
