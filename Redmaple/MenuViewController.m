//
//  MenuViewController.m
//  MobileFax
//
//  Created by Zhao                                                     on 8/15/17.
//  Copyright © 2017 Zhao                                                    . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuViewController.h"
#import "PageViewController.h"

extern bool bAnnotationOn;

///////////////////////////////////////////////////
//
//

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    labels[0] =     @[@"Attach the current page",
                      @"Attach all pages"];
    imageNames[0] = @[@"Attachment.png",
                      @"Attachment.png"];
    
    labels[1] =     @[@"Photo library",
                      @"Camera",
                      @"iCloud drive"];
    imageNames[1] = @[@"Photos.png",
                      @"Camera.png",
                      @"iCloud.png"];

    labels[2] =     @[@"Annotation toolbar",
                      @"Convert to Black/White",
                      @"Rotate image",
                      @"Crop image in box",
                      @"Crop image in ellipse",
                      @"Delete current page",
                      @"Delete all pages"];
    imageNames[2] = @[@"Annotation.png",
                      @"RotateIcon_v2.png",
                      @"Rotate.png",
                      @"Crop.png",
                      @"Crop.png",
                      @"DeleteAll.png",
                      @"DeleteAll.png"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int cnt = 1;
    if( section == 0 ) cnt = 2;
    if( section == 1 ) cnt = 3;
    if( section == 2 ) cnt = 7;
    return cnt;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    NSString *ret = nil;
    if( section == 0 )
        ret = @"Attach";
    if( section == 1 )
        ret = @"Open image from";
    if( section == 2 )
        ret = @"Functions";
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CellIdentifier = [NSString stringWithFormat:@"Line - %ld", (long)(indexPath.row)];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSInteger style = indexPath.section == 2 && indexPath.row == 0 ? UITableViewCellStyleValue1 : UITableViewCellStyleDefault;
        cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = [labels[indexPath.section] objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[imageNames[indexPath.section] objectAtIndex:indexPath.row]];
    if( indexPath.section == 2 && indexPath.row == 0 )
    {
        cell.detailTextLabel.text = !bAnnotationOn ? @"On" : @"Off";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont boldSystemFontOfSize:15];
    header.textLabel.textColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.75 alpha:1.0];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [viewerPage onMenuCancel];
    [self performSelector:@selector(doSelectMenu:) withObject:indexPath afterDelay:0.2];
}

- (void)doSelectMenu:(NSIndexPath *)indexPath
{
    if( indexPath.section == 0 )
    {
        [viewerPage forSavingPages:indexPath.row];
    }
    if( indexPath.section == 1 && indexPath.row == 0 )
    {
        [viewerPage onPhotoLibrary];
    }
    if( indexPath.section == 1 && indexPath.row == 1 )
    {
        [viewerPage onTakePicture];
    }
    if( indexPath.section == 1 && indexPath.row == 2 )
    {
        bBackToSendPage = false;
        [viewerPage onICloudDrive];
    }
    if( indexPath.section == 2 && indexPath.row == 0 )
    {
        [viewerPage setAnnotationBar];
    }
    if( indexPath.section == 2 && indexPath.row == 1 )
    {
        [viewerPage showSpinner:YES];
        [viewerPage performSelector:@selector(convertBWImage) withObject:nil afterDelay:0.1];
    }
    if( indexPath.section == 2 && indexPath.row == 2 )
    {
        [viewerPage onRotate];
    }
    if( indexPath.section == 2 && indexPath.row == 3 )
    {
        [contentVC onCrop:NO];
    }
    if( indexPath.section == 2 && indexPath.row == 4 )
    {
        [contentVC onCrop:YES];
    }
    if( indexPath.section == 2 && indexPath.row == 5 )
    {
        [viewerPage onDeleteCurrentPage];
    }
    if( indexPath.section == 2 && indexPath.row == 6 )
    {
        [viewerPage onDeleteAllPages];
    }
}

@end

