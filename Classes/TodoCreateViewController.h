//
//  TodoCreateViewController.h
//  Tada
//
//  Created by sangho shin on 11. 5. 11..
//  Copyright 2011 ineed. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TodoCreateViewController : UIViewController {
	IBOutlet UITextField* name;
	IBOutlet UITextField* tags;
	IBOutlet UIDatePicker* date;
	
}

-(IBAction) save;
@end
