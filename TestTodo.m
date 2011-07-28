//
//  TaskTest.m
//  Tada
//
//  Created by sangho shin on 11. 5. 9..
//  Copyright 2011 ineed. All rights reserved.
//

#import "UnitTest.h"
#import "Todo.h"
#import "SQLiteInstanceManager.h"
#import "Tag.h"
#import "Logger.h"
#import "ExtHeaders.h"

@interface TestTodo : NSObject {
}
@end

@implementation TestTodo
-(void)setup{
	[[SQLiteInstanceManager sharedManager] deleteDatabase];
}
-(void)test_foo {
	assert_equal(2,1+1);
}
-(void)xtest_create {
	Todo *todo = [[Todo alloc] initWithName:@"write persist sample"];
	[todo save];
	Todo *todo_from_db = (Todo*)[Todo findByPK:1];
	assert_equal(todo_from_db.name , todo.name);
}
-(void)test_finished_todos{
	Todo *todo = [[Todo alloc] initWithName:@"write persist sample"];
	todo.finished = YES;
	[todo save];
	Todo *todo2 = [[Todo alloc] initWithName:@"retrive finished"];
	[todo2 save];

	NSArray* finished_todos = (NSArray*)[Todo findByFinished:[NSNumber numberWithInt:1]];
	assert_equal(1, [finished_todos count]);
}
-(void)test_tag_save{
	Tag* home = [[Tag alloc] init];
	home.name =@"home";
	[home save];
	home = [Tag findByPK:1];	
	assert_equal(@"home",home.name);	
}
-(void)test_taged_todo{
	Tag* home = [[Tag alloc] initWithName:@"home"];
	Todo *todo = [[Todo alloc] initWithName:@"buy milk"];
	[todo.tags addObject:home];
	[home.todos addObject:todo];
	[todo save];
	Todo *todo_from_db = (Todo*)[Todo findByPK:1];
	assert_equal(@"home", [[todo_from_db.tags objectAtIndex:0] name]);
	Tag *tag_from_db = (Tag*)[Tag findByPK:1];
	assert_equal(@"buy milk", [[tag_from_db.todos objectAtIndex:0] name]);
}
-(void)test_taged_todos_with_same_tag{
	Tag* home = [[Tag alloc] initWithName:@"home"];
	Todo *todo = [[Todo alloc] initWithName:@"buy milk"];
	[todo.tags addObject:home];
	[home.todos addObject:todo];
	[todo save];
	Todo *todo2 = [[Todo alloc] initWithName:@"buy bread"];
	[todo2.tags addObject:home];
	[home.todos addObject:todo];
	[todo2 save];
	
	Todo *todo_from_db = (Todo*)[Todo findByPK:1];
	assert_equal(@"home", [[todo_from_db.tags objectAtIndex:0] name]);
	Tag *tag_from_db = (Tag*)[Tag findByPK:1];
	assert_equal(@"buy milk", [[tag_from_db.todos objectAtIndex:0] name]);
}
-(void)test_save_todo_with_two_tags{
	Tag* tag1 = [[Tag alloc]initWithName:@"home"];
	[tag1 save];
	Todo* todo = [[Todo alloc] initWithName:@"todo with two tag"];
	[todo addTags:@"home, office, important"];
	[todo save];
	
	assert_equal(3, [[Tag allObjects] count]);
	
}
-(void) test_date_related{
	Todo *todo = [[Todo alloc] initWithName:@"due tomorrow"];
	todo.dueDate = [[NSDate date]nDaysAfter:1];
	log_info(@"now %@",[NSDate date]);
	log_info(@"tomorrow %@",todo.dueDate);
	[todo save];
	NSArray *arr = [Todo findByCriteria:@"where date(due_date) > date('now')"];
	assert_equal(1,[arr count]);

	todo = [[Todo alloc] initWithName:@"due YesterDay"];
	todo.dueDate = [[NSDate date] oneDayBefore];
	log_info(@"yesterday %@",todo.dueDate);
	[todo save];
	arr = [Todo findByCriteria:@"where date(due_date) < date('now')"];
	assert_equal(1,[arr count]);

	todo = [[Todo alloc] initWithName:@"due YesterDay"];
	todo.dueDate = [NSDate date] ;
	[todo save];
	arr = [Todo findByCriteria:@"where  date('now') > date(due_date) and date(due_date)  < date('now','+1 day')"];
	assert_equal(1,[arr count]);
}
-(void) test_date_with_array {
    NSArray *query = [NSArray arrayWithObjects:
                      @"where finished == 0",
                      @"where  date('now') > date(due_date) and date(due_date)  < date('now','+1 day') and finished == 0",
                      @"where date(due_date) < date('now') and finished == 0",
                      @"where finished == 1", 
                      nil];
    
	Todo *todo = [[Todo alloc] initWithName:@"due Tomorrow"];
	todo.dueDate = [[NSDate date]nDaysAfter:1];
	[todo save];
	todo = [[Todo alloc] initWithName:@"due YesterDay"];
	todo.dueDate = [[NSDate date] oneDayBefore];
	[todo save];
    todo = [[Todo alloc] initWithName:@"due Today"];
	todo.dueDate = [NSDate date] ;
	[todo save];
    todo = [[Todo alloc] initWithName:@"finished"];
	todo.dueDate = [[NSDate date] nDaysAfter:-5];
    todo.finished = YES;
	[todo save];

	NSArray *arr = [Todo findByCriteria:[query objectAtIndex:0]];
	assert_equal(3,[arr count]);

	arr = [Todo findByCriteria:[query objectAtIndex:1]];
	assert_equal(1,[arr count]);
    
	arr = [Todo findByCriteria:[query objectAtIndex:2]];
	assert_equal(1,[arr count]);

    arr = [Todo findByCriteria:[query objectAtIndex:3]];
	assert_equal(1,[arr count]);

}
-(void) xtest_todo_with_query {
    
	Todo *todo = [[Todo alloc] initWithName:@"due Tomorrow"];
	todo.dueDate = [[NSDate date]nDaysAfter:1];
	[todo save];
    NSArray *arr = [Todo findWithQuery:0];
	assert_equal(1,[arr count]);

    todo = [[Todo alloc] initWithName:@"due Today"];
	todo.dueDate = [NSDate date] ;
	[todo save];
    arr = [Todo findWithQuery:1];
	assert_equal(1,[arr count]);

	todo = [[Todo alloc] initWithName:@"due YesterDay"];
	todo.dueDate = [[NSDate date] oneDayBefore];
	[todo save];
	arr = [Todo findWithQuery:2];
	assert_equal(1,[arr count]);
    

    todo = [[Todo alloc] initWithName:@"finished"];
	todo.dueDate = [[NSDate date] nDaysAfter:-5];
    todo.finished = YES;
	[todo save];
    arr = [Todo findWithQuery:3];
	assert_equal(1,[arr count]);
}
-(void) test_find_by_tag_name{
	Todo* todo = [[Todo alloc] initWithName:@"todo with two tag"];
	[todo addTags:@"home, office, important"];
	[todo save];
	todo = [[Todo alloc] initWithName:@"todo with home tag"];
	[todo addTags:@"home"];
    todo.finished = YES;
	[todo save];

	Tag *tag = [[Tag findByName:@"home"] objectAtIndex:0];
    NSMutableArray *result = [NSMutableArray array]; 
	for (Todo *todo in tag.todos) {
		if (todo.finished) {
			[result addObject:todo];
		}
	}
    assert_equal(1, [result count]);
}

@end
