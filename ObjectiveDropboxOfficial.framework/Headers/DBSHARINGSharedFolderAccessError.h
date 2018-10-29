///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBSHARINGSharedFolderAccessError;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `SharedFolderAccessError` union.
///
/// There is an error accessing the shared folder.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBSHARINGSharedFolderAccessError : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBSHARINGSharedFolderAccessErrorTag` enum type represents the possible
/// tag states with which the `DBSHARINGSharedFolderAccessError` union can
/// exist.
typedef NS_ENUM(NSInteger, DBSHARINGSharedFolderAccessErrorTag) {
  /// This shared folder ID is invalid.
  DBSHARINGSharedFolderAccessErrorInvalidId,

  /// The user is not a member of the shared folder thus cannot access it.
  DBSHARINGSharedFolderAccessErrorNotAMember,

  /// Never set.
  DBSHARINGSharedFolderAccessErrorEmailUnverified,

  /// The shared folder is unmounted.
  DBSHARINGSharedFolderAccessErrorUnmounted,

  /// (no description).
  DBSHARINGSharedFolderAccessErrorOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBSHARINGSharedFolderAccessErrorTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "invalid_id".
///
/// Description of the "invalid_id" tag state: This shared folder ID is invalid.
///
/// @return An initialized instance.
///
- (instancetype)initWithInvalidId;

///
/// Initializes union class with tag state of "not_a_member".
///
/// Description of the "not_a_member" tag state: The user is not a member of the
/// shared folder thus cannot access it.
///
/// @return An initialized instance.
///
- (instancetype)initWithNotAMember;

///
/// Initializes union class with tag state of "email_unverified".
///
/// Description of the "email_unverified" tag state: Never set.
///
/// @return An initialized instance.
///
- (instancetype)initWithEmailUnverified;

///
/// Initializes union class with tag state of "unmounted".
///
/// Description of the "unmounted" tag state: The shared folder is unmounted.
///
/// @return An initialized instance.
///
- (instancetype)initWithUnmounted;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (instancetype)initWithOther;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "invalid_id".
///
/// @return Whether the union's current tag state has value "invalid_id".
///
- (BOOL)isInvalidId;

///
/// Retrieves whether the union's current tag state has value "not_a_member".
///
/// @return Whether the union's current tag state has value "not_a_member".
///
- (BOOL)isNotAMember;

///
/// Retrieves whether the union's current tag state has value
/// "email_unverified".
///
/// @return Whether the union's current tag state has value "email_unverified".
///
- (BOOL)isEmailUnverified;

///
/// Retrieves whether the union's current tag state has value "unmounted".
///
/// @return Whether the union's current tag state has value "unmounted".
///
- (BOOL)isUnmounted;

///
/// Retrieves whether the union's current tag state has value "other".
///
/// @return Whether the union's current tag state has value "other".
///
- (BOOL)isOther;

///
/// Retrieves string value of union's current tag state.
///
/// @return A human-readable string representing the union's current tag state.
///
- (NSString *)tagName;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `DBSHARINGSharedFolderAccessError` union.
///
@interface DBSHARINGSharedFolderAccessErrorSerializer : NSObject

///
/// Serializes `DBSHARINGSharedFolderAccessError` instances.
///
/// @param instance An instance of the `DBSHARINGSharedFolderAccessError` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBSHARINGSharedFolderAccessError` API object.
///
+ (nullable NSDictionary *)serialize:(DBSHARINGSharedFolderAccessError *)instance;

///
/// Deserializes `DBSHARINGSharedFolderAccessError` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBSHARINGSharedFolderAccessError` API object.
///
/// @return An instantiation of the `DBSHARINGSharedFolderAccessError` object.
///
+ (DBSHARINGSharedFolderAccessError *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
