//
//  WorkspaceUsers.m
//  BDSiPadApp
//
//  Created by Lion User on 13/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WorkspaceUsers.h"

@implementation WorkspaceUsers

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
    }
    
    return self;
}

- (NSMutableArray*) getManagers {
    return managers;
}

- (void) setManagers : (NSMutableArray*) managrs {
    managers = managrs;
}

- (NSMutableArray*) getCollaborators {
    return collaborators;
}

- (void) setCollaborators : (NSMutableArray*) collaboratrs {
    collaborators = collaboratrs;
}

- (NSMutableArray*) getViewers {
    return viewers;
}

- (void) setViewers : (NSMutableArray*) viewrs {
    viewers = viewrs;
}

@end
