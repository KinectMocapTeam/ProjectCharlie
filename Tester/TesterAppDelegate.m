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
    
    //creating warning messages array
    login_warnings =  [[NSMutableArray alloc] init];
    [login_warnings addObject:@"Connection Failed"];
    [login_warnings addObject:@"User Does Not Exist"];
    [login_warnings addObject:@"Password Invalid"];
    [login_warnings addObject:@"Please Input a Username and Password"];
    [login_warnings addObject:@"Connection Successful!"];

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

-(IBAction) showWarning:(id)sender
{
           //switch to the user profile screen
        NSLog(@"Switching to USer profile Screen");
    NSLog(@"Button Pressed");
    NSString *given_username= [login_username text];
    NSString *given_password= [login_password text];
    NSLog(@"Username: %@, Password: %@", given_username, given_password);
    //run the SQL code to get the user info
    
    //the results from the current SQL query
    int sql_status = CONNECTION_SUCCESS;
    
    
    //display a message to the user based on the connection results 
    [login_feedback setText:[login_warnings objectAtIndex: sql_status]];
    
    if(sql_status == CONNECTION_SUCCESS)
    {//if the user has signed in show the user screen
        
        self.window.rootViewController = self.tabBarController;
    }
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
