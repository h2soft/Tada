//
//  Tag.m
//  Tada
//
//  Created by sangho shin on 11. 5. 9..
//  Copyright 2011 ineed. All rights reserved.
//

#import "Tag.h"


@implementation Tag
@synthesize name;
@synthesize todos;
//@synthesize todo;
- (id) initWithName:(NSString*)_name {
	self = [super init];
	if (self != nil) {
		self.name = _name;
		todos = [[NSMutableArray alloc] init];
	}
	return self;
}
-(NSString*) description {
	return name;
}

-(void) dealloc {
	[todos release];
//    [todo release];
	
}
@end
