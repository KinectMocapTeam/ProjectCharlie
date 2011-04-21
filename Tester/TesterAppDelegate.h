//
//  TesterAppDelegate.h
//  Tester
//
//  Created by Paige Ponzeka on 4/13/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TesterAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    IBOutlet UIButton *signinButton;
    
    //number values for warning messages
    int CONNECTION_ERROR;
    int USERNAME_ERROR;
    int PASSWORD_ERROR;
    int NOINPUT_ERROR;
    int CONNECTION_SUCCESS;
	int SENDING_DATA;
	int USERNAME_OR_PASSWORD_ERROR;
    
    //Array of warnings and messages for signinFeedback
    NSMutableArray *login_warnings;
    
    //Feedback label for user signin
    IBOutlet UILabel *login_feedback;
    
    //text fields for given user login name and password
    IBOutlet UITextField *login_username;
    IBOutlet UITextField *login_password;
	
	//local storage of signin information
	int UserUNID;


}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UITabBarController *createVoteTabBarController;
@property (nonatomic, retain) IBOutlet UIButton *signinButton;
@property int UserUNID;

-(IBAction) showWarning:(id)sender;
-(NSMutableArray *) sendAndRetrieve:(NSString *)parameters;
-(IBAction) logOut:(id)sender;
-(void) setLogout;
-(void) printResults:(NSMutableArray *)results;
@end
