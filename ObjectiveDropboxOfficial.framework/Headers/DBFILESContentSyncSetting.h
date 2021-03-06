///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILESContentSyncSetting;
@class DBFILESSyncSetting;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `ContentSyncSetting` struct.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILESContentSyncSetting : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Id of the item this setting is applied to.
@property (nonatomic, readonly, copy) NSString *id_;

/// Setting for this item.
@property (nonatomic, readonly) DBFILESSyncSetting *syncSetting;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param id_ Id of the item this setting is applied to.
/// @param syncSetting Setting for this item.
///
/// @return An initialized instance.
///
- (instancetype)initWithId_:(NSString *)id_ syncSetting:(DBFILESSyncSetting *)syncSetting;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `ContentSyncSetting` struct.
///
@interface DBFILESContentSyncSettingSerializer : NSObject

///
/// Serializes `DBFILESContentSyncSetting` instances.
///
/// @param instance An instance of the `DBFILESContentSyncSetting` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILESContentSyncSetting` API object.
///
+ (nullable NSDictionary *)serialize:(DBFILESContentSyncSetting *)instance;

///
/// Deserializes `DBFILESContentSyncSetting` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILESContentSyncSetting` API object.
///
/// @return An instantiation of the `DBFILESContentSyncSetting` object.
///
+ (DBFILESContentSyncSetting *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
