//
//  CreateVoteDestinationsViewController.h
//  Tester
//
//  Created by Paige Ponzeka on 4/15/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TesterAppDelegate.h"

@interface CreateVoteDestinationsViewController : UITableViewController {
    NSMutableArray *destinationNames;
	int PLACE_NAME;
	int PLACE_UNID;
	TesterAppDelegate* root;
}

@property (nonatomic, retain) NSMutableArray *destinationNames;
@property (nonatomic, retain) TesterAppDelegate *root;
-(IBAction) goBack: (id)sender;
@end
