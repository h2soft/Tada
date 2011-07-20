//
//  TestDetailVC.m
//  Tada
//
//  Created by sangho shin on 11. 5. 23..
//  Copyright 2011 ineed. All rights reserved.
//

#import "UnitTest.h"
#import "Todo.h"
#import "Logger.h"
#import "ExtHeaders.h"
#import "DetailViewController.h"
#import "SQLiteInstanceManager.h"
#import "Tag.h"

@interface TestDetailVC : NSObject
{	
}
@end

@implementation TestDetailVC
-(void)setup{
	[[SQLiteInstanceManager sharedManager] deleteDatabase];
	Tag* home = [[Tag alloc] initWithName:@"home"];
	Todo *todo = [[Todo alloc] initWithName:@"buy milk"];
	[todo.tags addObject:home];
	[home.todos addObject:todo];
	[todo save];
	Todo *todo2 = [[Todo alloc] initWithName:@"buy bread"];
	[todo2.tags addObject:home];
	[home.todos addObject:todo];
	[todo2 save];	
}
-(void) test_configure_view {
	DetailViewController *vc = [[DetailViewController alloc] init];
	vc.selectedTag = @"home";
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:1];
	vc.selectedIndexPath = path;
	[vc configureView];
	assert_equal(2, [vc.todos count]);
}
@end
