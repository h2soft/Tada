//
//  DetailViewController.h
//  Tada
//
//  Created by sangho shin on 11. 5. 9..
//  Copyright 2011 ineed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, UITableViewDelegate, UITableViewDataSource> {
    
    UIPopoverController *popoverController;
    UIToolbar *toolbar;
    
    id detailItem;
    UILabel *detailDescriptionLabel;
	UIPopoverController* createTodo;
	NSArray* todos;
	IBOutlet UITableView* table;
    NSString* selectedTag;
    NSIndexPath* selectedIndexPath;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) id detailItem;
@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;
@property (nonatomic, retain) NSArray* todos;
@property (nonatomic,retain) IBOutlet UITableView* table;
@property (nonatomic, retain) NSString* selectedTag;
@property (nonatomic, retain) NSIndexPath* selectedIndexPath;


-(IBAction) showCreateTodo:(id)sender ;
@end

@interface TodoCell : UITableViewCell
{
	IBOutlet UILabel* name;
	IBOutlet UILabel* tags;
	IBOutlet UIButton* finishedImage;
	IBOutlet UILabel* dueDate;
	Todo* todo;
}
@property (nonatomic,retain) IBOutlet UILabel* name;
@property (nonatomic,retain) IBOutlet UILabel* tags;
@property (nonatomic,retain) IBOutlet UIButton * finishedImage;

@property (nonatomic,retain) IBOutlet UILabel* dueDate;
@property (nonatomic,retain) Todo* todo;
-(IBAction) finishIt:(id)sender;
-(void) configureViewWithTodo:(Todo*)t;

@end

