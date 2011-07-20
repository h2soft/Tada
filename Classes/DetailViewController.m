//
//  DetailViewController.m
//  Tada
//
//  Created by sangho shin on 11. 5. 9..
//  Copyright 2011 ineed. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"
#import "TodoCreateViewController.h"
#import "Todo.h"
#import "TadaAppDelegate.h"
#import "Logger.h"
#import "ExtHeaders.h"
#import "Tag.h"

@interface DetailViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end



@implementation DetailViewController

@synthesize toolbar, popoverController, detailItem, detailDescriptionLabel;
@synthesize todos;
@synthesize table;
@synthesize selectedTag;
@synthesize selectedIndexPath;


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [todos count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 68;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellID = @"TodoCell";
	TodoCell *cell = (TodoCell*)[table dequeueReusableCellWithIdentifier:cellID];
	if (cell == nil) {
		NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"TodoCell" owner:self options:nil];
		cell = (TodoCell *)[arr objectAtIndex:0];
	}
	Todo *t = [todos objectAtIndex:indexPath.row];
	[cell configureViewWithTodo:t];
    return cell;
}

#pragma mark -
#pragma mark Managing the detail item
-(IBAction) showCreateTodo:(id)sender {
	if(createTodo && [createTodo isPopoverVisible]){
		[createTodo dismissPopoverAnimated:YES];
		return;
	}
	
	TodoCreateViewController* createVC =  [[TodoCreateViewController alloc] initWithNibName:@"TodoCreateViewController" bundle:nil];
	createVC.contentSizeForViewInPopover = CGSizeMake(320, 460);
	createTodo = [[UIPopoverController alloc] initWithContentViewController:createVC];
	[createTodo presentPopoverFromBarButtonItem:sender
				permittedArrowDirections:UIPopoverArrowDirectionUp
								animated:YES];
}
/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setSelectedIndexPath:(NSIndexPath *)newSelectedIndexPath {
    if (selectedIndexPath !=newSelectedIndexPath ) {
        [selectedIndexPath release];
        selectedIndexPath = newSelectedIndexPath;
        [self configureView];
    }
    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }        

}
- (void)setDetailItem:(id)newDetailItem {
    if (detailItem != newDetailItem) {
        [detailItem release];
        detailItem = [newDetailItem retain];
        
        // Update the view.
        [self configureView];
    }

    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }        
}


- (void)configureView {
    if (selectedIndexPath.section == 0) {
        self.todos = [Todo findWithQuery:selectedIndexPath.row];
    }else{
        Tag *tag = [[Tag findByName:selectedTag] objectAtIndex:0];
        NSMutableArray *result = [NSMutableArray array]; 
        for (Todo *todo in tag.todos) {
            if (!todo.finished) {
                [result addObject:todo];
            }
        }
        self.todos = result;
    }
	[table reloadData];
}


#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    
    barButtonItem.title = @"Root List";
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.todos = [Todo allObjects];
}

- (void)viewDidUnload {
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [popoverController release];
    [toolbar release];
    
    [detailItem release];
    [detailDescriptionLabel release];
    [todos release];
    [super dealloc];
}

@end

@implementation TodoCell

@synthesize name;
@synthesize tags;
@synthesize finishedImage;

@synthesize dueDate;
@synthesize todo;
-(void) configureViewWithTodo:(Todo*)t{
	self.todo = t;
	self.name.text = t.name;
	self.tags.text = [t.tags componentsJoinedByString:@", "];
	if (t.finished)
		[self.finishedImage setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal]; 
	
	self.dueDate.text = [t.dueDate year_month_day_MINUS];
	
}
-(IBAction) finishIt:(id)sender{
	self.todo.finished = YES;
	[todo save];
	[((TadaAppDelegate*)[UIApplication sharedApplication].delegate) configureView];
}
-(void)dealloc {
	[todo release];
}

@end

