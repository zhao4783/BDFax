//
//  ContactsViewController.h
//  Redmaple
//
//  Created by Xiuwei Zhao on 5/30/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsViewController : UITableViewController
{
    UISegmentedControl *contactSegments;
    UIButton *btAdd;
    UIButton *btDelete;
    UIActivityIndicatorView *spinner;
}

@end
