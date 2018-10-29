///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILESLookupError;
@class DBFILESSearchError;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `SearchError` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILESSearchError : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBFILESSearchErrorTag` enum type represents the possible tag states
/// with which the `DBFILESSearchError` union can exist.
typedef NS_ENUM(NSInteger, DBFILESSearchErrorTag) {
  /// (no description).
  DBFILESSearchErrorPath,

  /// (no description).
  DBFILESSearchErrorOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBFILESSearchErrorTag tag;

/// (no description). @note Ensure the `isPath` method returns true before
/// accessing, otherwise a runtime exception will be raised.
@property (nonatomic, readonly) DBFILESLookupError *path;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "path".
///
/// @param path (no description).
///
/// @return An initialized instance.
///
- (instancetype)initWithPath:(DBFILESLookupError *)path;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (instancetype)initWithOther;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "path".
///
/// @note Call this method and ensure it returns true before accessing the
/// `path` property, otherwise a runtime exception will be thrown.
///
/// @return Whether the union's current tag state has value "path".
///
- (BOOL)isPath;

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
/// The serialization class for the `DBFILESSearchError` union.
///
@interface DBFILESSearchErrorSerializer : NSObject

///
/// Serializes `DBFILESSearchError` instances.
///
/// @param instance An instance of the `DBFILESSearchError` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILESSearchError` API object.
///
+ (nullable NSDictionary *)serialize:(DBFILESSearchError *)instance;

///
/// Deserializes `DBFILESSearchError` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILESSearchError` API object.
///
/// @return An instantiation of the `DBFILESSearchError` object.
///
+ (DBFILESSearchError *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
