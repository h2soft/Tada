//
//  Todo.h
//  Tada
//
//  Created by sangho shin on 11. 5. 9..
//  Copyright 2011 ineed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface Todo : SQLitePersistentObject {
	NSString* name;
	BOOL finished;
	NSMutableArray* tags;
	NSDate* dueDate;
}
@property (nonatomic, retain) NSString* name;
@property (nonatomic) BOOL finished;
@property (nonatomic, retain) NSMutableArray* tags;
@property (nonatomic, retain) NSDate* dueDate;
- (id) initWithName:(NSString*)_name;
-(void) addTags:(NSString*) tags_string;
+(NSArray*) findWithQuery:(int)index;
@end
