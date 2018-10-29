//
//  WorkspaceVO.h
//  BDSiPadApp
//
//  Created by Lion User on 13/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkspaceUsers.h"
#import "DirectoryVO.h"
#import "BDSFile.h"

@interface WorkspaceVO : NSObject {
    int packageId;
    NSString *name;
    NSString *description;
    NSString *tags;
    BOOL hideWorkspaceActivity;
    WorkspaceUsers *workspaceUsers;
    NSMutableArray *documentVOs;
    NSMutableArray *commentVOs;
    NSMutableArray *activityVOs;
    NSString *status;
    NSString *latestVersion;
    NSString *latestPublishedVersion;
    int createdBy;
    NSString *autoDelDate;
    NSString *autoDelReminderDate;
    NSString *autoDelReminderSentDate;
    NSString *dateCreated;
    int lastUpdatedBy;
    NSString *dateLastUpdated;
    NSString *lastActivityDate;
    int validPrimaryOwnerCount;
    long size;
    int rootDirectoryId;
    BOOL locked;
    int lockedBy;    
    NSString *parsedDateCreated;
    NSString *parsedDateLastUpdated;    
    NSString *managersAddressList;
    NSString *collaboratorsAddressList;
    NSString *viewersAddressList; 
    
    BOOL requesterManager;
    BOOL requesterCollaborator;
    BOOL requesterViewer;
    
    int totalComment;
    int totalActivity;
    
    NSString *parsedAutoDelDate;
    NSString *parsedAutoDelReminderDate;
    
    BDSFile *directoryVO;
}

- (int) getPackageId;
- (void) setPackageId : (int) packageId;

- (NSString *) getName;
- (void) setName : (NSString *) name;

- (NSString *) getDescription;
- (void) setDescription : (NSString *) description;

- (NSString *) getTags;
- (void) setTags : (NSString *) tags;

- (BOOL) isHideWorkspaceActivity;
- (void) setHideWorkspaceActivity : (BOOL) workspaceActivity;

- (WorkspaceUsers *) getWorkspaceUsers;
- (void) setWorkspaceUsers : (WorkspaceUsers *) workspaceUsers;

- (void) setDocumentVOs : (NSMutableArray*) docuVOs;
- (NSMutableArray*) getDocumentVOs;

- (void) setCommentVOs : (NSMutableArray*) commentVOs;
- (NSMutableArray*) getCommentVOs;

- (void) setActivityVOs : (NSMutableArray*) activityVOs;
- (NSMutableArray*) getActivityVOs;

- (NSString *) getStatus;
- (void) setStatus : (NSString *) status;

- (NSString *) getLatestVersion;
- (void) setLatestVersion : (NSString *) latestVersion;

- (NSString *) getLatestPublishedVersion;
- (void) setLatestPublishedVersion : (NSString *) latestPublishedVersion;

- (int) getCreatedBy;
- (void) setCreatedBy : (int) createdBy;

- (NSString *) getAutoDelDate;
- (void) setAutoDelDate : (NSString *) autoDelDate;

- (NSString *) getAutoDelReminderDate;
- (void) setAutoDelReminderDate : (NSString *) autoDelReminderDate;

- (NSString *) getAutoDelReminderSentDate;
- (void) setAutoDelReminderSentDate : (NSString *) autoDelReminderSentDate;

- (NSString *) getDateCreated;
- (void) setDateCreated : (NSString *) dateCreated;

- (int) getLastUpdatedBy;
- (void) setLastUpdatedBy : (int) lastUpdatedBy;

- (NSString *) getDateLastUpdated;
- (void) setDateLastUpdated : (NSString *) dateLastUpdated;

- (NSString *) getLastActivityDate;
- (void) setLastActivityDate : (NSString *) lastActivityDate;

- (int) getValidPrimaryOwnerCount;
- (void) setValidPrimaryOwnerCount : (int) validPrimaryOwnerCount;

- (long) getSize;
- (void) setSize : (long) size;

- (int) getRootDirectoryId;
- (void) setRootDirectoryId : (int) rootDirectoryId;

- (BOOL) isLocked;
- (void) setLocked : (BOOL) locked;

- (int) getLockedBy;
- (void) setLockedBy : (int) lockedBy;

- (void) setParsedDateCreated : (NSString*) parsedCreatedDate;
- (NSString*) getParsedDateCreated;

- (void) setParsedDateLastUpdated : (NSString*) parsedLastUpdatedDate;
- (NSString*) getParsedDateLastUpdated;

- (void) setManagersAddressList : (NSString*) managersAddressList;
- (NSString*) getManagersAddressList;

- (void) setCollaboratorsAddressList : (NSString*) collaboratorsAddressList;
- (NSString*) getCollaboratorsAddressList;

- (void) setViewersAddressList : (NSString*) viewersAddressList;
- (NSString*) getViewersAddressList;

- (BOOL) isRequesterManager;
- (void) setRequesterManager : (BOOL) requesterManager;

- (BOOL) isRequesterCollaborator;
- (void) setRequesterCollaborator : (BOOL) requesterCollaborator;

- (BOOL) isRequesterViewer;
- (void) setRequesterViewer : (BOOL) requesterViewer;

- (int) getTotalComment;
- (void) setTotalComment : (int) totalCommnt;

- (int) getTotalActivity;
- (void) setTotalActivity : (int) totalActivty;

- (NSString *) getParsedAutoDelDate;
- (void) setParsedAutoDelDate : (NSString *) prsAutoDelDate;

- (NSString *) getParsedAutoDelReminderDate;
- (void) setParsedAutoDelReminderDate : (NSString *) prsAutoDelReminderDate;

- (BDSFile *) getDirectoryVO;
- (void) setDirectoryVO : (BDSFile *) dirVO;

@end
