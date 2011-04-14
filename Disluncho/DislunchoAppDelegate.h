//
//  DislunchoAppDelegate.h
//  Disluncho
//
//  Created by Paige Ponzeka on 4/13/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DislunchoAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
