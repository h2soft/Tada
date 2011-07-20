//
//  TestZForUI.m
//  Tada
//
//  Created by sangho shin on 11. 5. 10..
//  Copyright 2011 ineed. All rights reserved.
//
#import "DataForUITest.h"
#import "UnitTest.h"
#import "Todo.h"
#import "Tag.h"
#import "SQLiteInstanceManager.h"
#import "ExtHeaders.h"




@implementation DataForUITest

+(void) test_data_for_ui {	

	[[SQLiteInstanceManager sharedManager] deleteDatabase];	
	
	Todo *todo = [[Todo alloc] initWithName:@"buy milk"];
	todo.dueDate = [NSDate date];
	[todo addTags:@"home"];
	[todo save];

	todo = [[Todo alloc] initWithName:@"buy bread"];
	[todo addTags:@"home"];
	todo.dueDate = [NSDate date];
	[todo save];
	
	todo = [[Todo alloc] initWithName:@"todo with two tag"];
	[todo addTags:@"home, office"];
	todo.dueDate = [NSDate dateFrom:2011 month:6 day:30];
	[todo save];

	todo = [[Todo alloc] initWithName:@"finish"];
	[todo addTags:@"office,      house, sssssssss    "];
	todo.dueDate = [NSDate dateFrom:2011 month:6 day:30];
	[todo save];
		
}

@end
