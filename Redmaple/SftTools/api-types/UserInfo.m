/*
 * Copyright (c) 2012 Biscom, Inc.
 * Chelmsford, MA, 01824 U.S.A.
 * All rights reserved.
 *
 * This source code is considered Confidential Information and
 * property of Biscom, Inc. This source code may not be copied,
 * shared, distributed, or used in any other software application
 * or derivative work without the express written permission
 * from Biscom, Inc.
 * This header must be included in all source code that contains
 * any or all of the code or documentation included in this file.
 * You agree not to remove this proprietary rights legend from
 * this or any derivative source code file. Any derivative source
 * code file that contains any or all of the source code contained
 * in this file, whether or not this legend appears in such
 * derivative source code file, shall remain the exclusive property
 * of Biscom, Inc. and shall be treated as Confidential Information.
 */

#import "UserInfo.h"

@implementation UserInfo

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void) setUserName:(NSString *)name {
    userName = name;
}

-(void) setPassword:(NSString *)pass {
    password = pass;
}

-(void) setServerName:(NSString *)server {
    serverName = server;
}

-(void) setDomain:(NSString *)domainName {
    domain = domainName;
}

-(void) setSessionId:(NSString *)session {
    sessionId = session;
}

-(void) setSender:(BOOL)s {
    sender = s;
}

-(void) setRecipient:(BOOL)r {
    recipient = r;
}

-(void) setCollaborator:(BOOL)c {
    collaborator = c;
}

-(void) setUseSSL:(BOOL)ssl {
    useSSL = ssl;
}

-(void) setAcceptedTOS:(BOOL)tos {
    acceptedTOS = tos;
}


-(NSString *) getUserName {
    return userName;
}
-(NSString *) getPassword {
    return password;
}

-(NSString *) getServerName {
    return serverName;
}

-(NSString *) getDomain {
    return domain;
}

-(NSString *) getSessionId {
    return sessionId;
}

-(BOOL) isSender {
    return sender;
}

-(BOOL) isRecipient {
    return recipient;
}

-(BOOL) isCollaborator {
    return collaborator;
}

-(BOOL) isUseSSL {
    return useSSL;
}

-(BOOL) isAcceptedTOS {
    return acceptedTOS;
}

/*- (void)dealloc
{
    [userName release];
    [password release];
    [serverName release];
    [domain release];
    [sessionId release];
    //[useSSL release];

    [super dealloc];
}*/

@end
