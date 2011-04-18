//
//  CreateVoteDestinationsViewController.h
//  Tester
//
//  Created by Paige Ponzeka on 4/15/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CreateVoteDestinationsViewController : UITableViewController {
    NSMutableArray *destinationNames;
}

@property (nonatomic, retain) NSMutableArray *destinationNames;
-(IBAction) goBack: (id)sender;
@end
