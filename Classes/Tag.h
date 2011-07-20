//
//  Tag.h
//  Tada
//
//  Created by sangho shin on 11. 5. 9..
//  Copyright 2011 ineed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"
#import "Todo.h"

@interface Tag : SQLitePersistentObject {
	NSString* name;
//	Todo* todo;
	NSMutableArray* todos;
}
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSMutableArray* todos;
//@property (nonatomic, retain) IBOutlet Todo* todo;
- (id) initWithName:(NSString*)_name;
@end
