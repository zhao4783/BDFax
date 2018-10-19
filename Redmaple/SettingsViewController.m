//
//  SettingsViewController.m
//  MobileFax
//
//  Created by Zhao                                                     on 8/15/17.
//  Copyright © 2017 Zhao                                                    . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageViewController.h"
#import "SettingsViewController.h"


///////////////////////////////////////////////////
//
//

@implementation SettingsViewController

extern UISegmentedControl *colorAnnoSegments;
extern UISegmentedControl *lineAnnoSegments;
extern UISegmentedControl *fontSizeAnnoSegments;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    NSString *ret = nil;
    if( section == 0 )
        ret = @"Font size";
    if( section == 1 )
        ret = @"Line width";
    if( section == 2 )
        ret = @"Color";
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CellIdentifier = [NSString stringWithFormat:@"Line - %ld", (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    if( indexPath.section == 0 )
    {
        [cell.contentView addSubview:fontSizeAnnoSegments];
    }
    if( indexPath.section == 1 )
    {
        [cell.contentView addSubview:lineAnnoSegments];
    }
    if( indexPath.section == 2 )
    {
        [cell.contentView addSubview:colorAnnoSegments];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont boldSystemFontOfSize:15];
    header.textLabel.textColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1.0];
}

@end
