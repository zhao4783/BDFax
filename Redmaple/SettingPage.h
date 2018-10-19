//
//  SettingPage.h
//  Redmaple
//
//  Created by Xiuwei Zhao on 4/19/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingPage : UITableViewController <UITextFieldDelegate>
{
    UITextField *webService;
    UITextField *username;
    UITextField *password;
    UITextField *senderName;
    UITextField *senderAddr;
    UITextField *senderComp;
    UITextField *senderPhon;
    UIButton *saveButton;
}
- (IBAction)OnLogin:(id)sender;
- (void)switchCoverpage;

@end
