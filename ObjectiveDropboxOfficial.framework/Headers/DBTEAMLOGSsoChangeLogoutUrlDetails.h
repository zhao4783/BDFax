///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGSsoChangeLogoutUrlDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `SsoChangeLogoutUrlDetails` struct.
///
/// Changed sign-out URL for SSO.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGSsoChangeLogoutUrlDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Previous single sign-on logout URL. Might be missing due to historical data
/// gap.
@property (nonatomic, readonly, copy, nullable) NSString *previousValue;

/// New single sign-on logout URL. Might be missing due to historical data gap.
@property (nonatomic, readonly, copy, nullable) NSString *dNewValue;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param previousValue Previous single sign-on logout URL. Might be missing
/// due to historical data gap.
/// @param dNewValue New single sign-on logout URL. Might be missing due to
/// historical data gap.
///
/// @return An initialized instance.
///
- (instancetype)initWithPreviousValue:(nullable NSString *)previousValue dNewValue:(nullable NSString *)dNewValue;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
///
/// @return An initialized instance.
///
- (instancetype)initDefault;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `SsoChangeLogoutUrlDetails` struct.
///
@interface DBTEAMLOGSsoChangeLogoutUrlDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGSsoChangeLogoutUrlDetails` instances.
///
/// @param instance An instance of the `DBTEAMLOGSsoChangeLogoutUrlDetails` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGSsoChangeLogoutUrlDetails` API object.
///
+ (nullable NSDictionary *)serialize:(DBTEAMLOGSsoChangeLogoutUrlDetails *)instance;

///
/// Deserializes `DBTEAMLOGSsoChangeLogoutUrlDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGSsoChangeLogoutUrlDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGSsoChangeLogoutUrlDetails` object.
///
+ (DBTEAMLOGSsoChangeLogoutUrlDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
