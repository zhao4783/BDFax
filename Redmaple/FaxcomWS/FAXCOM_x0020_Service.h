#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class FAXCOM_x0020_Service_ShowThreadingModel;
@class FAXCOM_x0020_Service_ShowThreadingModelResponse;
@class FAXCOM_x0020_Service_WebServiceVersion;
@class FAXCOM_x0020_Service_WebServiceVersionResponse;
@class FAXCOM_x0020_Service_SetLegacyMode;
@class FAXCOM_x0020_Service_SetLegacyModeResponse;
@class FAXCOM_x0020_Service_ResultMessage;
@class FAXCOM_x0020_Service_GetLegacyMode;
@class FAXCOM_x0020_Service_GetLegacyModeResponse;
@class FAXCOM_x0020_Service_LogOn;
@class FAXCOM_x0020_Service_LogOnResponse;
@class FAXCOM_x0020_Service_ReleaseSession;
@class FAXCOM_x0020_Service_ReleaseSessionResponse;
@class FAXCOM_x0020_Service_SetSenderInformation;
@class FAXCOM_x0020_Service_SetSenderInformationResponse;
@class FAXCOM_x0020_Service_NewFaxMessage;
@class FAXCOM_x0020_Service_NewFaxMessageResponse;
@class FAXCOM_x0020_Service_AddRecipient;
@class FAXCOM_x0020_Service_AddRecipientResponse;
@class FAXCOM_x0020_Service_AddRecipientEx;
@class FAXCOM_x0020_Service_AddRecipientExResponse;
@class FAXCOM_x0020_Service_SendFax;
@class FAXCOM_x0020_Service_SendFaxResponse;
@class FAXCOM_x0020_Service_GetLastUniqueJobID;
@class FAXCOM_x0020_Service_GetLastUniqueJobIDResponse;
@class FAXCOM_x0020_Service_SaveFax;
@class FAXCOM_x0020_Service_SaveFaxResponse;
@class FAXCOM_x0020_Service_AddAttachment;
@class FAXCOM_x0020_Service_AddAttachmentResponse;
@class FAXCOM_x0020_Service_AddAttachmentByUNC;
@class FAXCOM_x0020_Service_AddAttachmentByUNCResponse;
@class FAXCOM_x0020_Service_GetMessageStatusByUniqueID;
@class FAXCOM_x0020_Service_GetMessageStatusByUniqueIDResponse;
@class FAXCOM_x0020_Service_MessageStatus;
@class FAXCOM_x0020_Service_GetMessageStatusByIDTag;
@class FAXCOM_x0020_Service_GetMessageStatusByIDTagResponse;
@class FAXCOM_x0020_Service_GetMessageStatusesCount;
@class FAXCOM_x0020_Service_GetMessageStatusesCountResponse;
@class FAXCOM_x0020_Service_GetMessageStatuses;
@class FAXCOM_x0020_Service_GetMessageStatusesResponse;
@class FAXCOM_x0020_Service_ArrayOfMessageStatus;
@class FAXCOM_x0020_Service_GetMessageStatusesEx;
@class FAXCOM_x0020_Service_GetMessageStatusesExResponse;
@class FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID;
@class FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueIDResponse;
@class FAXCOM_x0020_Service_GetPendingMessageByUniqueID;
@class FAXCOM_x0020_Service_GetPendingMessageByUniqueIDResponse;
@class FAXCOM_x0020_Service_PendingMessage;
@class FAXCOM_x0020_Service_GetPendingMessageByIDTag;
@class FAXCOM_x0020_Service_GetPendingMessageByIDTagResponse;
@class FAXCOM_x0020_Service_GetPendingMessagesCount;
@class FAXCOM_x0020_Service_GetPendingMessagesCountResponse;
@class FAXCOM_x0020_Service_GetPendingMessages;
@class FAXCOM_x0020_Service_GetPendingMessagesResponse;
@class FAXCOM_x0020_Service_ArrayOfPendingMessage;
@class FAXCOM_x0020_Service_GetPendingMessagesEx;
@class FAXCOM_x0020_Service_GetPendingMessagesExResponse;
@class FAXCOM_x0020_Service_GetReceivedMessagesCount;
@class FAXCOM_x0020_Service_GetReceivedMessagesCountResponse;
@class FAXCOM_x0020_Service_GetReceivedMessages;
@class FAXCOM_x0020_Service_GetReceivedMessagesResponse;
@class FAXCOM_x0020_Service_ArrayOfReceivedMessageData;
@class FAXCOM_x0020_Service_ReceivedMessageData;
@class FAXCOM_x0020_Service_ReceivedMessageMetadata;
@class FAXCOM_x0020_Service_GetReceivedMessages2;
@class FAXCOM_x0020_Service_GetReceivedMessages2Response;
@class FAXCOM_x0020_Service_GetReceivedMessages3;
@class FAXCOM_x0020_Service_GetReceivedMessages3Response;
@class FAXCOM_x0020_Service_ArrayOfReceivedMessageData2;
@class FAXCOM_x0020_Service_ReceivedMessageData2;
@class FAXCOM_x0020_Service_ReceivedMessageMetadata2;
@class FAXCOM_x0020_Service_GetReceivedMessagesByIDs;
@class FAXCOM_x0020_Service_ArrayOfString;
@class FAXCOM_x0020_Service_GetReceivedMessagesByIDsResponse;
@class FAXCOM_x0020_Service_GetReceivedMessagesByIDs2;
@class FAXCOM_x0020_Service_GetReceivedMessagesByIDs2Response;
@class FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs;
@class FAXCOM_x0020_Service_RemoveReceivedMessagesByIDsResponse;
@class FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDs;
@class FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDsResponse;
@class FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueries;
@class FAXCOM_x0020_Service_ArrayOfMessageStatusQuery;
@class FAXCOM_x0020_Service_MessageStatusQuery;
@class FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueriesResponse;
@class FAXCOM_x0020_Service_ArrayOfMessageStatusQueryResult;
@class FAXCOM_x0020_Service_MessageStatusQueryResult;
@class FAXCOM_x0020_Service_NewFaxMessage2;
@class FAXCOM_x0020_Service_NewFaxMessage2Response;
@class FAXCOM_x0020_Service_ListPhonebooks;
@class FAXCOM_x0020_Service_ListPhonebooksResponse;
@class FAXCOM_x0020_Service_ArrayOfPhonebookInfo;
@class FAXCOM_x0020_Service_PhonebookInfo;
@class FAXCOM_x0020_Service_UpdatePhonebook;
@class FAXCOM_x0020_Service_UpdatePhonebookResponse;
@class FAXCOM_x0020_Service_SubmitForPreview;
@class FAXCOM_x0020_Service_SubmitForPreviewResponse;
@class FAXCOM_x0020_Service_GetPendingImage;
@class FAXCOM_x0020_Service_GetPendingImageResponse;
@class FAXCOM_x0020_Service_Attachment;
@class FAXCOM_x0020_Service_ReleasePendingMessage;
@class FAXCOM_x0020_Service_ReleasePendingMessageResponse;
@class FAXCOM_x0020_Service_CancelPendingMessage;
@class FAXCOM_x0020_Service_CancelPendingMessageResponse;
@class FAXCOM_x0020_Service_LoginAndSendNewFaxMessage;
@class FAXCOM_x0020_Service_SenderInfo;
@class FAXCOM_x0020_Service_ArrayOfRecipientInfo;
@class FAXCOM_x0020_Service_ArrayOfAttachment;
@class FAXCOM_x0020_Service_RecipientInfo;
@class FAXCOM_x0020_Service_LoginAndSendNewFaxMessageResponse;
@class FAXCOM_x0020_Service_SendNewFaxMessage;
@class FAXCOM_x0020_Service_SendNewFaxMessageResponse;
@class FAXCOM_x0020_Service_GetPhonebookAddresses;
@class FAXCOM_x0020_Service_GetPhonebookAddressesResponse;
@class FAXCOM_x0020_Service_ArrayOfAddressInfo;
@class FAXCOM_x0020_Service_AddressInfo;
@class FAXCOM_x0020_Service_NewPhonebook;
@class FAXCOM_x0020_Service_NewPhonebookResponse;
@class FAXCOM_x0020_Service_NewAddress;
@class FAXCOM_x0020_Service_NewAddressResponse;
@class FAXCOM_x0020_Service_AddAddressToGroup;
@class FAXCOM_x0020_Service_AddAddressToGroupResponse;
@class FAXCOM_x0020_Service_ModifyAddress;
@class FAXCOM_x0020_Service_ModifyAddressResponse;
@class FAXCOM_x0020_Service_ModifyAddressInGroup;
@class FAXCOM_x0020_Service_ModifyAddressInGroupResponse;
@class FAXCOM_x0020_Service_DeleteAddress;
@class FAXCOM_x0020_Service_DeleteAddressResponse;
@class FAXCOM_x0020_Service_DeleteAddressInGroup;
@class FAXCOM_x0020_Service_DeleteAddressInGroupResponse;
@class FAXCOM_x0020_Service_NewGroup;
@class FAXCOM_x0020_Service_NewGroupResponse;
@class FAXCOM_x0020_Service_ModifyGroup;
@class FAXCOM_x0020_Service_ModifyGroupResponse;
@class FAXCOM_x0020_Service_ListPhonebookGroups;
@class FAXCOM_x0020_Service_ListPhonebookGroupsResponse;
@class FAXCOM_x0020_Service_GetGroupAddresses;
@class FAXCOM_x0020_Service_GetGroupAddressesResponse;
@class FAXCOM_x0020_Service_DeletePhonebook;
@class FAXCOM_x0020_Service_DeletePhonebookResponse;
@class FAXCOM_x0020_Service_DeleteGroup;
@class FAXCOM_x0020_Service_DeleteGroupResponse;
@class FAXCOM_x0020_Service_GetCoverpageList;
@class FAXCOM_x0020_Service_GetCoverpageListResponse;
@class FAXCOM_x0020_Service_GetSentImage;
@class FAXCOM_x0020_Service_GetSentImageResponse;
@class FAXCOM_x0020_Service_NewFaxMessageFromUniqueID;
@class FAXCOM_x0020_Service_NewFaxMessageFromUniqueIDResponse;
@class FAXCOM_x0020_Service_GetFaxMessageProperties;
@class FAXCOM_x0020_Service_GetFaxMessagePropertiesResponse;
@class FAXCOM_x0020_Service_FaxMessageProperties;
@class FAXCOM_x0020_Service_SetFaxMessageProperties;
@class FAXCOM_x0020_Service_SetFaxMessagePropertiesResponse;
@class FAXCOM_x0020_Service_GetAttachments;
@class FAXCOM_x0020_Service_GetAttachmentsResponse;
@class FAXCOM_x0020_Service_GetAttachment;
@class FAXCOM_x0020_Service_GetAttachmentResponse;
@class FAXCOM_x0020_Service_RemoveAttachment;
@class FAXCOM_x0020_Service_RemoveAttachmentResponse;
@class FAXCOM_x0020_Service_ResendFailedFax;
@class FAXCOM_x0020_Service_ResendFailedFaxResponse;
@class FAXCOM_x0020_Service_ListSupportedFeatures;
@class FAXCOM_x0020_Service_ListSupportedFeaturesResponse;
@class FAXCOM_x0020_Service_MarkAsReadByIDs;
@class FAXCOM_x0020_Service_MarkAsReadByIDsResponse;
@interface FAXCOM_x0020_Service_ShowThreadingModel : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ShowThreadingModel *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ShowThreadingModelResponse : NSObject {
	
/* elements */
	NSString * ShowThreadingModelResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ShowThreadingModelResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * ShowThreadingModelResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_WebServiceVersion : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_WebServiceVersion *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_WebServiceVersionResponse : NSObject {
	
/* elements */
	NSString * WebServiceVersionResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_WebServiceVersionResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * WebServiceVersionResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SetLegacyMode : NSObject {
	
/* elements */
	NSNumber * legacyMode;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SetLegacyMode *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * legacyMode;
/* attributes */
- (NSDictionary *)attributes;
@end
typedef enum {
	FAXCOM_x0020_Service_LOGENTRYTYPE_none = 0,
	FAXCOM_x0020_Service_LOGENTRYTYPE_INFO,
	FAXCOM_x0020_Service_LOGENTRYTYPE_WARNING,
	FAXCOM_x0020_Service_LOGENTRYTYPE_ERROR,
} FAXCOM_x0020_Service_LOGENTRYTYPE;
FAXCOM_x0020_Service_LOGENTRYTYPE FAXCOM_x0020_Service_LOGENTRYTYPE_enumFromString(NSString *string);
NSString * FAXCOM_x0020_Service_LOGENTRYTYPE_stringFromEnum(FAXCOM_x0020_Service_LOGENTRYTYPE enumValue);
@interface FAXCOM_x0020_Service_ResultMessage : NSObject {
	
/* elements */
	USBoolean * Result;
	NSString * Detail;
	FAXCOM_x0020_Service_LOGENTRYTYPE Type;
	NSString * Data;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ResultMessage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * Result;
@property (retain) NSString * Detail;
@property (assign) FAXCOM_x0020_Service_LOGENTRYTYPE Type;
@property (retain) NSString * Data;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SetLegacyModeResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * SetLegacyModeResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SetLegacyModeResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * SetLegacyModeResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetLegacyMode : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetLegacyMode *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetLegacyModeResponse : NSObject {
	
/* elements */
	NSNumber * GetLegacyModeResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetLegacyModeResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * GetLegacyModeResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_LogOn : NSObject {
	
/* elements */
	NSString * faxQueue;
	NSString * userName;
	NSString * password;
	NSNumber * userType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_LogOn *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * faxQueue;
@property (retain) NSString * userName;
@property (retain) NSString * password;
@property (retain) NSNumber * userType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_LogOnResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * LogOnResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_LogOnResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * LogOnResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ReleaseSession : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ReleaseSession *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ReleaseSessionResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * ReleaseSessionResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ReleaseSessionResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * ReleaseSessionResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SetSenderInformation : NSObject {
	
/* elements */
	NSString * name;
	NSString * faxNumber;
	NSString * voiceNumber;
	NSString * email;
	NSString * company;
	NSString * address1;
	NSString * address2;
	NSString * address3;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SetSenderInformation *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * name;
@property (retain) NSString * faxNumber;
@property (retain) NSString * voiceNumber;
@property (retain) NSString * email;
@property (retain) NSString * company;
@property (retain) NSString * address1;
@property (retain) NSString * address2;
@property (retain) NSString * address3;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SetSenderInformationResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * SetSenderInformationResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SetSenderInformationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * SetSenderInformationResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_NewFaxMessage : NSObject {
	
/* elements */
	NSNumber * priority;
	NSString * sendTime;
	NSNumber * resolution;
	NSString * subject;
	NSString * coverpage;
	NSString * memo;
	NSString * senderName;
	NSString * senderFax;
	NSString * recipientName;
	NSString * recipientCompany;
	NSString * recipientFax;
	NSString * recipientVoice;
	NSString * recipientAccount;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_NewFaxMessage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * priority;
@property (retain) NSString * sendTime;
@property (retain) NSNumber * resolution;
@property (retain) NSString * subject;
@property (retain) NSString * coverpage;
@property (retain) NSString * memo;
@property (retain) NSString * senderName;
@property (retain) NSString * senderFax;
@property (retain) NSString * recipientName;
@property (retain) NSString * recipientCompany;
@property (retain) NSString * recipientFax;
@property (retain) NSString * recipientVoice;
@property (retain) NSString * recipientAccount;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_NewFaxMessageResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * NewFaxMessageResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_NewFaxMessageResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * NewFaxMessageResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_AddRecipient : NSObject {
	
/* elements */
	NSString * name;
	NSString * company;
	NSString * faxNumber;
	NSString * voiceNumber;
	NSString * address1;
	NSString * address2;
	NSString * address3;
	NSString * account;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_AddRecipient *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * name;
@property (retain) NSString * company;
@property (retain) NSString * faxNumber;
@property (retain) NSString * voiceNumber;
@property (retain) NSString * address1;
@property (retain) NSString * address2;
@property (retain) NSString * address3;
@property (retain) NSString * account;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_AddRecipientResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * AddRecipientResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_AddRecipientResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * AddRecipientResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_AddRecipientEx : NSObject {
	
/* elements */
	NSString * name;
	NSString * company;
	NSString * faxNumber;
	NSString * voiceNumber;
	NSString * address1;
	NSString * address2;
	NSString * address3;
	NSString * account;
	NSString * coverpage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_AddRecipientEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * name;
@property (retain) NSString * company;
@property (retain) NSString * faxNumber;
@property (retain) NSString * voiceNumber;
@property (retain) NSString * address1;
@property (retain) NSString * address2;
@property (retain) NSString * address3;
@property (retain) NSString * account;
@property (retain) NSString * coverpage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_AddRecipientExResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * AddRecipientExResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_AddRecipientExResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * AddRecipientExResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SendFax : NSObject {
	
/* elements */
	NSString * IDTag;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SendFax *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * IDTag;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SendFaxResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * SendFaxResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SendFaxResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * SendFaxResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetLastUniqueJobID : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetLastUniqueJobID *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetLastUniqueJobIDResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * GetLastUniqueJobIDResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetLastUniqueJobIDResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * GetLastUniqueJobIDResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SaveFax : NSObject {
	
/* elements */
	NSString * ID_;
	NSString * folder;
	NSString * note;
	USBoolean * sendFax;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SaveFax *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * ID_;
@property (retain) NSString * folder;
@property (retain) NSString * note;
@property (retain) USBoolean * sendFax;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SaveFaxResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * SaveFaxResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SaveFaxResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * SaveFaxResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_AddAttachment : NSObject {
	
/* elements */
	NSString * attname;
	NSData * attachment;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_AddAttachment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * attname;
@property (retain) NSData * attachment;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_AddAttachmentResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * AddAttachmentResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_AddAttachmentResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * AddAttachmentResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_AddAttachmentByUNC : NSObject {
	
/* elements */
	NSString * attname;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_AddAttachmentByUNC *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * attname;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_AddAttachmentByUNCResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * AddAttachmentByUNCResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_AddAttachmentByUNCResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * AddAttachmentByUNCResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetMessageStatusByUniqueID : NSObject {
	
/* elements */
	NSString * uniqueID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetMessageStatusByUniqueID *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * uniqueID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_MessageStatus : NSObject {
	
/* elements */
	NSNumber * ID_;
	NSDate * TransmitTime;
	NSString * FaxNumber;
	NSNumber * NumberOfAttempts;
	NSString * RecipientName;
	NSString * Subject;
	NSNumber * PagesTransmitted;
	NSNumber * TransferRate;
	USBoolean * FallBack;
	NSNumber * TransmissionStatus;
	NSString * StatusText;
	NSString * StatusName;
	NSNumber * ConnectTime;
	NSString * CSI;
	NSNumber * PortNumber;
	NSNumber * TotalPages;
	NSNumber * AttachmentCount;
	NSString * EnvelopeName;
	NSString * RenderedImagePath;
	NSNumber * Index;
	NSString * IDTag;
	NSNumber * AssignedID;
	NSString * UniqueJobID;
	USBoolean * IsSelected;
	NSNumber * FaxStateFlags;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_MessageStatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * ID_;
@property (retain) NSDate * TransmitTime;
@property (retain) NSString * FaxNumber;
@property (retain) NSNumber * NumberOfAttempts;
@property (retain) NSString * RecipientName;
@property (retain) NSString * Subject;
@property (retain) NSNumber * PagesTransmitted;
@property (retain) NSNumber * TransferRate;
@property (retain) USBoolean * FallBack;
@property (retain) NSNumber * TransmissionStatus;
@property (retain) NSString * StatusText;
@property (retain) NSString * StatusName;
@property (retain) NSNumber * ConnectTime;
@property (retain) NSString * CSI;
@property (retain) NSNumber * PortNumber;
@property (retain) NSNumber * TotalPages;
@property (retain) NSNumber * AttachmentCount;
@property (retain) NSString * EnvelopeName;
@property (retain) NSString * RenderedImagePath;
@property (retain) NSNumber * Index;
@property (retain) NSString * IDTag;
@property (retain) NSNumber * AssignedID;
@property (retain) NSString * UniqueJobID;
@property (retain) USBoolean * IsSelected;
@property (retain) NSNumber * FaxStateFlags;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetMessageStatusByUniqueIDResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_MessageStatus * GetMessageStatusByUniqueIDResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetMessageStatusByUniqueIDResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_MessageStatus * GetMessageStatusByUniqueIDResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetMessageStatusByIDTag : NSObject {
	
/* elements */
	NSString * IDTag;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetMessageStatusByIDTag *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * IDTag;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetMessageStatusByIDTagResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_MessageStatus * GetMessageStatusByIDTagResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetMessageStatusByIDTagResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_MessageStatus * GetMessageStatusByIDTagResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetMessageStatusesCount : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetMessageStatusesCount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetMessageStatusesCountResponse : NSObject {
	
/* elements */
	NSNumber * GetMessageStatusesCountResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetMessageStatusesCountResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * GetMessageStatusesCountResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetMessageStatuses : NSObject {
	
/* elements */
	NSNumber * sortColumn;
	USBoolean * ascending;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetMessageStatuses *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * sortColumn;
@property (retain) USBoolean * ascending;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ArrayOfMessageStatus : NSObject {
	
/* elements */
	NSMutableArray *MessageStatus;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ArrayOfMessageStatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addMessageStatus:(FAXCOM_x0020_Service_MessageStatus *)toAdd;
@property (readonly) NSMutableArray * MessageStatus;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetMessageStatusesResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfMessageStatus * GetMessageStatusesResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetMessageStatusesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfMessageStatus * GetMessageStatusesResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetMessageStatusesEx : NSObject {
	
/* elements */
	NSNumber * sortColumn;
	USBoolean * ascending;
	NSNumber * start;
	NSNumber * count;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetMessageStatusesEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * sortColumn;
@property (retain) USBoolean * ascending;
@property (retain) NSNumber * start;
@property (retain) NSNumber * count;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetMessageStatusesExResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfMessageStatus * GetMessageStatusesExResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetMessageStatusesExResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfMessageStatus * GetMessageStatusesExResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID : NSObject {
	
/* elements */
	NSString * uniqueID;
	NSNumber * recipientIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * uniqueID;
@property (retain) NSNumber * recipientIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueIDResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * RemoveMessageStatusbyUniqueIDResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueIDResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * RemoveMessageStatusbyUniqueIDResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetPendingMessageByUniqueID : NSObject {
	
/* elements */
	NSString * id_;
	NSNumber * recipientIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetPendingMessageByUniqueID *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * id_;
@property (retain) NSNumber * recipientIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
typedef enum {
	FAXCOM_x0020_Service_PRIORITY_none = 0,
	FAXCOM_x0020_Service_PRIORITY_LOW,
	FAXCOM_x0020_Service_PRIORITY_NORMAL,
	FAXCOM_x0020_Service_PRIORITY_HIGH,
	FAXCOM_x0020_Service_PRIORITY_URGENT,
} FAXCOM_x0020_Service_PRIORITY;
FAXCOM_x0020_Service_PRIORITY FAXCOM_x0020_Service_PRIORITY_enumFromString(NSString *string);
NSString * FAXCOM_x0020_Service_PRIORITY_stringFromEnum(FAXCOM_x0020_Service_PRIORITY enumValue);
@interface FAXCOM_x0020_Service_PendingMessage : NSObject {
	
/* elements */
	NSNumber * ID_;
	NSNumber * AssignedID;
	NSDate * DeliveryTime;
	NSNumber * Status;
	NSNumber * HoldValue;
	FAXCOM_x0020_Service_PRIORITY Priority;
	NSNumber * Attempts;
	NSString * FaxNumber;
	NSString * SenderName;
	USBoolean * IsSelected;
	USBoolean * PreviewAllowed;
	USBoolean * AuthorizeAllowed;
	NSString * PreviewPath;
	USBoolean * IsSender;
	USBoolean * IsAuthorizor;
	NSString * IDTag;
	NSString * UniqueID;
	NSNumber * RecipientIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_PendingMessage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * ID_;
@property (retain) NSNumber * AssignedID;
@property (retain) NSDate * DeliveryTime;
@property (retain) NSNumber * Status;
@property (retain) NSNumber * HoldValue;
@property (assign) FAXCOM_x0020_Service_PRIORITY Priority;
@property (retain) NSNumber * Attempts;
@property (retain) NSString * FaxNumber;
@property (retain) NSString * SenderName;
@property (retain) USBoolean * IsSelected;
@property (retain) USBoolean * PreviewAllowed;
@property (retain) USBoolean * AuthorizeAllowed;
@property (retain) NSString * PreviewPath;
@property (retain) USBoolean * IsSender;
@property (retain) USBoolean * IsAuthorizor;
@property (retain) NSString * IDTag;
@property (retain) NSString * UniqueID;
@property (retain) NSNumber * RecipientIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetPendingMessageByUniqueIDResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PendingMessage * GetPendingMessageByUniqueIDResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetPendingMessageByUniqueIDResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_PendingMessage * GetPendingMessageByUniqueIDResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetPendingMessageByIDTag : NSObject {
	
/* elements */
	NSString * IDTag;
	NSNumber * recipientIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetPendingMessageByIDTag *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * IDTag;
@property (retain) NSNumber * recipientIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetPendingMessageByIDTagResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PendingMessage * GetPendingMessageByIDTagResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetPendingMessageByIDTagResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_PendingMessage * GetPendingMessageByIDTagResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetPendingMessagesCount : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetPendingMessagesCount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetPendingMessagesCountResponse : NSObject {
	
/* elements */
	NSNumber * GetPendingMessagesCountResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetPendingMessagesCountResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * GetPendingMessagesCountResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetPendingMessages : NSObject {
	
/* elements */
	NSNumber * sortColumn;
	USBoolean * ascending;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetPendingMessages *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * sortColumn;
@property (retain) USBoolean * ascending;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ArrayOfPendingMessage : NSObject {
	
/* elements */
	NSMutableArray *PendingMessage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ArrayOfPendingMessage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addPendingMessage:(FAXCOM_x0020_Service_PendingMessage *)toAdd;
@property (readonly) NSMutableArray * PendingMessage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetPendingMessagesResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfPendingMessage * GetPendingMessagesResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetPendingMessagesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfPendingMessage * GetPendingMessagesResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetPendingMessagesEx : NSObject {
	
/* elements */
	NSNumber * sortColumn;
	USBoolean * ascending;
	NSNumber * start;
	NSNumber * count;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetPendingMessagesEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * sortColumn;
@property (retain) USBoolean * ascending;
@property (retain) NSNumber * start;
@property (retain) NSNumber * count;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetPendingMessagesExResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfPendingMessage * GetPendingMessagesExResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetPendingMessagesExResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfPendingMessage * GetPendingMessagesExResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetReceivedMessagesCount : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetReceivedMessagesCount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetReceivedMessagesCountResponse : NSObject {
	
/* elements */
	NSNumber * GetReceivedMessagesCountResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetReceivedMessagesCountResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * GetReceivedMessagesCountResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetReceivedMessages : NSObject {
	
/* elements */
	USBoolean * returnImagedata;
	NSNumber * sortColumn;
	USBoolean * ascending;
	NSNumber * start;
	NSNumber * count;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetReceivedMessages *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * returnImagedata;
@property (retain) NSNumber * sortColumn;
@property (retain) USBoolean * ascending;
@property (retain) NSNumber * start;
@property (retain) NSNumber * count;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ReceivedMessageMetadata : NSObject {
	
/* elements */
	NSString * FaxIDInFolder;
	NSDate * ReceiveTime;
	NSDate * CompletionTime;
	NSString * TSI;
	NSString * CallerID;
	NSNumber * NumberOfPages;
	NSNumber * Status;
	NSString * StatusName;
	NSString * StatusText;
	NSNumber * ConnectTime;
	NSString * DID;
	NSString * FileExtension;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ReceivedMessageMetadata *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * FaxIDInFolder;
@property (retain) NSDate * ReceiveTime;
@property (retain) NSDate * CompletionTime;
@property (retain) NSString * TSI;
@property (retain) NSString * CallerID;
@property (retain) NSNumber * NumberOfPages;
@property (retain) NSNumber * Status;
@property (retain) NSString * StatusName;
@property (retain) NSString * StatusText;
@property (retain) NSNumber * ConnectTime;
@property (retain) NSString * DID;
@property (retain) NSString * FileExtension;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ReceivedMessageData : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ReceivedMessageMetadata * Metadata;
	NSData * Imagedata;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ReceivedMessageData *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ReceivedMessageMetadata * Metadata;
@property (retain) NSData * Imagedata;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ArrayOfReceivedMessageData : NSObject {
	
/* elements */
	NSMutableArray *ReceivedMessageData;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ArrayOfReceivedMessageData *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addReceivedMessageData:(FAXCOM_x0020_Service_ReceivedMessageData *)toAdd;
@property (readonly) NSMutableArray * ReceivedMessageData;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetReceivedMessagesResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfReceivedMessageData * GetReceivedMessagesResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetReceivedMessagesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfReceivedMessageData * GetReceivedMessagesResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetReceivedMessages2 : NSObject {
	
/* elements */
	USBoolean * returnImagedata;
	NSNumber * sortColumn;
	USBoolean * ascending;
	NSNumber * start;
	NSNumber * count;
	NSString * format;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetReceivedMessages2 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * returnImagedata;
@property (retain) NSNumber * sortColumn;
@property (retain) USBoolean * ascending;
@property (retain) NSNumber * start;
@property (retain) NSNumber * count;
@property (retain) NSString * format;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetReceivedMessages2Response : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfReceivedMessageData * GetReceivedMessages2Result;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetReceivedMessages2Response *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfReceivedMessageData * GetReceivedMessages2Result;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetReceivedMessages3 : NSObject {
	
/* elements */
	USBoolean * returnImagedata;
	NSNumber * sortColumn;
	USBoolean * ascending;
	NSNumber * start;
	NSNumber * count;
	NSString * format;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetReceivedMessages3 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * returnImagedata;
@property (retain) NSNumber * sortColumn;
@property (retain) USBoolean * ascending;
@property (retain) NSNumber * start;
@property (retain) NSNumber * count;
@property (retain) NSString * format;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ReceivedMessageMetadata2 : NSObject {
	
/* elements */
	NSString * FaxIDInFolder;
	NSDate * ReceiveTime;
	NSDate * CompletionTime;
	NSString * TSI;
	NSString * CallerID;
	NSNumber * NumberOfPages;
	NSNumber * Status;
	NSString * StatusName;
	NSString * StatusText;
	NSNumber * ConnectTime;
	NSString * DID;
	NSString * FileExtension;
	USBoolean * IsRead;
	NSString * Annotations;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ReceivedMessageMetadata2 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * FaxIDInFolder;
@property (retain) NSDate * ReceiveTime;
@property (retain) NSDate * CompletionTime;
@property (retain) NSString * TSI;
@property (retain) NSString * CallerID;
@property (retain) NSNumber * NumberOfPages;
@property (retain) NSNumber * Status;
@property (retain) NSString * StatusName;
@property (retain) NSString * StatusText;
@property (retain) NSNumber * ConnectTime;
@property (retain) NSString * DID;
@property (retain) NSString * FileExtension;
@property (retain) USBoolean * IsRead;
@property (retain) NSString * Annotations;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ReceivedMessageData2 : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ReceivedMessageMetadata2 * Metadata;
	NSData * Imagedata;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ReceivedMessageData2 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ReceivedMessageMetadata2 * Metadata;
@property (retain) NSData * Imagedata;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ArrayOfReceivedMessageData2 : NSObject {
	
/* elements */
	NSMutableArray *ReceivedMessageData2;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ArrayOfReceivedMessageData2 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addReceivedMessageData2:(FAXCOM_x0020_Service_ReceivedMessageData2 *)toAdd;
@property (readonly) NSMutableArray * ReceivedMessageData2;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetReceivedMessages3Response : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfReceivedMessageData2 * GetReceivedMessages3Result;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetReceivedMessages3Response *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfReceivedMessageData2 * GetReceivedMessages3Result;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ArrayOfString : NSObject {
	
/* elements */
	NSMutableArray *string;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ArrayOfString *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addString:(NSString *)toAdd;
@property (readonly) NSMutableArray * string;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetReceivedMessagesByIDs : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfString * faxIDsInFolder;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetReceivedMessagesByIDs *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfString * faxIDsInFolder;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetReceivedMessagesByIDsResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfReceivedMessageData * GetReceivedMessagesByIDsResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetReceivedMessagesByIDsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfReceivedMessageData * GetReceivedMessagesByIDsResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetReceivedMessagesByIDs2 : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfString * faxIDsInFolder;
	NSString * format;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetReceivedMessagesByIDs2 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfString * faxIDsInFolder;
@property (retain) NSString * format;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetReceivedMessagesByIDs2Response : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfReceivedMessageData * GetReceivedMessagesByIDs2Result;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetReceivedMessagesByIDs2Response *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfReceivedMessageData * GetReceivedMessagesByIDs2Result;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfString * faxIDsInFolder;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfString * faxIDsInFolder;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_RemoveReceivedMessagesByIDsResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * RemoveReceivedMessagesByIDsResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_RemoveReceivedMessagesByIDsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * RemoveReceivedMessagesByIDsResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDs : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfString * uniqueIDs;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDs *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfString * uniqueIDs;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDsResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfMessageStatus * GetMessageStatusesByUniqueIDsResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfMessageStatus * GetMessageStatusesByUniqueIDsResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_MessageStatusQuery : NSObject {
	
/* elements */
	NSString * UniqueID;
	NSNumber * Index;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_MessageStatusQuery *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * UniqueID;
@property (retain) NSNumber * Index;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ArrayOfMessageStatusQuery : NSObject {
	
/* elements */
	NSMutableArray *MessageStatusQuery;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ArrayOfMessageStatusQuery *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addMessageStatusQuery:(FAXCOM_x0020_Service_MessageStatusQuery *)toAdd;
@property (readonly) NSMutableArray * MessageStatusQuery;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueries : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfMessageStatusQuery * queries;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueries *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfMessageStatusQuery * queries;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_MessageStatusQueryResult : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_MessageStatusQuery * Query;
	FAXCOM_x0020_Service_MessageStatus * Status;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_MessageStatusQueryResult *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_MessageStatusQuery * Query;
@property (retain) FAXCOM_x0020_Service_MessageStatus * Status;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ArrayOfMessageStatusQueryResult : NSObject {
	
/* elements */
	NSMutableArray *MessageStatusQueryResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ArrayOfMessageStatusQueryResult *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addMessageStatusQueryResult:(FAXCOM_x0020_Service_MessageStatusQueryResult *)toAdd;
@property (readonly) NSMutableArray * MessageStatusQueryResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueriesResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfMessageStatusQueryResult * GetMessageStatusesByMessageStatusQueriesResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueriesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfMessageStatusQueryResult * GetMessageStatusesByMessageStatusQueriesResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_NewFaxMessage2 : NSObject {
	
/* elements */
	NSNumber * priority;
	NSString * sendTime;
	NSNumber * resolution;
	NSString * subject;
	NSString * coverpage;
	NSString * memo;
	NSString * senderName;
	NSString * senderCompany;
	NSString * senderFax;
	NSString * recipientName;
	NSString * recipientCompany;
	NSString * recipientFax;
	NSString * recipientVoice;
	NSString * recipientAccount;
	NSString * tsi;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_NewFaxMessage2 *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * priority;
@property (retain) NSString * sendTime;
@property (retain) NSNumber * resolution;
@property (retain) NSString * subject;
@property (retain) NSString * coverpage;
@property (retain) NSString * memo;
@property (retain) NSString * senderName;
@property (retain) NSString * senderCompany;
@property (retain) NSString * senderFax;
@property (retain) NSString * recipientName;
@property (retain) NSString * recipientCompany;
@property (retain) NSString * recipientFax;
@property (retain) NSString * recipientVoice;
@property (retain) NSString * recipientAccount;
@property (retain) NSString * tsi;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_NewFaxMessage2Response : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * NewFaxMessage2Result;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_NewFaxMessage2Response *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * NewFaxMessage2Result;
/* attributes */
- (NSDictionary *)attributes;
@end
typedef enum {
	FAXCOM_x0020_Service_PHONEBOOKSCOPE_none = 0,
	FAXCOM_x0020_Service_PHONEBOOKSCOPE_PRIVATE,
	FAXCOM_x0020_Service_PHONEBOOKSCOPE_PUBLIC,
} FAXCOM_x0020_Service_PHONEBOOKSCOPE;
FAXCOM_x0020_Service_PHONEBOOKSCOPE FAXCOM_x0020_Service_PHONEBOOKSCOPE_enumFromString(NSString *string);
NSString * FAXCOM_x0020_Service_PHONEBOOKSCOPE_stringFromEnum(FAXCOM_x0020_Service_PHONEBOOKSCOPE enumValue);
@interface FAXCOM_x0020_Service_ListPhonebooks : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ListPhonebooks *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_PhonebookInfo : NSObject {
	
/* elements */
	NSString * PhonebookName;
	NSNumber * PhonebookID;
	FAXCOM_x0020_Service_PHONEBOOKSCOPE Scope;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_PhonebookInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * PhonebookName;
@property (retain) NSNumber * PhonebookID;
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE Scope;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ArrayOfPhonebookInfo : NSObject {
	
/* elements */
	NSMutableArray *PhonebookInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ArrayOfPhonebookInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addPhonebookInfo:(FAXCOM_x0020_Service_PhonebookInfo *)toAdd;
@property (readonly) NSMutableArray * PhonebookInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ListPhonebooksResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfPhonebookInfo * ListPhonebooksResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ListPhonebooksResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfPhonebookInfo * ListPhonebooksResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_UpdatePhonebook : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
	NSNumber * phonebookID;
	NSString * theNewName;
	NSString * theNewDescription;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_UpdatePhonebook *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
@property (retain) NSNumber * phonebookID;
@property (retain) NSString * theNewName;
@property (retain) NSString * theNewDescription;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_UpdatePhonebookResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * UpdatePhonebookResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_UpdatePhonebookResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * UpdatePhonebookResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SubmitForPreview : NSObject {
	
/* elements */
	NSString * idtag;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SubmitForPreview *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * idtag;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SubmitForPreviewResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * SubmitForPreviewResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SubmitForPreviewResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * SubmitForPreviewResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetPendingImage : NSObject {
	
/* elements */
	NSString * uid;
	NSNumber * recipientIndex;
	NSString * format;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetPendingImage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * uid;
@property (retain) NSNumber * recipientIndex;
@property (retain) NSString * format;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_Attachment : NSObject {
	
/* elements */
	NSData * FileContent;
	NSString * FileName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_Attachment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSData * FileContent;
@property (retain) NSString * FileName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetPendingImageResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_Attachment * GetPendingImageResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetPendingImageResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_Attachment * GetPendingImageResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ReleasePendingMessage : NSObject {
	
/* elements */
	NSString * uid;
	NSNumber * recipientIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ReleasePendingMessage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * uid;
@property (retain) NSNumber * recipientIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ReleasePendingMessageResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * ReleasePendingMessageResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ReleasePendingMessageResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * ReleasePendingMessageResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_CancelPendingMessage : NSObject {
	
/* elements */
	NSString * uid;
	NSNumber * recipientIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_CancelPendingMessage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * uid;
@property (retain) NSNumber * recipientIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_CancelPendingMessageResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * CancelPendingMessageResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_CancelPendingMessageResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * CancelPendingMessageResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SenderInfo : NSObject {
	
/* elements */
	NSString * Name;
	NSString * FaxNumber;
	NSString * VoiceNumber;
	NSString * Email;
	NSString * Company;
	NSString * Address1;
	NSString * Address2;
	NSString * Address3;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SenderInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * Name;
@property (retain) NSString * FaxNumber;
@property (retain) NSString * VoiceNumber;
@property (retain) NSString * Email;
@property (retain) NSString * Company;
@property (retain) NSString * Address1;
@property (retain) NSString * Address2;
@property (retain) NSString * Address3;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_RecipientInfo : NSObject {
	
/* elements */
	NSString * Name;
	NSString * Company;
	NSString * FaxNumber;
	NSString * VoiceNumber;
	NSString * Address1;
	NSString * Address2;
	NSString * Address3;
	NSString * Account;
	NSString * CoverPage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_RecipientInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * Name;
@property (retain) NSString * Company;
@property (retain) NSString * FaxNumber;
@property (retain) NSString * VoiceNumber;
@property (retain) NSString * Address1;
@property (retain) NSString * Address2;
@property (retain) NSString * Address3;
@property (retain) NSString * Account;
@property (retain) NSString * CoverPage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ArrayOfRecipientInfo : NSObject {
	
/* elements */
	NSMutableArray *RecipientInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ArrayOfRecipientInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addRecipientInfo:(FAXCOM_x0020_Service_RecipientInfo *)toAdd;
@property (readonly) NSMutableArray * RecipientInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ArrayOfAttachment : NSObject {
	
/* elements */
	NSMutableArray *Attachment;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ArrayOfAttachment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addAttachment:(FAXCOM_x0020_Service_Attachment *)toAdd;
@property (readonly) NSMutableArray * Attachment;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_LoginAndSendNewFaxMessage : NSObject {
	
/* elements */
	NSString * faxQueue;
	NSString * userName;
	NSString * password;
	NSNumber * userType;
	NSString * idTag;
	NSNumber * priority;
	NSString * sendTime;
	NSNumber * resolution;
	NSString * subject;
	NSString * coverpage;
	NSString * memo;
	FAXCOM_x0020_Service_SenderInfo * senderInfo;
	FAXCOM_x0020_Service_ArrayOfRecipientInfo * recipients;
	FAXCOM_x0020_Service_ArrayOfAttachment * attachments;
	NSString * tsi;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_LoginAndSendNewFaxMessage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * faxQueue;
@property (retain) NSString * userName;
@property (retain) NSString * password;
@property (retain) NSNumber * userType;
@property (retain) NSString * idTag;
@property (retain) NSNumber * priority;
@property (retain) NSString * sendTime;
@property (retain) NSNumber * resolution;
@property (retain) NSString * subject;
@property (retain) NSString * coverpage;
@property (retain) NSString * memo;
@property (retain) FAXCOM_x0020_Service_SenderInfo * senderInfo;
@property (retain) FAXCOM_x0020_Service_ArrayOfRecipientInfo * recipients;
@property (retain) FAXCOM_x0020_Service_ArrayOfAttachment * attachments;
@property (retain) NSString * tsi;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_LoginAndSendNewFaxMessageResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * LoginAndSendNewFaxMessageResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_LoginAndSendNewFaxMessageResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * LoginAndSendNewFaxMessageResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SendNewFaxMessage : NSObject {
	
/* elements */
	NSString * idTag;
	NSNumber * priority;
	NSString * sendTime;
	NSNumber * resolution;
	NSString * subject;
	NSString * coverpage;
	NSString * memo;
	FAXCOM_x0020_Service_SenderInfo * senderInfo;
	FAXCOM_x0020_Service_ArrayOfRecipientInfo * recipients;
	FAXCOM_x0020_Service_ArrayOfAttachment * attachments;
	NSString * tsi;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SendNewFaxMessage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * idTag;
@property (retain) NSNumber * priority;
@property (retain) NSString * sendTime;
@property (retain) NSNumber * resolution;
@property (retain) NSString * subject;
@property (retain) NSString * coverpage;
@property (retain) NSString * memo;
@property (retain) FAXCOM_x0020_Service_SenderInfo * senderInfo;
@property (retain) FAXCOM_x0020_Service_ArrayOfRecipientInfo * recipients;
@property (retain) FAXCOM_x0020_Service_ArrayOfAttachment * attachments;
@property (retain) NSString * tsi;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SendNewFaxMessageResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * SendNewFaxMessageResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SendNewFaxMessageResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * SendNewFaxMessageResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetPhonebookAddresses : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
	NSNumber * phonebookID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetPhonebookAddresses *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
@property (retain) NSNumber * phonebookID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_AddressInfo : NSObject {
	
/* elements */
	NSString * FaxNumber;
	NSString * VoiceNumber;
	NSString * Company;
	NSString * Address1;
	NSString * Address2;
	NSString * Address3;
	NSString * Account;
	NSString * FirstName;
	NSString * LastName;
	NSNumber * ID_;
	NSNumber * PhonebookID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_AddressInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * FaxNumber;
@property (retain) NSString * VoiceNumber;
@property (retain) NSString * Company;
@property (retain) NSString * Address1;
@property (retain) NSString * Address2;
@property (retain) NSString * Address3;
@property (retain) NSString * Account;
@property (retain) NSString * FirstName;
@property (retain) NSString * LastName;
@property (retain) NSNumber * ID_;
@property (retain) NSNumber * PhonebookID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ArrayOfAddressInfo : NSObject {
	
/* elements */
	NSMutableArray *AddressInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ArrayOfAddressInfo *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addAddressInfo:(FAXCOM_x0020_Service_AddressInfo *)toAdd;
@property (readonly) NSMutableArray * AddressInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetPhonebookAddressesResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfAddressInfo * GetPhonebookAddressesResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetPhonebookAddressesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfAddressInfo * GetPhonebookAddressesResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_NewPhonebook : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
	NSString * phonebookName;
	NSString * phonebookDescription;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_NewPhonebook *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
@property (retain) NSString * phonebookName;
@property (retain) NSString * phonebookDescription;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_NewPhonebookResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * NewPhonebookResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_NewPhonebookResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * NewPhonebookResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_NewAddress : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE phonebookScope;
	NSNumber * phonebookID;
	FAXCOM_x0020_Service_AddressInfo * theNewAddressInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_NewAddress *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE phonebookScope;
@property (retain) NSNumber * phonebookID;
@property (retain) FAXCOM_x0020_Service_AddressInfo * theNewAddressInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_NewAddressResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * NewAddressResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_NewAddressResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * NewAddressResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_AddAddressToGroup : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE sourceScope;
	NSNumber * sourcePhonebookID;
	NSNumber * sourceAddressID;
	FAXCOM_x0020_Service_PHONEBOOKSCOPE targetScope;
	NSNumber * targetPhonebookID;
	NSString * targetGroupName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_AddAddressToGroup *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE sourceScope;
@property (retain) NSNumber * sourcePhonebookID;
@property (retain) NSNumber * sourceAddressID;
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE targetScope;
@property (retain) NSNumber * targetPhonebookID;
@property (retain) NSString * targetGroupName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_AddAddressToGroupResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * AddAddressToGroupResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_AddAddressToGroupResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * AddAddressToGroupResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ModifyAddress : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
	NSNumber * phonebookID;
	NSNumber * addressID;
	FAXCOM_x0020_Service_AddressInfo * modifiedAddress;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ModifyAddress *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
@property (retain) NSNumber * phonebookID;
@property (retain) NSNumber * addressID;
@property (retain) FAXCOM_x0020_Service_AddressInfo * modifiedAddress;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ModifyAddressResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * ModifyAddressResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ModifyAddressResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * ModifyAddressResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ModifyAddressInGroup : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
	NSNumber * phonebookID;
	NSString * groupName;
	NSNumber * addressID;
	FAXCOM_x0020_Service_AddressInfo * modifiedAddress;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ModifyAddressInGroup *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
@property (retain) NSNumber * phonebookID;
@property (retain) NSString * groupName;
@property (retain) NSNumber * addressID;
@property (retain) FAXCOM_x0020_Service_AddressInfo * modifiedAddress;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ModifyAddressInGroupResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * ModifyAddressInGroupResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ModifyAddressInGroupResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * ModifyAddressInGroupResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_DeleteAddress : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
	NSNumber * phonebookID;
	NSNumber * addressID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_DeleteAddress *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
@property (retain) NSNumber * phonebookID;
@property (retain) NSNumber * addressID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_DeleteAddressResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * DeleteAddressResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_DeleteAddressResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * DeleteAddressResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_DeleteAddressInGroup : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
	NSNumber * phonebookID;
	NSString * groupName;
	NSNumber * addressID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_DeleteAddressInGroup *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
@property (retain) NSNumber * phonebookID;
@property (retain) NSString * groupName;
@property (retain) NSNumber * addressID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_DeleteAddressInGroupResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * DeleteAddressInGroupResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_DeleteAddressInGroupResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * DeleteAddressInGroupResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_NewGroup : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
	NSNumber * phonebookID;
	NSString * groupName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_NewGroup *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
@property (retain) NSNumber * phonebookID;
@property (retain) NSString * groupName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_NewGroupResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * NewGroupResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_NewGroupResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * NewGroupResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ModifyGroup : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
	NSNumber * phonebookID;
	NSString * currentGroupName;
	NSString * theNewGroupName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ModifyGroup *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
@property (retain) NSNumber * phonebookID;
@property (retain) NSString * currentGroupName;
@property (retain) NSString * theNewGroupName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ModifyGroupResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * ModifyGroupResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ModifyGroupResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * ModifyGroupResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ListPhonebookGroups : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
	NSNumber * phonebookID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ListPhonebookGroups *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
@property (retain) NSNumber * phonebookID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ListPhonebookGroupsResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfString * ListPhonebookGroupsResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ListPhonebookGroupsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfString * ListPhonebookGroupsResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetGroupAddresses : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
	NSNumber * phonebookID;
	NSString * groupName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetGroupAddresses *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
@property (retain) NSNumber * phonebookID;
@property (retain) NSString * groupName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetGroupAddressesResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfAddressInfo * GetGroupAddressesResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetGroupAddressesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfAddressInfo * GetGroupAddressesResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_DeletePhonebook : NSObject {
	
/* elements */
	NSNumber * phonebookID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_DeletePhonebook *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * phonebookID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_DeletePhonebookResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * DeletePhonebookResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_DeletePhonebookResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * DeletePhonebookResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_DeleteGroup : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
	NSNumber * phonebookID;
	NSString * groupName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_DeleteGroup *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (assign) FAXCOM_x0020_Service_PHONEBOOKSCOPE scope;
@property (retain) NSNumber * phonebookID;
@property (retain) NSString * groupName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_DeleteGroupResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * DeleteGroupResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_DeleteGroupResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * DeleteGroupResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetCoverpageList : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetCoverpageList *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetCoverpageListResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfString * GetCoverpageListResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetCoverpageListResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfString * GetCoverpageListResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetSentImage : NSObject {
	
/* elements */
	NSString * uniqueJobID;
	NSNumber * recipientIndex;
	NSString * format;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetSentImage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * uniqueJobID;
@property (retain) NSNumber * recipientIndex;
@property (retain) NSString * format;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetSentImageResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_Attachment * GetSentImageResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetSentImageResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_Attachment * GetSentImageResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_NewFaxMessageFromUniqueID : NSObject {
	
/* elements */
	NSString * uniqueJobID;
	NSNumber * recipientIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_NewFaxMessageFromUniqueID *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * uniqueJobID;
@property (retain) NSNumber * recipientIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_NewFaxMessageFromUniqueIDResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * NewFaxMessageFromUniqueIDResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_NewFaxMessageFromUniqueIDResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * NewFaxMessageFromUniqueIDResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetFaxMessageProperties : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetFaxMessageProperties *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_FaxMessageProperties : NSObject {
	
/* elements */
	NSString * Coverpage;
	FAXCOM_x0020_Service_ArrayOfRecipientInfo * Recipients;
	FAXCOM_x0020_Service_SenderInfo * Sender;
	NSString * Memo;
	NSString * Subject;
	NSNumber * Priority;
	NSNumber * Resolution;
	NSString * SendTime;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_FaxMessageProperties *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * Coverpage;
@property (retain) FAXCOM_x0020_Service_ArrayOfRecipientInfo * Recipients;
@property (retain) FAXCOM_x0020_Service_SenderInfo * Sender;
@property (retain) NSString * Memo;
@property (retain) NSString * Subject;
@property (retain) NSNumber * Priority;
@property (retain) NSNumber * Resolution;
@property (retain) NSString * SendTime;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetFaxMessagePropertiesResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_FaxMessageProperties * GetFaxMessagePropertiesResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetFaxMessagePropertiesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_FaxMessageProperties * GetFaxMessagePropertiesResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SetFaxMessageProperties : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_FaxMessageProperties * messageProperties;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SetFaxMessageProperties *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_FaxMessageProperties * messageProperties;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_SetFaxMessagePropertiesResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * SetFaxMessagePropertiesResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_SetFaxMessagePropertiesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * SetFaxMessagePropertiesResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetAttachments : NSObject {
	
/* elements */
	USBoolean * includeFileContent;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetAttachments *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * includeFileContent;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetAttachmentsResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfAttachment * GetAttachmentsResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetAttachmentsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfAttachment * GetAttachmentsResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetAttachment : NSObject {
	
/* elements */
	NSNumber * attachmentIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetAttachment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * attachmentIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_GetAttachmentResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_Attachment * GetAttachmentResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_GetAttachmentResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_Attachment * GetAttachmentResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_RemoveAttachment : NSObject {
	
/* elements */
	NSNumber * attachmentIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_RemoveAttachment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * attachmentIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_RemoveAttachmentResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * RemoveAttachmentResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_RemoveAttachmentResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * RemoveAttachmentResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ResendFailedFax : NSObject {
	
/* elements */
	NSString * uniqueJobID;
	NSNumber * recipientIndex;
	NSString * theNewFaxNumber;
	NSString * theNewSendTime;
	NSNumber * theNewPriority;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ResendFailedFax *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * uniqueJobID;
@property (retain) NSNumber * recipientIndex;
@property (retain) NSString * theNewFaxNumber;
@property (retain) NSString * theNewSendTime;
@property (retain) NSNumber * theNewPriority;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ResendFailedFaxResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * ResendFailedFaxResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ResendFailedFaxResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * ResendFailedFaxResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ListSupportedFeatures : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ListSupportedFeatures *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_ListSupportedFeaturesResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfString * ListSupportedFeaturesResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_ListSupportedFeaturesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfString * ListSupportedFeaturesResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_MarkAsReadByIDs : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ArrayOfString * faxIDs;
	USBoolean * readFlag;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_MarkAsReadByIDs *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ArrayOfString * faxIDs;
@property (retain) USBoolean * readFlag;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAXCOM_x0020_Service_MarkAsReadByIDsResponse : NSObject {
	
/* elements */
	FAXCOM_x0020_Service_ResultMessage * MarkAsReadByIDsResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAXCOM_x0020_Service_MarkAsReadByIDsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAXCOM_x0020_Service_ResultMessage * MarkAsReadByIDsResult;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "FAXCOM_x0020_Service.h"
@class FAXCOM_x0020_ServiceSoapBinding;
@class FAXCOM_x0020_ServiceSoap12Binding;
@interface FAXCOM_x0020_Service : NSObject {
	
}
+ (FAXCOM_x0020_ServiceSoapBinding *)FAXCOM_x0020_ServiceSoapBinding;
+ (FAXCOM_x0020_ServiceSoap12Binding *)FAXCOM_x0020_ServiceSoap12Binding;
@end
@class FAXCOM_x0020_ServiceSoapBindingResponse;
@class FAXCOM_x0020_ServiceSoapBindingOperation;
@protocol FAXCOM_x0020_ServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(FAXCOM_x0020_ServiceSoapBindingOperation *)operation completedWithResponse:(FAXCOM_x0020_ServiceSoapBindingResponse *)response;
@end
@interface FAXCOM_x0020_ServiceSoapBinding : NSObject <FAXCOM_x0020_ServiceSoapBindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(FAXCOM_x0020_ServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)ShowThreadingModelUsingParameters:(FAXCOM_x0020_Service_ShowThreadingModel *)aParameters ;
- (void)ShowThreadingModelAsyncUsingParameters:(FAXCOM_x0020_Service_ShowThreadingModel *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)WebServiceVersionUsingParameters:(FAXCOM_x0020_Service_WebServiceVersion *)aParameters ;
- (void)WebServiceVersionAsyncUsingParameters:(FAXCOM_x0020_Service_WebServiceVersion *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)SetLegacyModeUsingParameters:(FAXCOM_x0020_Service_SetLegacyMode *)aParameters ;
- (void)SetLegacyModeAsyncUsingParameters:(FAXCOM_x0020_Service_SetLegacyMode *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetLegacyModeUsingParameters:(FAXCOM_x0020_Service_GetLegacyMode *)aParameters ;
- (void)GetLegacyModeAsyncUsingParameters:(FAXCOM_x0020_Service_GetLegacyMode *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)LogOnUsingParameters:(FAXCOM_x0020_Service_LogOn *)aParameters ;
- (void)LogOnAsyncUsingParameters:(FAXCOM_x0020_Service_LogOn *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)ReleaseSessionUsingParameters:(FAXCOM_x0020_Service_ReleaseSession *)aParameters ;
- (void)ReleaseSessionAsyncUsingParameters:(FAXCOM_x0020_Service_ReleaseSession *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)SetSenderInformationUsingParameters:(FAXCOM_x0020_Service_SetSenderInformation *)aParameters ;
- (void)SetSenderInformationAsyncUsingParameters:(FAXCOM_x0020_Service_SetSenderInformation *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)NewFaxMessageUsingParameters:(FAXCOM_x0020_Service_NewFaxMessage *)aParameters ;
- (void)NewFaxMessageAsyncUsingParameters:(FAXCOM_x0020_Service_NewFaxMessage *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)AddRecipientUsingParameters:(FAXCOM_x0020_Service_AddRecipient *)aParameters ;
- (void)AddRecipientAsyncUsingParameters:(FAXCOM_x0020_Service_AddRecipient *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)AddRecipientExUsingParameters:(FAXCOM_x0020_Service_AddRecipientEx *)aParameters ;
- (void)AddRecipientExAsyncUsingParameters:(FAXCOM_x0020_Service_AddRecipientEx *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)SendFaxUsingParameters:(FAXCOM_x0020_Service_SendFax *)aParameters ;
- (void)SendFaxAsyncUsingParameters:(FAXCOM_x0020_Service_SendFax *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetLastUniqueJobIDUsingParameters:(FAXCOM_x0020_Service_GetLastUniqueJobID *)aParameters ;
- (void)GetLastUniqueJobIDAsyncUsingParameters:(FAXCOM_x0020_Service_GetLastUniqueJobID *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)SaveFaxUsingParameters:(FAXCOM_x0020_Service_SaveFax *)aParameters ;
- (void)SaveFaxAsyncUsingParameters:(FAXCOM_x0020_Service_SaveFax *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)AddAttachmentUsingParameters:(FAXCOM_x0020_Service_AddAttachment *)aParameters ;
- (void)AddAttachmentAsyncUsingParameters:(FAXCOM_x0020_Service_AddAttachment *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)AddAttachmentByUNCUsingParameters:(FAXCOM_x0020_Service_AddAttachmentByUNC *)aParameters ;
- (void)AddAttachmentByUNCAsyncUsingParameters:(FAXCOM_x0020_Service_AddAttachmentByUNC *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetMessageStatusByUniqueIDUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusByUniqueID *)aParameters ;
- (void)GetMessageStatusByUniqueIDAsyncUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusByUniqueID *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetMessageStatusByIDTagUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusByIDTag *)aParameters ;
- (void)GetMessageStatusByIDTagAsyncUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusByIDTag *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetMessageStatusesCountUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesCount *)aParameters ;
- (void)GetMessageStatusesCountAsyncUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesCount *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetMessageStatusesUsingParameters:(FAXCOM_x0020_Service_GetMessageStatuses *)aParameters ;
- (void)GetMessageStatusesAsyncUsingParameters:(FAXCOM_x0020_Service_GetMessageStatuses *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetMessageStatusesExUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesEx *)aParameters ;
- (void)GetMessageStatusesExAsyncUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesEx *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)RemoveMessageStatusbyUniqueIDUsingParameters:(FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID *)aParameters ;
- (void)RemoveMessageStatusbyUniqueIDAsyncUsingParameters:(FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetPendingMessageByUniqueIDUsingParameters:(FAXCOM_x0020_Service_GetPendingMessageByUniqueID *)aParameters ;
- (void)GetPendingMessageByUniqueIDAsyncUsingParameters:(FAXCOM_x0020_Service_GetPendingMessageByUniqueID *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetPendingMessageByIDTagUsingParameters:(FAXCOM_x0020_Service_GetPendingMessageByIDTag *)aParameters ;
- (void)GetPendingMessageByIDTagAsyncUsingParameters:(FAXCOM_x0020_Service_GetPendingMessageByIDTag *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetPendingMessagesCountUsingParameters:(FAXCOM_x0020_Service_GetPendingMessagesCount *)aParameters ;
- (void)GetPendingMessagesCountAsyncUsingParameters:(FAXCOM_x0020_Service_GetPendingMessagesCount *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetPendingMessagesUsingParameters:(FAXCOM_x0020_Service_GetPendingMessages *)aParameters ;
- (void)GetPendingMessagesAsyncUsingParameters:(FAXCOM_x0020_Service_GetPendingMessages *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetPendingMessagesExUsingParameters:(FAXCOM_x0020_Service_GetPendingMessagesEx *)aParameters ;
- (void)GetPendingMessagesExAsyncUsingParameters:(FAXCOM_x0020_Service_GetPendingMessagesEx *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetReceivedMessagesCountUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessagesCount *)aParameters ;
- (void)GetReceivedMessagesCountAsyncUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessagesCount *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetReceivedMessagesUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessages *)aParameters ;
- (void)GetReceivedMessagesAsyncUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessages *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetReceivedMessages2UsingParameters:(FAXCOM_x0020_Service_GetReceivedMessages2 *)aParameters ;
- (void)GetReceivedMessages2AsyncUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessages2 *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetReceivedMessages3UsingParameters:(FAXCOM_x0020_Service_GetReceivedMessages3 *)aParameters ;
- (void)GetReceivedMessages3AsyncUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessages3 *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetReceivedMessagesByIDsUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessagesByIDs *)aParameters ;
- (void)GetReceivedMessagesByIDsAsyncUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessagesByIDs *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetReceivedMessagesByIDs2UsingParameters:(FAXCOM_x0020_Service_GetReceivedMessagesByIDs2 *)aParameters ;
- (void)GetReceivedMessagesByIDs2AsyncUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessagesByIDs2 *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)RemoveReceivedMessagesByIDsUsingParameters:(FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs *)aParameters ;
- (void)RemoveReceivedMessagesByIDsAsyncUsingParameters:(FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetMessageStatusesByUniqueIDsUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDs *)aParameters ;
- (void)GetMessageStatusesByUniqueIDsAsyncUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDs *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetMessageStatusesByMessageStatusQueriesUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueries *)aParameters ;
- (void)GetMessageStatusesByMessageStatusQueriesAsyncUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueries *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)NewFaxMessage2UsingParameters:(FAXCOM_x0020_Service_NewFaxMessage2 *)aParameters ;
- (void)NewFaxMessage2AsyncUsingParameters:(FAXCOM_x0020_Service_NewFaxMessage2 *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)ListPhonebooksUsingParameters:(FAXCOM_x0020_Service_ListPhonebooks *)aParameters ;
- (void)ListPhonebooksAsyncUsingParameters:(FAXCOM_x0020_Service_ListPhonebooks *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)UpdatePhonebookUsingParameters:(FAXCOM_x0020_Service_UpdatePhonebook *)aParameters ;
- (void)UpdatePhonebookAsyncUsingParameters:(FAXCOM_x0020_Service_UpdatePhonebook *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)SubmitForPreviewUsingParameters:(FAXCOM_x0020_Service_SubmitForPreview *)aParameters ;
- (void)SubmitForPreviewAsyncUsingParameters:(FAXCOM_x0020_Service_SubmitForPreview *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetPendingImageUsingParameters:(FAXCOM_x0020_Service_GetPendingImage *)aParameters ;
- (void)GetPendingImageAsyncUsingParameters:(FAXCOM_x0020_Service_GetPendingImage *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)ReleasePendingMessageUsingParameters:(FAXCOM_x0020_Service_ReleasePendingMessage *)aParameters ;
- (void)ReleasePendingMessageAsyncUsingParameters:(FAXCOM_x0020_Service_ReleasePendingMessage *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)CancelPendingMessageUsingParameters:(FAXCOM_x0020_Service_CancelPendingMessage *)aParameters ;
- (void)CancelPendingMessageAsyncUsingParameters:(FAXCOM_x0020_Service_CancelPendingMessage *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)LoginAndSendNewFaxMessageUsingParameters:(FAXCOM_x0020_Service_LoginAndSendNewFaxMessage *)aParameters ;
- (void)LoginAndSendNewFaxMessageAsyncUsingParameters:(FAXCOM_x0020_Service_LoginAndSendNewFaxMessage *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)SendNewFaxMessageUsingParameters:(FAXCOM_x0020_Service_SendNewFaxMessage *)aParameters ;
- (void)SendNewFaxMessageAsyncUsingParameters:(FAXCOM_x0020_Service_SendNewFaxMessage *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetPhonebookAddressesUsingParameters:(FAXCOM_x0020_Service_GetPhonebookAddresses *)aParameters ;
- (void)GetPhonebookAddressesAsyncUsingParameters:(FAXCOM_x0020_Service_GetPhonebookAddresses *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)NewPhonebookUsingParameters:(FAXCOM_x0020_Service_NewPhonebook *)aParameters ;
- (void)NewPhonebookAsyncUsingParameters:(FAXCOM_x0020_Service_NewPhonebook *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)NewAddressUsingParameters:(FAXCOM_x0020_Service_NewAddress *)aParameters ;
- (void)NewAddressAsyncUsingParameters:(FAXCOM_x0020_Service_NewAddress *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)AddAddressToGroupUsingParameters:(FAXCOM_x0020_Service_AddAddressToGroup *)aParameters ;
- (void)AddAddressToGroupAsyncUsingParameters:(FAXCOM_x0020_Service_AddAddressToGroup *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)ModifyAddressUsingParameters:(FAXCOM_x0020_Service_ModifyAddress *)aParameters ;
- (void)ModifyAddressAsyncUsingParameters:(FAXCOM_x0020_Service_ModifyAddress *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)ModifyAddressInGroupUsingParameters:(FAXCOM_x0020_Service_ModifyAddressInGroup *)aParameters ;
- (void)ModifyAddressInGroupAsyncUsingParameters:(FAXCOM_x0020_Service_ModifyAddressInGroup *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)DeleteAddressUsingParameters:(FAXCOM_x0020_Service_DeleteAddress *)aParameters ;
- (void)DeleteAddressAsyncUsingParameters:(FAXCOM_x0020_Service_DeleteAddress *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)DeleteAddressInGroupUsingParameters:(FAXCOM_x0020_Service_DeleteAddressInGroup *)aParameters ;
- (void)DeleteAddressInGroupAsyncUsingParameters:(FAXCOM_x0020_Service_DeleteAddressInGroup *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)NewGroupUsingParameters:(FAXCOM_x0020_Service_NewGroup *)aParameters ;
- (void)NewGroupAsyncUsingParameters:(FAXCOM_x0020_Service_NewGroup *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)ModifyGroupUsingParameters:(FAXCOM_x0020_Service_ModifyGroup *)aParameters ;
- (void)ModifyGroupAsyncUsingParameters:(FAXCOM_x0020_Service_ModifyGroup *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)ListPhonebookGroupsUsingParameters:(FAXCOM_x0020_Service_ListPhonebookGroups *)aParameters ;
- (void)ListPhonebookGroupsAsyncUsingParameters:(FAXCOM_x0020_Service_ListPhonebookGroups *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetGroupAddressesUsingParameters:(FAXCOM_x0020_Service_GetGroupAddresses *)aParameters ;
- (void)GetGroupAddressesAsyncUsingParameters:(FAXCOM_x0020_Service_GetGroupAddresses *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)DeletePhonebookUsingParameters:(FAXCOM_x0020_Service_DeletePhonebook *)aParameters ;
- (void)DeletePhonebookAsyncUsingParameters:(FAXCOM_x0020_Service_DeletePhonebook *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)DeleteGroupUsingParameters:(FAXCOM_x0020_Service_DeleteGroup *)aParameters ;
- (void)DeleteGroupAsyncUsingParameters:(FAXCOM_x0020_Service_DeleteGroup *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetCoverpageListUsingParameters:(FAXCOM_x0020_Service_GetCoverpageList *)aParameters ;
- (void)GetCoverpageListAsyncUsingParameters:(FAXCOM_x0020_Service_GetCoverpageList *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetSentImageUsingParameters:(FAXCOM_x0020_Service_GetSentImage *)aParameters ;
- (void)GetSentImageAsyncUsingParameters:(FAXCOM_x0020_Service_GetSentImage *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)NewFaxMessageFromUniqueIDUsingParameters:(FAXCOM_x0020_Service_NewFaxMessageFromUniqueID *)aParameters ;
- (void)NewFaxMessageFromUniqueIDAsyncUsingParameters:(FAXCOM_x0020_Service_NewFaxMessageFromUniqueID *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetFaxMessagePropertiesUsingParameters:(FAXCOM_x0020_Service_GetFaxMessageProperties *)aParameters ;
- (void)GetFaxMessagePropertiesAsyncUsingParameters:(FAXCOM_x0020_Service_GetFaxMessageProperties *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)SetFaxMessagePropertiesUsingParameters:(FAXCOM_x0020_Service_SetFaxMessageProperties *)aParameters ;
- (void)SetFaxMessagePropertiesAsyncUsingParameters:(FAXCOM_x0020_Service_SetFaxMessageProperties *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetAttachmentsUsingParameters:(FAXCOM_x0020_Service_GetAttachments *)aParameters ;
- (void)GetAttachmentsAsyncUsingParameters:(FAXCOM_x0020_Service_GetAttachments *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)GetAttachmentUsingParameters:(FAXCOM_x0020_Service_GetAttachment *)aParameters ;
- (void)GetAttachmentAsyncUsingParameters:(FAXCOM_x0020_Service_GetAttachment *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)RemoveAttachmentUsingParameters:(FAXCOM_x0020_Service_RemoveAttachment *)aParameters ;
- (void)RemoveAttachmentAsyncUsingParameters:(FAXCOM_x0020_Service_RemoveAttachment *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)ResendFailedFaxUsingParameters:(FAXCOM_x0020_Service_ResendFailedFax *)aParameters ;
- (void)ResendFailedFaxAsyncUsingParameters:(FAXCOM_x0020_Service_ResendFailedFax *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)ListSupportedFeaturesUsingParameters:(FAXCOM_x0020_Service_ListSupportedFeatures *)aParameters ;
- (void)ListSupportedFeaturesAsyncUsingParameters:(FAXCOM_x0020_Service_ListSupportedFeatures *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoapBindingResponse *)MarkAsReadByIDsUsingParameters:(FAXCOM_x0020_Service_MarkAsReadByIDs *)aParameters ;
- (void)MarkAsReadByIDsAsyncUsingParameters:(FAXCOM_x0020_Service_MarkAsReadByIDs *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface FAXCOM_x0020_ServiceSoapBindingOperation : NSOperation {
	FAXCOM_x0020_ServiceSoapBinding *binding;
	FAXCOM_x0020_ServiceSoapBindingResponse *response;
	id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) FAXCOM_x0020_ServiceSoapBinding *binding;
@property (readonly) FAXCOM_x0020_ServiceSoapBindingResponse *response;
@property (nonatomic, assign) id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_ShowThreadingModel : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_ShowThreadingModel * parameters;
}
@property (retain) FAXCOM_x0020_Service_ShowThreadingModel * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ShowThreadingModel *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_WebServiceVersion : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_WebServiceVersion * parameters;
}
@property (retain) FAXCOM_x0020_Service_WebServiceVersion * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_WebServiceVersion *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_SetLegacyMode : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_SetLegacyMode * parameters;
}
@property (retain) FAXCOM_x0020_Service_SetLegacyMode * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_SetLegacyMode *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetLegacyMode : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetLegacyMode * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetLegacyMode * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetLegacyMode *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_LogOn : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_LogOn * parameters;
}
@property (retain) FAXCOM_x0020_Service_LogOn * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_LogOn *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_ReleaseSession : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_ReleaseSession * parameters;
}
@property (retain) FAXCOM_x0020_Service_ReleaseSession * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ReleaseSession *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_SetSenderInformation : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_SetSenderInformation * parameters;
}
@property (retain) FAXCOM_x0020_Service_SetSenderInformation * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_SetSenderInformation *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_NewFaxMessage : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_NewFaxMessage * parameters;
}
@property (retain) FAXCOM_x0020_Service_NewFaxMessage * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_NewFaxMessage *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_AddRecipient : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_AddRecipient * parameters;
}
@property (retain) FAXCOM_x0020_Service_AddRecipient * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_AddRecipient *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_AddRecipientEx : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_AddRecipientEx * parameters;
}
@property (retain) FAXCOM_x0020_Service_AddRecipientEx * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_AddRecipientEx *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_SendFax : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_SendFax * parameters;
}
@property (retain) FAXCOM_x0020_Service_SendFax * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_SendFax *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetLastUniqueJobID : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetLastUniqueJobID * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetLastUniqueJobID * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetLastUniqueJobID *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_SaveFax : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_SaveFax * parameters;
}
@property (retain) FAXCOM_x0020_Service_SaveFax * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_SaveFax *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_AddAttachment : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_AddAttachment * parameters;
}
@property (retain) FAXCOM_x0020_Service_AddAttachment * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_AddAttachment *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_AddAttachmentByUNC : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_AddAttachmentByUNC * parameters;
}
@property (retain) FAXCOM_x0020_Service_AddAttachmentByUNC * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_AddAttachmentByUNC *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetMessageStatusByUniqueID : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetMessageStatusByUniqueID * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetMessageStatusByUniqueID * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetMessageStatusByUniqueID *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetMessageStatusByIDTag : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetMessageStatusByIDTag * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetMessageStatusByIDTag * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetMessageStatusByIDTag *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetMessageStatusesCount : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetMessageStatusesCount * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetMessageStatusesCount * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetMessageStatusesCount *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetMessageStatuses : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetMessageStatuses * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetMessageStatuses * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetMessageStatuses *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetMessageStatusesEx : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetMessageStatusesEx * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetMessageStatusesEx * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetMessageStatusesEx *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_RemoveMessageStatusbyUniqueID : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID * parameters;
}
@property (retain) FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetPendingMessageByUniqueID : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetPendingMessageByUniqueID * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetPendingMessageByUniqueID * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetPendingMessageByUniqueID *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetPendingMessageByIDTag : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetPendingMessageByIDTag * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetPendingMessageByIDTag * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetPendingMessageByIDTag *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetPendingMessagesCount : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetPendingMessagesCount * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetPendingMessagesCount * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetPendingMessagesCount *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetPendingMessages : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetPendingMessages * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetPendingMessages * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetPendingMessages *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetPendingMessagesEx : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetPendingMessagesEx * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetPendingMessagesEx * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetPendingMessagesEx *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetReceivedMessagesCount : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetReceivedMessagesCount * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetReceivedMessagesCount * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetReceivedMessagesCount *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetReceivedMessages : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetReceivedMessages * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetReceivedMessages * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetReceivedMessages *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetReceivedMessages2 : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetReceivedMessages2 * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetReceivedMessages2 * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetReceivedMessages2 *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetReceivedMessages3 : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetReceivedMessages3 * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetReceivedMessages3 * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetReceivedMessages3 *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetReceivedMessagesByIDs : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetReceivedMessagesByIDs * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetReceivedMessagesByIDs * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetReceivedMessagesByIDs *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetReceivedMessagesByIDs2 : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetReceivedMessagesByIDs2 * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetReceivedMessagesByIDs2 * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetReceivedMessagesByIDs2 *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_RemoveReceivedMessagesByIDs : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs * parameters;
}
@property (retain) FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetMessageStatusesByUniqueIDs : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDs * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDs * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDs *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetMessageStatusesByMessageStatusQueries : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueries * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueries * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueries *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_NewFaxMessage2 : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_NewFaxMessage2 * parameters;
}
@property (retain) FAXCOM_x0020_Service_NewFaxMessage2 * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_NewFaxMessage2 *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_ListPhonebooks : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_ListPhonebooks * parameters;
}
@property (retain) FAXCOM_x0020_Service_ListPhonebooks * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ListPhonebooks *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_UpdatePhonebook : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_UpdatePhonebook * parameters;
}
@property (retain) FAXCOM_x0020_Service_UpdatePhonebook * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_UpdatePhonebook *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_SubmitForPreview : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_SubmitForPreview * parameters;
}
@property (retain) FAXCOM_x0020_Service_SubmitForPreview * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_SubmitForPreview *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetPendingImage : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetPendingImage * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetPendingImage * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetPendingImage *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_ReleasePendingMessage : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_ReleasePendingMessage * parameters;
}
@property (retain) FAXCOM_x0020_Service_ReleasePendingMessage * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ReleasePendingMessage *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_CancelPendingMessage : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_CancelPendingMessage * parameters;
}
@property (retain) FAXCOM_x0020_Service_CancelPendingMessage * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_CancelPendingMessage *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_LoginAndSendNewFaxMessage : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_LoginAndSendNewFaxMessage * parameters;
}
@property (retain) FAXCOM_x0020_Service_LoginAndSendNewFaxMessage * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_LoginAndSendNewFaxMessage *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_SendNewFaxMessage : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_SendNewFaxMessage * parameters;
}
@property (retain) FAXCOM_x0020_Service_SendNewFaxMessage * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_SendNewFaxMessage *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetPhonebookAddresses : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetPhonebookAddresses * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetPhonebookAddresses * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetPhonebookAddresses *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_NewPhonebook : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_NewPhonebook * parameters;
}
@property (retain) FAXCOM_x0020_Service_NewPhonebook * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_NewPhonebook *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_NewAddress : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_NewAddress * parameters;
}
@property (retain) FAXCOM_x0020_Service_NewAddress * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_NewAddress *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_AddAddressToGroup : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_AddAddressToGroup * parameters;
}
@property (retain) FAXCOM_x0020_Service_AddAddressToGroup * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_AddAddressToGroup *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_ModifyAddress : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_ModifyAddress * parameters;
}
@property (retain) FAXCOM_x0020_Service_ModifyAddress * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ModifyAddress *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_ModifyAddressInGroup : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_ModifyAddressInGroup * parameters;
}
@property (retain) FAXCOM_x0020_Service_ModifyAddressInGroup * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ModifyAddressInGroup *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_DeleteAddress : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_DeleteAddress * parameters;
}
@property (retain) FAXCOM_x0020_Service_DeleteAddress * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_DeleteAddress *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_DeleteAddressInGroup : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_DeleteAddressInGroup * parameters;
}
@property (retain) FAXCOM_x0020_Service_DeleteAddressInGroup * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_DeleteAddressInGroup *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_NewGroup : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_NewGroup * parameters;
}
@property (retain) FAXCOM_x0020_Service_NewGroup * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_NewGroup *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_ModifyGroup : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_ModifyGroup * parameters;
}
@property (retain) FAXCOM_x0020_Service_ModifyGroup * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ModifyGroup *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_ListPhonebookGroups : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_ListPhonebookGroups * parameters;
}
@property (retain) FAXCOM_x0020_Service_ListPhonebookGroups * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ListPhonebookGroups *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetGroupAddresses : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetGroupAddresses * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetGroupAddresses * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetGroupAddresses *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_DeletePhonebook : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_DeletePhonebook * parameters;
}
@property (retain) FAXCOM_x0020_Service_DeletePhonebook * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_DeletePhonebook *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_DeleteGroup : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_DeleteGroup * parameters;
}
@property (retain) FAXCOM_x0020_Service_DeleteGroup * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_DeleteGroup *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetCoverpageList : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetCoverpageList * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetCoverpageList * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetCoverpageList *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetSentImage : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetSentImage * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetSentImage * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetSentImage *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_NewFaxMessageFromUniqueID : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_NewFaxMessageFromUniqueID * parameters;
}
@property (retain) FAXCOM_x0020_Service_NewFaxMessageFromUniqueID * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_NewFaxMessageFromUniqueID *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetFaxMessageProperties : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetFaxMessageProperties * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetFaxMessageProperties * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetFaxMessageProperties *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_SetFaxMessageProperties : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_SetFaxMessageProperties * parameters;
}
@property (retain) FAXCOM_x0020_Service_SetFaxMessageProperties * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_SetFaxMessageProperties *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetAttachments : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetAttachments * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetAttachments * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetAttachments *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_GetAttachment : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_GetAttachment * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetAttachment * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetAttachment *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_RemoveAttachment : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_RemoveAttachment * parameters;
}
@property (retain) FAXCOM_x0020_Service_RemoveAttachment * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_RemoveAttachment *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_ResendFailedFax : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_ResendFailedFax * parameters;
}
@property (retain) FAXCOM_x0020_Service_ResendFailedFax * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ResendFailedFax *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_ListSupportedFeatures : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_ListSupportedFeatures * parameters;
}
@property (retain) FAXCOM_x0020_Service_ListSupportedFeatures * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ListSupportedFeatures *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_MarkAsReadByIDs : FAXCOM_x0020_ServiceSoapBindingOperation {
	FAXCOM_x0020_Service_MarkAsReadByIDs * parameters;
}
@property (retain) FAXCOM_x0020_Service_MarkAsReadByIDs * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoapBinding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_MarkAsReadByIDs *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoapBinding_envelope : NSObject {
}
+ (FAXCOM_x0020_ServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface FAXCOM_x0020_ServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
@class FAXCOM_x0020_ServiceSoap12BindingResponse;
@class FAXCOM_x0020_ServiceSoap12BindingOperation;
@protocol FAXCOM_x0020_ServiceSoap12BindingResponseDelegate <NSObject>
- (void) operation:(FAXCOM_x0020_ServiceSoap12BindingOperation *)operation completedWithResponse:(FAXCOM_x0020_ServiceSoap12BindingResponse *)response;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding : NSObject <FAXCOM_x0020_ServiceSoap12BindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(FAXCOM_x0020_ServiceSoap12BindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)ShowThreadingModelUsingParameters:(FAXCOM_x0020_Service_ShowThreadingModel *)aParameters ;
- (void)ShowThreadingModelAsyncUsingParameters:(FAXCOM_x0020_Service_ShowThreadingModel *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)WebServiceVersionUsingParameters:(FAXCOM_x0020_Service_WebServiceVersion *)aParameters ;
- (void)WebServiceVersionAsyncUsingParameters:(FAXCOM_x0020_Service_WebServiceVersion *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)SetLegacyModeUsingParameters:(FAXCOM_x0020_Service_SetLegacyMode *)aParameters ;
- (void)SetLegacyModeAsyncUsingParameters:(FAXCOM_x0020_Service_SetLegacyMode *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetLegacyModeUsingParameters:(FAXCOM_x0020_Service_GetLegacyMode *)aParameters ;
- (void)GetLegacyModeAsyncUsingParameters:(FAXCOM_x0020_Service_GetLegacyMode *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)LogOnUsingParameters:(FAXCOM_x0020_Service_LogOn *)aParameters ;
- (void)LogOnAsyncUsingParameters:(FAXCOM_x0020_Service_LogOn *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)ReleaseSessionUsingParameters:(FAXCOM_x0020_Service_ReleaseSession *)aParameters ;
- (void)ReleaseSessionAsyncUsingParameters:(FAXCOM_x0020_Service_ReleaseSession *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)SetSenderInformationUsingParameters:(FAXCOM_x0020_Service_SetSenderInformation *)aParameters ;
- (void)SetSenderInformationAsyncUsingParameters:(FAXCOM_x0020_Service_SetSenderInformation *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)NewFaxMessageUsingParameters:(FAXCOM_x0020_Service_NewFaxMessage *)aParameters ;
- (void)NewFaxMessageAsyncUsingParameters:(FAXCOM_x0020_Service_NewFaxMessage *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)AddRecipientUsingParameters:(FAXCOM_x0020_Service_AddRecipient *)aParameters ;
- (void)AddRecipientAsyncUsingParameters:(FAXCOM_x0020_Service_AddRecipient *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)AddRecipientExUsingParameters:(FAXCOM_x0020_Service_AddRecipientEx *)aParameters ;
- (void)AddRecipientExAsyncUsingParameters:(FAXCOM_x0020_Service_AddRecipientEx *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)SendFaxUsingParameters:(FAXCOM_x0020_Service_SendFax *)aParameters ;
- (void)SendFaxAsyncUsingParameters:(FAXCOM_x0020_Service_SendFax *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetLastUniqueJobIDUsingParameters:(FAXCOM_x0020_Service_GetLastUniqueJobID *)aParameters ;
- (void)GetLastUniqueJobIDAsyncUsingParameters:(FAXCOM_x0020_Service_GetLastUniqueJobID *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)SaveFaxUsingParameters:(FAXCOM_x0020_Service_SaveFax *)aParameters ;
- (void)SaveFaxAsyncUsingParameters:(FAXCOM_x0020_Service_SaveFax *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)AddAttachmentUsingParameters:(FAXCOM_x0020_Service_AddAttachment *)aParameters ;
- (void)AddAttachmentAsyncUsingParameters:(FAXCOM_x0020_Service_AddAttachment *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)AddAttachmentByUNCUsingParameters:(FAXCOM_x0020_Service_AddAttachmentByUNC *)aParameters ;
- (void)AddAttachmentByUNCAsyncUsingParameters:(FAXCOM_x0020_Service_AddAttachmentByUNC *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetMessageStatusByUniqueIDUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusByUniqueID *)aParameters ;
- (void)GetMessageStatusByUniqueIDAsyncUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusByUniqueID *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetMessageStatusByIDTagUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusByIDTag *)aParameters ;
- (void)GetMessageStatusByIDTagAsyncUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusByIDTag *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetMessageStatusesCountUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesCount *)aParameters ;
- (void)GetMessageStatusesCountAsyncUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesCount *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetMessageStatusesUsingParameters:(FAXCOM_x0020_Service_GetMessageStatuses *)aParameters ;
- (void)GetMessageStatusesAsyncUsingParameters:(FAXCOM_x0020_Service_GetMessageStatuses *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetMessageStatusesExUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesEx *)aParameters ;
- (void)GetMessageStatusesExAsyncUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesEx *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)RemoveMessageStatusbyUniqueIDUsingParameters:(FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID *)aParameters ;
- (void)RemoveMessageStatusbyUniqueIDAsyncUsingParameters:(FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetPendingMessageByUniqueIDUsingParameters:(FAXCOM_x0020_Service_GetPendingMessageByUniqueID *)aParameters ;
- (void)GetPendingMessageByUniqueIDAsyncUsingParameters:(FAXCOM_x0020_Service_GetPendingMessageByUniqueID *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetPendingMessageByIDTagUsingParameters:(FAXCOM_x0020_Service_GetPendingMessageByIDTag *)aParameters ;
- (void)GetPendingMessageByIDTagAsyncUsingParameters:(FAXCOM_x0020_Service_GetPendingMessageByIDTag *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetPendingMessagesCountUsingParameters:(FAXCOM_x0020_Service_GetPendingMessagesCount *)aParameters ;
- (void)GetPendingMessagesCountAsyncUsingParameters:(FAXCOM_x0020_Service_GetPendingMessagesCount *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetPendingMessagesUsingParameters:(FAXCOM_x0020_Service_GetPendingMessages *)aParameters ;
- (void)GetPendingMessagesAsyncUsingParameters:(FAXCOM_x0020_Service_GetPendingMessages *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetPendingMessagesExUsingParameters:(FAXCOM_x0020_Service_GetPendingMessagesEx *)aParameters ;
- (void)GetPendingMessagesExAsyncUsingParameters:(FAXCOM_x0020_Service_GetPendingMessagesEx *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetReceivedMessagesCountUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessagesCount *)aParameters ;
- (void)GetReceivedMessagesCountAsyncUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessagesCount *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetReceivedMessagesUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessages *)aParameters ;
- (void)GetReceivedMessagesAsyncUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessages *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetReceivedMessages2UsingParameters:(FAXCOM_x0020_Service_GetReceivedMessages2 *)aParameters ;
- (void)GetReceivedMessages2AsyncUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessages2 *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetReceivedMessages3UsingParameters:(FAXCOM_x0020_Service_GetReceivedMessages3 *)aParameters ;
- (void)GetReceivedMessages3AsyncUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessages3 *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetReceivedMessagesByIDsUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessagesByIDs *)aParameters ;
- (void)GetReceivedMessagesByIDsAsyncUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessagesByIDs *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetReceivedMessagesByIDs2UsingParameters:(FAXCOM_x0020_Service_GetReceivedMessagesByIDs2 *)aParameters ;
- (void)GetReceivedMessagesByIDs2AsyncUsingParameters:(FAXCOM_x0020_Service_GetReceivedMessagesByIDs2 *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)RemoveReceivedMessagesByIDsUsingParameters:(FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs *)aParameters ;
- (void)RemoveReceivedMessagesByIDsAsyncUsingParameters:(FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetMessageStatusesByUniqueIDsUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDs *)aParameters ;
- (void)GetMessageStatusesByUniqueIDsAsyncUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDs *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetMessageStatusesByMessageStatusQueriesUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueries *)aParameters ;
- (void)GetMessageStatusesByMessageStatusQueriesAsyncUsingParameters:(FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueries *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)NewFaxMessage2UsingParameters:(FAXCOM_x0020_Service_NewFaxMessage2 *)aParameters ;
- (void)NewFaxMessage2AsyncUsingParameters:(FAXCOM_x0020_Service_NewFaxMessage2 *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)ListPhonebooksUsingParameters:(FAXCOM_x0020_Service_ListPhonebooks *)aParameters ;
- (void)ListPhonebooksAsyncUsingParameters:(FAXCOM_x0020_Service_ListPhonebooks *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)UpdatePhonebookUsingParameters:(FAXCOM_x0020_Service_UpdatePhonebook *)aParameters ;
- (void)UpdatePhonebookAsyncUsingParameters:(FAXCOM_x0020_Service_UpdatePhonebook *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)SubmitForPreviewUsingParameters:(FAXCOM_x0020_Service_SubmitForPreview *)aParameters ;
- (void)SubmitForPreviewAsyncUsingParameters:(FAXCOM_x0020_Service_SubmitForPreview *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetPendingImageUsingParameters:(FAXCOM_x0020_Service_GetPendingImage *)aParameters ;
- (void)GetPendingImageAsyncUsingParameters:(FAXCOM_x0020_Service_GetPendingImage *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)ReleasePendingMessageUsingParameters:(FAXCOM_x0020_Service_ReleasePendingMessage *)aParameters ;
- (void)ReleasePendingMessageAsyncUsingParameters:(FAXCOM_x0020_Service_ReleasePendingMessage *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)CancelPendingMessageUsingParameters:(FAXCOM_x0020_Service_CancelPendingMessage *)aParameters ;
- (void)CancelPendingMessageAsyncUsingParameters:(FAXCOM_x0020_Service_CancelPendingMessage *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)LoginAndSendNewFaxMessageUsingParameters:(FAXCOM_x0020_Service_LoginAndSendNewFaxMessage *)aParameters ;
- (void)LoginAndSendNewFaxMessageAsyncUsingParameters:(FAXCOM_x0020_Service_LoginAndSendNewFaxMessage *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)SendNewFaxMessageUsingParameters:(FAXCOM_x0020_Service_SendNewFaxMessage *)aParameters ;
- (void)SendNewFaxMessageAsyncUsingParameters:(FAXCOM_x0020_Service_SendNewFaxMessage *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetPhonebookAddressesUsingParameters:(FAXCOM_x0020_Service_GetPhonebookAddresses *)aParameters ;
- (void)GetPhonebookAddressesAsyncUsingParameters:(FAXCOM_x0020_Service_GetPhonebookAddresses *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)NewPhonebookUsingParameters:(FAXCOM_x0020_Service_NewPhonebook *)aParameters ;
- (void)NewPhonebookAsyncUsingParameters:(FAXCOM_x0020_Service_NewPhonebook *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)NewAddressUsingParameters:(FAXCOM_x0020_Service_NewAddress *)aParameters ;
- (void)NewAddressAsyncUsingParameters:(FAXCOM_x0020_Service_NewAddress *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)AddAddressToGroupUsingParameters:(FAXCOM_x0020_Service_AddAddressToGroup *)aParameters ;
- (void)AddAddressToGroupAsyncUsingParameters:(FAXCOM_x0020_Service_AddAddressToGroup *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)ModifyAddressUsingParameters:(FAXCOM_x0020_Service_ModifyAddress *)aParameters ;
- (void)ModifyAddressAsyncUsingParameters:(FAXCOM_x0020_Service_ModifyAddress *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)ModifyAddressInGroupUsingParameters:(FAXCOM_x0020_Service_ModifyAddressInGroup *)aParameters ;
- (void)ModifyAddressInGroupAsyncUsingParameters:(FAXCOM_x0020_Service_ModifyAddressInGroup *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)DeleteAddressUsingParameters:(FAXCOM_x0020_Service_DeleteAddress *)aParameters ;
- (void)DeleteAddressAsyncUsingParameters:(FAXCOM_x0020_Service_DeleteAddress *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)DeleteAddressInGroupUsingParameters:(FAXCOM_x0020_Service_DeleteAddressInGroup *)aParameters ;
- (void)DeleteAddressInGroupAsyncUsingParameters:(FAXCOM_x0020_Service_DeleteAddressInGroup *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)NewGroupUsingParameters:(FAXCOM_x0020_Service_NewGroup *)aParameters ;
- (void)NewGroupAsyncUsingParameters:(FAXCOM_x0020_Service_NewGroup *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)ModifyGroupUsingParameters:(FAXCOM_x0020_Service_ModifyGroup *)aParameters ;
- (void)ModifyGroupAsyncUsingParameters:(FAXCOM_x0020_Service_ModifyGroup *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)ListPhonebookGroupsUsingParameters:(FAXCOM_x0020_Service_ListPhonebookGroups *)aParameters ;
- (void)ListPhonebookGroupsAsyncUsingParameters:(FAXCOM_x0020_Service_ListPhonebookGroups *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetGroupAddressesUsingParameters:(FAXCOM_x0020_Service_GetGroupAddresses *)aParameters ;
- (void)GetGroupAddressesAsyncUsingParameters:(FAXCOM_x0020_Service_GetGroupAddresses *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)DeletePhonebookUsingParameters:(FAXCOM_x0020_Service_DeletePhonebook *)aParameters ;
- (void)DeletePhonebookAsyncUsingParameters:(FAXCOM_x0020_Service_DeletePhonebook *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)DeleteGroupUsingParameters:(FAXCOM_x0020_Service_DeleteGroup *)aParameters ;
- (void)DeleteGroupAsyncUsingParameters:(FAXCOM_x0020_Service_DeleteGroup *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetCoverpageListUsingParameters:(FAXCOM_x0020_Service_GetCoverpageList *)aParameters ;
- (void)GetCoverpageListAsyncUsingParameters:(FAXCOM_x0020_Service_GetCoverpageList *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetSentImageUsingParameters:(FAXCOM_x0020_Service_GetSentImage *)aParameters ;
- (void)GetSentImageAsyncUsingParameters:(FAXCOM_x0020_Service_GetSentImage *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)NewFaxMessageFromUniqueIDUsingParameters:(FAXCOM_x0020_Service_NewFaxMessageFromUniqueID *)aParameters ;
- (void)NewFaxMessageFromUniqueIDAsyncUsingParameters:(FAXCOM_x0020_Service_NewFaxMessageFromUniqueID *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetFaxMessagePropertiesUsingParameters:(FAXCOM_x0020_Service_GetFaxMessageProperties *)aParameters ;
- (void)GetFaxMessagePropertiesAsyncUsingParameters:(FAXCOM_x0020_Service_GetFaxMessageProperties *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)SetFaxMessagePropertiesUsingParameters:(FAXCOM_x0020_Service_SetFaxMessageProperties *)aParameters ;
- (void)SetFaxMessagePropertiesAsyncUsingParameters:(FAXCOM_x0020_Service_SetFaxMessageProperties *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetAttachmentsUsingParameters:(FAXCOM_x0020_Service_GetAttachments *)aParameters ;
- (void)GetAttachmentsAsyncUsingParameters:(FAXCOM_x0020_Service_GetAttachments *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)GetAttachmentUsingParameters:(FAXCOM_x0020_Service_GetAttachment *)aParameters ;
- (void)GetAttachmentAsyncUsingParameters:(FAXCOM_x0020_Service_GetAttachment *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)RemoveAttachmentUsingParameters:(FAXCOM_x0020_Service_RemoveAttachment *)aParameters ;
- (void)RemoveAttachmentAsyncUsingParameters:(FAXCOM_x0020_Service_RemoveAttachment *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)ResendFailedFaxUsingParameters:(FAXCOM_x0020_Service_ResendFailedFax *)aParameters ;
- (void)ResendFailedFaxAsyncUsingParameters:(FAXCOM_x0020_Service_ResendFailedFax *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)ListSupportedFeaturesUsingParameters:(FAXCOM_x0020_Service_ListSupportedFeatures *)aParameters ;
- (void)ListSupportedFeaturesAsyncUsingParameters:(FAXCOM_x0020_Service_ListSupportedFeatures *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
- (FAXCOM_x0020_ServiceSoap12BindingResponse *)MarkAsReadByIDsUsingParameters:(FAXCOM_x0020_Service_MarkAsReadByIDs *)aParameters ;
- (void)MarkAsReadByIDsAsyncUsingParameters:(FAXCOM_x0020_Service_MarkAsReadByIDs *)aParameters  delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)responseDelegate;
@end
@interface FAXCOM_x0020_ServiceSoap12BindingOperation : NSOperation {
	FAXCOM_x0020_ServiceSoap12Binding *binding;
	FAXCOM_x0020_ServiceSoap12BindingResponse *response;
	id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) FAXCOM_x0020_ServiceSoap12Binding *binding;
@property (readonly) FAXCOM_x0020_ServiceSoap12BindingResponse *response;
@property (nonatomic, assign) id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_ShowThreadingModel : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_ShowThreadingModel * parameters;
}
@property (retain) FAXCOM_x0020_Service_ShowThreadingModel * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ShowThreadingModel *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_WebServiceVersion : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_WebServiceVersion * parameters;
}
@property (retain) FAXCOM_x0020_Service_WebServiceVersion * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_WebServiceVersion *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_SetLegacyMode : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_SetLegacyMode * parameters;
}
@property (retain) FAXCOM_x0020_Service_SetLegacyMode * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_SetLegacyMode *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetLegacyMode : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetLegacyMode * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetLegacyMode * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetLegacyMode *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_LogOn : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_LogOn * parameters;
}
@property (retain) FAXCOM_x0020_Service_LogOn * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_LogOn *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_ReleaseSession : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_ReleaseSession * parameters;
}
@property (retain) FAXCOM_x0020_Service_ReleaseSession * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ReleaseSession *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_SetSenderInformation : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_SetSenderInformation * parameters;
}
@property (retain) FAXCOM_x0020_Service_SetSenderInformation * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_SetSenderInformation *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_NewFaxMessage : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_NewFaxMessage * parameters;
}
@property (retain) FAXCOM_x0020_Service_NewFaxMessage * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_NewFaxMessage *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_AddRecipient : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_AddRecipient * parameters;
}
@property (retain) FAXCOM_x0020_Service_AddRecipient * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_AddRecipient *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_AddRecipientEx : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_AddRecipientEx * parameters;
}
@property (retain) FAXCOM_x0020_Service_AddRecipientEx * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_AddRecipientEx *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_SendFax : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_SendFax * parameters;
}
@property (retain) FAXCOM_x0020_Service_SendFax * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_SendFax *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetLastUniqueJobID : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetLastUniqueJobID * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetLastUniqueJobID * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetLastUniqueJobID *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_SaveFax : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_SaveFax * parameters;
}
@property (retain) FAXCOM_x0020_Service_SaveFax * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_SaveFax *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_AddAttachment : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_AddAttachment * parameters;
}
@property (retain) FAXCOM_x0020_Service_AddAttachment * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_AddAttachment *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_AddAttachmentByUNC : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_AddAttachmentByUNC * parameters;
}
@property (retain) FAXCOM_x0020_Service_AddAttachmentByUNC * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_AddAttachmentByUNC *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetMessageStatusByUniqueID : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetMessageStatusByUniqueID * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetMessageStatusByUniqueID * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetMessageStatusByUniqueID *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetMessageStatusByIDTag : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetMessageStatusByIDTag * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetMessageStatusByIDTag * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetMessageStatusByIDTag *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetMessageStatusesCount : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetMessageStatusesCount * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetMessageStatusesCount * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetMessageStatusesCount *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetMessageStatuses : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetMessageStatuses * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetMessageStatuses * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetMessageStatuses *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetMessageStatusesEx : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetMessageStatusesEx * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetMessageStatusesEx * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetMessageStatusesEx *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_RemoveMessageStatusbyUniqueID : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID * parameters;
}
@property (retain) FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetPendingMessageByUniqueID : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetPendingMessageByUniqueID * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetPendingMessageByUniqueID * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetPendingMessageByUniqueID *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetPendingMessageByIDTag : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetPendingMessageByIDTag * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetPendingMessageByIDTag * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetPendingMessageByIDTag *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetPendingMessagesCount : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetPendingMessagesCount * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetPendingMessagesCount * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetPendingMessagesCount *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetPendingMessages : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetPendingMessages * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetPendingMessages * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetPendingMessages *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetPendingMessagesEx : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetPendingMessagesEx * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetPendingMessagesEx * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetPendingMessagesEx *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetReceivedMessagesCount : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetReceivedMessagesCount * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetReceivedMessagesCount * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetReceivedMessagesCount *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetReceivedMessages : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetReceivedMessages * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetReceivedMessages * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetReceivedMessages *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetReceivedMessages2 : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetReceivedMessages2 * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetReceivedMessages2 * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetReceivedMessages2 *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetReceivedMessages3 : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetReceivedMessages3 * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetReceivedMessages3 * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetReceivedMessages3 *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetReceivedMessagesByIDs : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetReceivedMessagesByIDs * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetReceivedMessagesByIDs * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetReceivedMessagesByIDs *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetReceivedMessagesByIDs2 : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetReceivedMessagesByIDs2 * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetReceivedMessagesByIDs2 * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetReceivedMessagesByIDs2 *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_RemoveReceivedMessagesByIDs : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs * parameters;
}
@property (retain) FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetMessageStatusesByUniqueIDs : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDs * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDs * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetMessageStatusesByUniqueIDs *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetMessageStatusesByMessageStatusQueries : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueries * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueries * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetMessageStatusesByMessageStatusQueries *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_NewFaxMessage2 : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_NewFaxMessage2 * parameters;
}
@property (retain) FAXCOM_x0020_Service_NewFaxMessage2 * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_NewFaxMessage2 *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_ListPhonebooks : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_ListPhonebooks * parameters;
}
@property (retain) FAXCOM_x0020_Service_ListPhonebooks * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ListPhonebooks *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_UpdatePhonebook : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_UpdatePhonebook * parameters;
}
@property (retain) FAXCOM_x0020_Service_UpdatePhonebook * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_UpdatePhonebook *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_SubmitForPreview : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_SubmitForPreview * parameters;
}
@property (retain) FAXCOM_x0020_Service_SubmitForPreview * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_SubmitForPreview *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetPendingImage : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetPendingImage * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetPendingImage * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetPendingImage *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_ReleasePendingMessage : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_ReleasePendingMessage * parameters;
}
@property (retain) FAXCOM_x0020_Service_ReleasePendingMessage * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ReleasePendingMessage *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_CancelPendingMessage : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_CancelPendingMessage * parameters;
}
@property (retain) FAXCOM_x0020_Service_CancelPendingMessage * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_CancelPendingMessage *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_LoginAndSendNewFaxMessage : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_LoginAndSendNewFaxMessage * parameters;
}
@property (retain) FAXCOM_x0020_Service_LoginAndSendNewFaxMessage * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_LoginAndSendNewFaxMessage *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_SendNewFaxMessage : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_SendNewFaxMessage * parameters;
}
@property (retain) FAXCOM_x0020_Service_SendNewFaxMessage * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_SendNewFaxMessage *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetPhonebookAddresses : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetPhonebookAddresses * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetPhonebookAddresses * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetPhonebookAddresses *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_NewPhonebook : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_NewPhonebook * parameters;
}
@property (retain) FAXCOM_x0020_Service_NewPhonebook * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_NewPhonebook *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_NewAddress : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_NewAddress * parameters;
}
@property (retain) FAXCOM_x0020_Service_NewAddress * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_NewAddress *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_AddAddressToGroup : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_AddAddressToGroup * parameters;
}
@property (retain) FAXCOM_x0020_Service_AddAddressToGroup * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_AddAddressToGroup *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_ModifyAddress : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_ModifyAddress * parameters;
}
@property (retain) FAXCOM_x0020_Service_ModifyAddress * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ModifyAddress *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_ModifyAddressInGroup : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_ModifyAddressInGroup * parameters;
}
@property (retain) FAXCOM_x0020_Service_ModifyAddressInGroup * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ModifyAddressInGroup *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_DeleteAddress : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_DeleteAddress * parameters;
}
@property (retain) FAXCOM_x0020_Service_DeleteAddress * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_DeleteAddress *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_DeleteAddressInGroup : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_DeleteAddressInGroup * parameters;
}
@property (retain) FAXCOM_x0020_Service_DeleteAddressInGroup * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_DeleteAddressInGroup *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_NewGroup : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_NewGroup * parameters;
}
@property (retain) FAXCOM_x0020_Service_NewGroup * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_NewGroup *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_ModifyGroup : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_ModifyGroup * parameters;
}
@property (retain) FAXCOM_x0020_Service_ModifyGroup * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ModifyGroup *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_ListPhonebookGroups : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_ListPhonebookGroups * parameters;
}
@property (retain) FAXCOM_x0020_Service_ListPhonebookGroups * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ListPhonebookGroups *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetGroupAddresses : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetGroupAddresses * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetGroupAddresses * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetGroupAddresses *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_DeletePhonebook : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_DeletePhonebook * parameters;
}
@property (retain) FAXCOM_x0020_Service_DeletePhonebook * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_DeletePhonebook *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_DeleteGroup : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_DeleteGroup * parameters;
}
@property (retain) FAXCOM_x0020_Service_DeleteGroup * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_DeleteGroup *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetCoverpageList : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetCoverpageList * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetCoverpageList * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetCoverpageList *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetSentImage : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetSentImage * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetSentImage * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetSentImage *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_NewFaxMessageFromUniqueID : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_NewFaxMessageFromUniqueID * parameters;
}
@property (retain) FAXCOM_x0020_Service_NewFaxMessageFromUniqueID * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_NewFaxMessageFromUniqueID *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetFaxMessageProperties : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetFaxMessageProperties * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetFaxMessageProperties * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetFaxMessageProperties *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_SetFaxMessageProperties : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_SetFaxMessageProperties * parameters;
}
@property (retain) FAXCOM_x0020_Service_SetFaxMessageProperties * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_SetFaxMessageProperties *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetAttachments : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetAttachments * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetAttachments * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetAttachments *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_GetAttachment : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_GetAttachment * parameters;
}
@property (retain) FAXCOM_x0020_Service_GetAttachment * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_GetAttachment *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_RemoveAttachment : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_RemoveAttachment * parameters;
}
@property (retain) FAXCOM_x0020_Service_RemoveAttachment * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_RemoveAttachment *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_ResendFailedFax : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_ResendFailedFax * parameters;
}
@property (retain) FAXCOM_x0020_Service_ResendFailedFax * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ResendFailedFax *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_ListSupportedFeatures : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_ListSupportedFeatures * parameters;
}
@property (retain) FAXCOM_x0020_Service_ListSupportedFeatures * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_ListSupportedFeatures *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_MarkAsReadByIDs : FAXCOM_x0020_ServiceSoap12BindingOperation {
	FAXCOM_x0020_Service_MarkAsReadByIDs * parameters;
}
@property (retain) FAXCOM_x0020_Service_MarkAsReadByIDs * parameters;
- (id)initWithBinding:(FAXCOM_x0020_ServiceSoap12Binding *)aBinding delegate:(id<FAXCOM_x0020_ServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAXCOM_x0020_Service_MarkAsReadByIDs *)aParameters
;
@end
@interface FAXCOM_x0020_ServiceSoap12Binding_envelope : NSObject {
}
+ (FAXCOM_x0020_ServiceSoap12Binding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface FAXCOM_x0020_ServiceSoap12BindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
