//
//  TodoCreateViewController.m
//  Tada
//
//  Created by sangho shin on 11. 5. 11..
//  Copyright 2011 ineed. All rights reserved.
//

#import "TodoCreateViewController.h"
#import "Todo.h"
#import "TadaAppDelegate.h"

@implementation TodoCreateViewController

-(void)viewDidLoad{
    date.date = [NSDate date];
}

-(IBAction)save{
	Todo* todo = [[Todo alloc] initWithName:name.text];
	[todo addTags:tags.text];
	todo.dueDate = date.date;
	[todo save];
	[((TadaAppDelegate*)[UIApplication sharedApplication].delegate) configureView];
	//[self dismissModalViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {

    [super dealloc];
}


@end
