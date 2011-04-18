//
//  CreateVoteUsersViewController.h
//  Tester
//
//  Created by Paige Ponzeka on 4/15/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CreateVoteUsersViewController : UITableViewController {
    NSMutableArray *userNames;
}

@property (nonatomic, retain) NSMutableArray *userNames;
-(IBAction) goBack: (id)sender;
@end
