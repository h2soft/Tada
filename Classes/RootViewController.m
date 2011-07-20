//
//  RootViewController.m
//  Tada
//
//  Created by sangho shin on 11. 5. 9..
//  Copyright 2011 ineed. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "Tag.h"
#import "Todo.h"


@implementation RootViewController

@synthesize detailViewController;
@synthesize tags;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	[self configureView];
	
}
-(void) configureView {
	self.tags =[Tag allObjects];
	[self.tableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}


// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if (section==0) return @"todos";
	else return @"tags";
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) return 4;
    else return [tags count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // section에 따라 cell의 text를 채운다.
	NSString* cell_text;
	if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell_text=@"all"; break;
            case 1:
                cell_text=@"due today"; break;
            case 2:
                cell_text=@"over due"; break;
            case 3:
                cell_text=@"finished"; break;
            default:
                break;
        }
	}else {
		cell_text = [[tags objectAtIndex:indexPath.row] name];
	}
    cell.textLabel.text = cell_text;
    return cell;
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        detailViewController.selectedTag = [[tags objectAtIndex:indexPath.row] name];
    }
    detailViewController.selectedIndexPath = indexPath;
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [detailViewController release];
    [tags release];
    [super dealloc];
}


@end

