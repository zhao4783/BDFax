///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBSHARINGListFolderMembersContinueArg;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `ListFolderMembersContinueArg` struct.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBSHARINGListFolderMembersContinueArg : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The cursor returned by your last call to `listFolderMembers` or
/// `listFolderMembersContinue`.
@property (nonatomic, readonly, copy) NSString *cursor;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param cursor The cursor returned by your last call to `listFolderMembers`
/// or `listFolderMembersContinue`.
///
/// @return An initialized instance.
///
- (instancetype)initWithCursor:(NSString *)cursor;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `ListFolderMembersContinueArg` struct.
///
@interface DBSHARINGListFolderMembersContinueArgSerializer : NSObject

///
/// Serializes `DBSHARINGListFolderMembersContinueArg` instances.
///
/// @param instance An instance of the `DBSHARINGListFolderMembersContinueArg`
/// API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBSHARINGListFolderMembersContinueArg` API object.
///
+ (nullable NSDictionary *)serialize:(DBSHARINGListFolderMembersContinueArg *)instance;

///
/// Deserializes `DBSHARINGListFolderMembersContinueArg` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBSHARINGListFolderMembersContinueArg` API object.
///
/// @return An instantiation of the `DBSHARINGListFolderMembersContinueArg`
/// object.
///
+ (DBSHARINGListFolderMembersContinueArg *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
