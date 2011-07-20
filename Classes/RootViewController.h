//
//  RootViewController.h
//  Tada
//
//  Created by sangho shin on 11. 5. 9..
//  Copyright 2011 ineed. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface RootViewController : UITableViewController {
    DetailViewController *detailViewController;
	NSArray* tags;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, retain) NSArray* tags;
-(void) configureView;

@end
