//
//  DislunchoAppDelegate.h
//  Disluncho
//
//  Created by Paige Ponzeka on 4/13/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DislunchoAppDelegate : NSObject <UIApplicationDelegate, UIApplicationDelegate, UITabBarControllerDelegate> {
    IBOutlet UIButton *signinButton;
	IBOutlet UITextField *usernameInput;
	IBOutlet UITextField *passwordInput;

	int UserUNID;
	
}
@property (nonatomic, retain) IBOutlet UITextField *usernameInput;
@property (nonatomic, retain) IBOutlet UITextField *passwordInput;
@property int UserUNID;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UIButton *signinButton;

-(NSMutableArray *) sendAndRetrieve:(NSString *)parameters;
-(IBAction) showWarning:(id)sender; 
@end
