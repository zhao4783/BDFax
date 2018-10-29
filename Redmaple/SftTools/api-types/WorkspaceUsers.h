//
//  WorkspaceUsers.h
//  BDSiPadApp
//
//  Created by Lion User on 13/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkspaceUsers : NSObject {    
    NSMutableArray *managers;    
    NSMutableArray *collaborators;
    NSMutableArray *viewers;
}

- (NSMutableArray*) getManagers;
- (void) setManagers : (NSMutableArray*) managers;

- (NSMutableArray*) getCollaborators;
- (void) setCollaborators : (NSMutableArray*) collaborators;

- (NSMutableArray*) getViewers;
- (void) setViewers : (NSMutableArray*) viewers;

@end
