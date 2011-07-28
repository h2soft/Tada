//
//  Todo.m
//  Tada
//
//  Created by sangho shin on 11. 5. 9..
//  Copyright 2011 ineed. All rights reserved.
//

#import "Todo.h"
#import "Tag.h"
#import "ExtHeaders.h"

@implementation Todo
@synthesize name;
@synthesize finished;
@synthesize tags;
@synthesize dueDate;

static NSArray *query;
+ (void)initialize{
    
    query = [[NSArray arrayWithObjects:
              @"where finished == 0",
              @"where  date('now') > date(due_date) and date(due_date)  < date('now','+1 day') and finished == 0",
              @"where date(due_date) < date('now') and finished == 0",
              @"where finished == 1", 
              nil] retain];
}
- (id) initWithName:(NSString*)_name
{
	self = [super init];
	if (self != nil) {
		self.name = _name;
		tags = [[NSMutableArray alloc] init];
        self.dueDate = [NSDate date];
	}
	return self;
}
-(void) addTags:(NSString*) tags_string{
	
	NSArray* tag_str_list = [tags_string split:@","];
	for (NSString* tag_str in tag_str_list) {
		NSString* tag_without_space = [tag_str strip];
		Tag* tag = nil;
		NSArray *result = [Tag findByName:tag_without_space];
		if ([result count]==0) {
			tag = [[Tag alloc] initWithName:tag_without_space];
		}else {
			tag = [result objectAtIndex:0];
		}
		[self.tags addObject:tag];
		[tag.todos addObject:self];
	}	
}

+(NSArray*) findFinished {
	return [Todo findByFinished:[NSNumber numberWithInt:1]];
}
+(NSArray*) findWithQuery:(int)index {
	return [Todo findByCriteria:[query objectAtIndex:index]];
}

-(void) dealloc {
    [dueDate release];
    [super dealloc];
}

@end
