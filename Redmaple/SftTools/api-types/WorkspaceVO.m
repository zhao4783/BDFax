//
//  WorkspaceVO.m
//  BDSiPadApp
//
//  Created by Lion User on 13/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WorkspaceVO.h"

@implementation WorkspaceVO

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
    }
    
    return self;
}


- (int) getPackageId {
    return packageId;
}

- (void) setPackageId : (int) packgeId {
    packageId = packgeId;
}

- (NSString *) getName {
    return name;
}

- (void) setName : (NSString *) nam {
    name = nam;
}

- (NSString *) getDescription {
    return description;
}

- (void) setDescription : (NSString *) dscription {
    description = dscription;
}

- (NSString *) getTags {
    return tags;
}

- (void) setTags : (NSString *) tag {
    tags = tag;
}

- (BOOL) isHideWorkspaceActivity {
    return hideWorkspaceActivity;
}

- (void) setHideWorkspaceActivity : (BOOL) wrkspaceActivity {
    hideWorkspaceActivity = wrkspaceActivity;
}

- (WorkspaceUsers *) getWorkspaceUsers {
    return workspaceUsers;
}

- (void) setWorkspaceUsers : (WorkspaceUsers *) wrkspaceUsers {
    workspaceUsers = wrkspaceUsers;
}

- (NSMutableArray*) getDocumentVOs {
    return documentVOs;
}

- (void) setDocumentVOs : (NSMutableArray*) docuVOs {
    documentVOs = docuVOs;
}

- (void) setCommentVOs : (NSMutableArray*) commntVOs {
    commentVOs = commntVOs;
}

- (NSMutableArray*) getCommentVOs {
    return commentVOs;
}

- (void) setActivityVOs : (NSMutableArray*) activtyVOs {
    activityVOs = activtyVOs;
}

- (NSMutableArray*) getActivityVOs {
    return activityVOs;
}

- (NSString *) getStatus {
    return status;
}

- (void) setStatus : (NSString *) stat {
    status = stat;
}

- (NSString *) getLatestVersion {
    return latestVersion;
}

- (void) setLatestVersion : (NSString *) latstVersion {
    latestVersion = latstVersion;
}

- (NSString *) getLatestPublishedVersion {
    return latestPublishedVersion;
}

- (void) setLatestPublishedVersion : (NSString *) latstPublishedVersion {
    latestPublishedVersion = latstPublishedVersion;
}

- (int) getCreatedBy {
    return createdBy;
}

- (void) setCreatedBy : (int) creatdBy {
    createdBy = creatdBy;
}

- (NSString *) getAutoDelDate {
    return autoDelDate;
}

- (void) setAutoDelDate : (NSString *) autoDelDte {
    autoDelDate = autoDelDte;
}

- (NSString *) getAutoDelReminderDate {
    return autoDelReminderDate;
}

- (void) setAutoDelReminderDate : (NSString *) autoDelRemindrDate {
    autoDelReminderDate = autoDelRemindrDate;
}

- (NSString *) getAutoDelReminderSentDate {
    return autoDelReminderSentDate;
}

- (void) setAutoDelReminderSentDate : (NSString *) autoDelRemindrSentDate {
    autoDelReminderSentDate = autoDelRemindrSentDate;
}

- (NSString *) getDateCreated {
    return dateCreated;
}

- (void) setDateCreated : (NSString *) dateCreatd {
    dateCreated = dateCreatd;
}

- (int) getLastUpdatedBy {
    return lastUpdatedBy;
}

- (void) setLastUpdatedBy : (int) lastUpdatdBy {
    lastUpdatedBy = lastUpdatdBy;
}

- (NSString *) getDateLastUpdated {
    return dateLastUpdated;
}

- (void) setDateLastUpdated : (NSString *) dateLastUpdatd {
    dateLastUpdated = dateLastUpdatd;
}

- (NSString *) getLastActivityDate {
    return lastActivityDate;
}

- (void) setLastActivityDate : (NSString *) lstActivityDate {
    lastActivityDate = lstActivityDate;
}

- (int) getValidPrimaryOwnerCount {
    return validPrimaryOwnerCount;
}

- (void) setValidPrimaryOwnerCount : (int) validPrimryOwnerCount {
    validPrimaryOwnerCount = validPrimryOwnerCount;
}

- (long) getSize {
    return size;
}

- (void) setSize : (long) siz {
    size = siz;
}

- (int) getRootDirectoryId {
    return rootDirectoryId;
}

- (void) setRootDirectoryId : (int) rootDirectryId {
    rootDirectoryId = rootDirectryId;
}

- (BOOL) isLocked {
    return locked;
}

- (void) setLocked : (BOOL) lockd {
    locked = lockd;
}

- (int) getLockedBy {
    return lockedBy;
}

- (void) setLockedBy : (int) lockdBy {
    lockedBy = lockdBy;
}


- (void) setParsedDateCreated : (NSString*) parsedCreatedDate {
    parsedDateCreated = parsedCreatedDate;
}

- (NSString*) getParsedDateCreated {
    return parsedDateCreated;
}

- (void) setParsedDateLastUpdated : (NSString*) parsedLastUpdatedDate {
    parsedDateLastUpdated = parsedLastUpdatedDate;
}

- (NSString*) getParsedDateLastUpdated {
    return parsedDateLastUpdated;
}

- (void) setManagersAddressList : (NSString*) managrsAddressList {
    managersAddressList = managrsAddressList;
}

- (NSString*) getManagersAddressList {
    return managersAddressList;
}

- (void) setCollaboratorsAddressList : (NSString*) collaboratrsAddressList {
    collaboratorsAddressList = collaboratrsAddressList;
}

- (NSString*) getCollaboratorsAddressList {
    return collaboratorsAddressList;
}

- (void) setViewersAddressList : (NSString*) viewrsAddressList {
    viewersAddressList = viewrsAddressList;
}

- (NSString*) getViewersAddressList {
    return viewersAddressList;
}

- (BOOL) isRequesterManager {
    return requesterManager;
}

- (void) setRequesterManager : (BOOL) requesterManagr {
    requesterManager = requesterManagr;
}

- (BOOL) isRequesterCollaborator {
    return requesterCollaborator;
}

- (void) setRequesterCollaborator : (BOOL) requesterCollaboratr {
    requesterCollaborator = requesterCollaboratr;
}

- (BOOL) isRequesterViewer {
    return requesterViewer;
}

- (void) setRequesterViewer : (BOOL) requesterViewr {
    requesterViewer = requesterViewr;
}

- (int) getTotalComment {
    return totalComment;
}
- (void) setTotalComment : (int) totalCommnt {
    totalComment = totalCommnt;
}

- (int) getTotalActivity {
    return totalActivity;
}

- (void) setTotalActivity : (int) totalActivty {
    totalActivity = totalActivty;
}

- (NSString *) getParsedAutoDelDate {
    return parsedAutoDelDate;
}

- (void) setParsedAutoDelDate : (NSString *) prsAutoDelDate {
    parsedAutoDelDate = prsAutoDelDate;
}

- (NSString *) getParsedAutoDelReminderDate {
    return parsedAutoDelReminderDate;
}

- (void) setParsedAutoDelReminderDate : (NSString *) prsAutoDelReminderDate {
    parsedAutoDelReminderDate = prsAutoDelReminderDate;
}

- (BDSFile *) getDirectoryVO {
    return directoryVO;
}

- (void) setDirectoryVO : (BDSFile *) dirVO {
    directoryVO = dirVO;
}

@end
