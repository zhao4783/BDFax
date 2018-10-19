//
//  ShareViewController.m
//  ShareExt
//
//  Created by Xiuwei Zhao on 6/5/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController
const NSString * APP_SHARE_URL_SCHEME = @"redmaple-shareurlscheme";
NSInteger inputItemCount = 0;
NSMutableArray *inputItemsArray = nil;
UIActivityIndicatorView *spinner = nil;
NSString* documentPath = @"";

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect = self.view.frame;
    int nScreenWidth = rect.size.width;
    inputItemsArray = [[NSMutableArray alloc] init];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.frame = CGRectMake(nScreenWidth-90, 20, 40, 40);
    [self.view addSubview:spinner];
    spinner.hidden = YES;
    NSURL* containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.bdfax.extension"];
    documentPath = containerURL.path;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSExtensionItem * item = self.extensionContext.inputItems.firstObject;
    inputItemCount = item.attachments.count;
    
    spinner.hidden = NO;
    [spinner startAnimating];
    
    // Iterate through the attached files
    for ( NSItemProvider * itemProvider in item.attachments )
    {
        // Check if we are sharing a JPEG
        if ( [ itemProvider hasItemConformingToTypeIdentifier: @"public.image" ] )
        {
            // Load it, so we can get the path to it
            [ itemProvider loadItemForTypeIdentifier: @"public.image"
                                             options: NULL
                                   completionHandler: ^ ( NSData * imageData, NSError * error )
             {
                 static int itemIdx = 0;
                 static int index = 0;
                 
                 if ( NULL != error )
                 {
                     NSLog( @"There was an error retrieving the attachments: %@", error );
                 }
                 else
                 {
                     NSString* fileName = [NSString stringWithFormat:@"imageShared%d.jpg", index];
                     NSString* filePath = [documentPath stringByAppendingPathComponent:fileName];
                     if( [imageData writeToFile:filePath atomically:YES] )
                         index += 1;
                 }
                 
                 // If we have reached the last attachment, it's time to hand control to the app:
                 if ( ++itemIdx >= inputItemCount )
                 {
                     NSString* urlString = [NSString stringWithFormat:@"%@://files%d.jpg", APP_SHARE_URL_SCHEME, index];
                     NSURL* url = [NSURL URLWithString:urlString];
                     NSString* className = @"UIApplication";
                     if( NSClassFromString(className) )
                     {
                         id object = [NSClassFromString(className) performSelector:@selector(sharedApplication)];
                         [object performSelector:@selector(openURL:) withObject:url];
                     }
                     
                     [spinner stopAnimating];
                     spinner.hidden = YES;
                     [inputItemsArray removeAllObjects];
                     exit(0);
                 }
             } ];
        }
    }
}

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return @[];
}

@end
