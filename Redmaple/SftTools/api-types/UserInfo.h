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

#import <Foundation/Foundation.h>

/**
 This class keeps the signed in user information.
 @author Mahfuzul Amin
 */
@interface UserInfo : NSObject {
@private
    NSString *userName;
    NSString *password;
    NSString *serverName;
    NSString *domain;
    NSString *sessionId;
    BOOL sender;
    BOOL recipient;
    BOOL collaborator;
    BOOL useSSL;
    BOOL acceptedTOS;
}

-(void) setUserName:(NSString *)name;
-(void) setPassword:(NSString *)pass;
-(void) setServerName:(NSString *)server;
-(void) setDomain:(NSString *)domainName;
-(void) setSessionId:(NSString *)session;
-(void) setSender:(BOOL)s;
-(void) setRecipient:(BOOL)r;
-(void) setCollaborator:(BOOL)c;
-(void) setUseSSL:(BOOL)ssl;
-(void) setAcceptedTOS:(BOOL)tos;

-(NSString *) getUserName;
-(NSString *) getPassword;
-(NSString *) getServerName;
-(NSString *) getDomain;
-(NSString *) getSessionId;
-(BOOL) isSender;
-(BOOL) isRecipient;
-(BOOL) isCollaborator;
-(BOOL) isUseSSL;
-(BOOL) isAcceptedTOS;

@end
