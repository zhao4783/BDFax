///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBPAPERInviteeInfoWithPermissionLevel;
@class DBPAPERPaperDocPermissionLevel;
@class DBSHARINGInviteeInfo;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `InviteeInfoWithPermissionLevel` struct.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBPAPERInviteeInfoWithPermissionLevel : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Email address invited to the Paper doc.
@property (nonatomic, readonly) DBSHARINGInviteeInfo *invitee;

/// Permission level for the invitee.
@property (nonatomic, readonly) DBPAPERPaperDocPermissionLevel *permissionLevel;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param invitee Email address invited to the Paper doc.
/// @param permissionLevel Permission level for the invitee.
///
/// @return An initialized instance.
///
- (instancetype)initWithInvitee:(DBSHARINGInviteeInfo *)invitee
                permissionLevel:(DBPAPERPaperDocPermissionLevel *)permissionLevel;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `InviteeInfoWithPermissionLevel` struct.
///
@interface DBPAPERInviteeInfoWithPermissionLevelSerializer : NSObject

///
/// Serializes `DBPAPERInviteeInfoWithPermissionLevel` instances.
///
/// @param instance An instance of the `DBPAPERInviteeInfoWithPermissionLevel`
/// API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBPAPERInviteeInfoWithPermissionLevel` API object.
///
+ (nullable NSDictionary *)serialize:(DBPAPERInviteeInfoWithPermissionLevel *)instance;

///
/// Deserializes `DBPAPERInviteeInfoWithPermissionLevel` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBPAPERInviteeInfoWithPermissionLevel` API object.
///
/// @return An instantiation of the `DBPAPERInviteeInfoWithPermissionLevel`
/// object.
///
+ (DBPAPERInviteeInfoWithPermissionLevel *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END