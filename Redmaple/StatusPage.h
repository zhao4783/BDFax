//
//  StatusPage.h
//  Redmaple
//
//  Created by Xiuwei Zhao on 6/5/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusPage : UITableViewController
{
    NSMutableArray *sentLogArray;
    UIActivityIndicatorView *spinner;
}
@property (strong, nonatomic) NSMutableArray *sentLogArray;

- (IBAction)OnRefresh:(id)sender;

- (void)showSpinner:(BOOL)bShow;

@end
