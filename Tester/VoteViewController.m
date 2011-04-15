//
//  FirstViewController.m
//  Tester
//
//  Created by Paige Ponzeka on 4/13/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "VoteViewController.h"
#import "TesterAppDelegate.h"

@implementation VoteViewController

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

-(void) viewDidLoad
{
    [super viewDidLoad];
}
-(void) viewWillAppear:(BOOL)animated
{

}
- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction) logOut:(id)sender;
{
    
}

/*Called when the user clicks the 'Create New Vote" Button*/
-(IBAction) clickCreateVote: (id) sender
{
    //load the create vote tabbar navigation that displays the create vote options
    
    
    //the call to change the window in the app delegate
    // self.window.rootViewController = self.createVoteTabBarController;
    TesterAppDelegate* app = (TesterAppDelegate*)[UIApplication sharedApplication].delegate;
    app.window.rootViewController = app.createVoteTabBarController;
    

}

- (void)dealloc
{
    [super dealloc];
}

@end
