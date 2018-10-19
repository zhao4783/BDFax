#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class FAWebServiceMain_LogIn;
@class FAWebServiceMain_LogInResponse;
@class FAWebServiceMain_ResultMessage;
@class FAWebServiceMain_ReleaseSession;
@class FAWebServiceMain_ReleaseSessionResponse;
@class FAWebServiceMain_SetSenderInformation;
@class FAWebServiceMain_SetSenderInformationResponse;
@class FAWebServiceMain_NewFaxMessageEx;
@class FAWebServiceMain_NewFaxMessageExResponse;
@class FAWebServiceMain_NewFaxMessage;
@class FAWebServiceMain_NewFaxMessageResponse;
@class FAWebServiceMain_AddRecipient;
@class FAWebServiceMain_AddRecipientResponse;
@class FAWebServiceMain_AddRecipientEx;
@class FAWebServiceMain_AddRecipientExResponse;
@class FAWebServiceMain_SendFax;
@class FAWebServiceMain_SendFaxResponse;
@class FAWebServiceMain_SendFaxEx;
@class FAWebServiceMain_SendFaxExResponse;
@class FAWebServiceMain_AddAttachment;
@class FAWebServiceMain_AddAttachmentResponse;
@class FAWebServiceMain_GetMessageStatusByUniqueID;
@class FAWebServiceMain_GetMessageStatusByUniqueIDResponse;
@class FAWebServiceMain_MessageStatus;
@class FAWebServiceMain_GetMessageStatusByUniqueIDEx;
@class FAWebServiceMain_GetMessageStatusByUniqueIDExResponse;
@class FAWebServiceMain_GetMessageStatusesCount;
@class FAWebServiceMain_GetMessageStatusesCountResponse;
@class FAWebServiceMain_GetMessageStatuses;
@class FAWebServiceMain_GetMessageStatusesResponse;
@class FAWebServiceMain_ArrayOfMessageStatus;
@class FAWebServiceMain_GetMessageStatusesEx;
@class FAWebServiceMain_GetMessageStatusesExResponse;
@class FAWebServiceMain_GetPendingMessageByUniqueID;
@class FAWebServiceMain_GetPendingMessageByUniqueIDResponse;
@class FAWebServiceMain_PendingMessage;
@class FAWebServiceMain_GetPendingMessagesCount;
@class FAWebServiceMain_GetPendingMessagesCountResponse;
@class FAWebServiceMain_GetActivityRecordsCount;
@class FAWebServiceMain_GetActivityRecordsCountResponse;
@class FAWebServiceMain_GetActivityRecords;
@class FAWebServiceMain_GetActivityRecordsResponse;
@class FAWebServiceMain_ArrayOfActivity;
@class FAWebServiceMain_Activity;
@class FAWebServiceMain_GetActivityRecordsEx;
@class FAWebServiceMain_GetActivityRecordsExResponse;
@class FAWebServiceMain_GetPendingMessages;
@class FAWebServiceMain_GetPendingMessagesResponse;
@class FAWebServiceMain_ArrayOfPendingMessage;
@class FAWebServiceMain_GetPendingMessagesEx;
@class FAWebServiceMain_GetPendingMessagesExResponse;
@class FAWebServiceMain_RemoveMessageStatusbyUniqueID;
@class FAWebServiceMain_RemoveMessageStatusbyUniqueIDResponse;
@class FAWebServiceMain_GetReceivedMessages;
@class FAWebServiceMain_GetReceivedMessagesResponse;
@class FAWebServiceMain_ArrayOfRxStatus;
@class FAWebServiceMain_RxStatus;
@class FAWebServiceMain_GetReceivedMessagesEx;
@class FAWebServiceMain_GetReceivedMessagesExResponse;
@class FAWebServiceMain_GetReceivedMessagesCount;
@class FAWebServiceMain_GetReceivedMessagesCountResponse;
@class FAWebServiceMain_RemoveReceivedMessagebyName;
@class FAWebServiceMain_RemoveReceivedMessagebyNameResponse;
@class FAWebServiceMain_GetTxStatusForJob;
@class FAWebServiceMain_GetTxStatusForJobResponse;
@class FAWebServiceMain_ArrayOfTxStatus;
@class FAWebServiceMain_TxStatus;
@interface FAWebServiceMain_LogIn : NSObject {
	
/* elements */
	NSString * userName;
	NSString * password;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_LogIn *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * userName;
@property (retain) NSString * password;
/* attributes */
- (NSDictionary *)attributes;
@end
typedef enum {
	FAWebServiceMain_LOGENTRYTYPE_none = 0,
	FAWebServiceMain_LOGENTRYTYPE_INFO,
	FAWebServiceMain_LOGENTRYTYPE_WARNING,
	FAWebServiceMain_LOGENTRYTYPE_ERROR,
} FAWebServiceMain_LOGENTRYTYPE;
FAWebServiceMain_LOGENTRYTYPE FAWebServiceMain_LOGENTRYTYPE_enumFromString(NSString *string);
NSString * FAWebServiceMain_LOGENTRYTYPE_stringFromEnum(FAWebServiceMain_LOGENTRYTYPE enumValue);
@interface FAWebServiceMain_ResultMessage : NSObject {
	
/* elements */
	USBoolean * Result;
	NSString * Detail;
	FAWebServiceMain_LOGENTRYTYPE Type;
	NSString * Data;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_ResultMessage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * Result;
@property (retain) NSString * Detail;
@property (assign) FAWebServiceMain_LOGENTRYTYPE Type;
@property (retain) NSString * Data;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_LogInResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ResultMessage * LogInResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_LogInResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ResultMessage * LogInResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_ReleaseSession : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_ReleaseSession *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_ReleaseSessionResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ResultMessage * ReleaseSessionResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_ReleaseSessionResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ResultMessage * ReleaseSessionResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_SetSenderInformation : NSObject {
	
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
+ (FAWebServiceMain_SetSenderInformation *)deserializeNode:(xmlNodePtr)cur;
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
@interface FAWebServiceMain_SetSenderInformationResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ResultMessage * SetSenderInformationResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_SetSenderInformationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ResultMessage * SetSenderInformationResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_NewFaxMessageEx : NSObject {
	
/* elements */
	NSNumber * priority;
	NSString * sendTimeGMT;
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
	NSString * tsi;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_NewFaxMessageEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * priority;
@property (retain) NSString * sendTimeGMT;
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
@property (retain) NSString * tsi;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_NewFaxMessageExResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ResultMessage * NewFaxMessageExResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_NewFaxMessageExResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ResultMessage * NewFaxMessageExResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_NewFaxMessage : NSObject {
	
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
+ (FAWebServiceMain_NewFaxMessage *)deserializeNode:(xmlNodePtr)cur;
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
@interface FAWebServiceMain_NewFaxMessageResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ResultMessage * NewFaxMessageResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_NewFaxMessageResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ResultMessage * NewFaxMessageResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_AddRecipient : NSObject {
	
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
+ (FAWebServiceMain_AddRecipient *)deserializeNode:(xmlNodePtr)cur;
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
@interface FAWebServiceMain_AddRecipientResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ResultMessage * AddRecipientResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_AddRecipientResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ResultMessage * AddRecipientResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_AddRecipientEx : NSObject {
	
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
+ (FAWebServiceMain_AddRecipientEx *)deserializeNode:(xmlNodePtr)cur;
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
@interface FAWebServiceMain_AddRecipientExResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ResultMessage * AddRecipientExResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_AddRecipientExResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ResultMessage * AddRecipientExResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_SendFax : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_SendFax *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_SendFaxResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ResultMessage * SendFaxResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_SendFaxResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ResultMessage * SendFaxResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_SendFaxEx : NSObject {
	
/* elements */
	NSString * idTag;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_SendFaxEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * idTag;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_SendFaxExResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ResultMessage * SendFaxExResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_SendFaxExResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ResultMessage * SendFaxExResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_AddAttachment : NSObject {
	
/* elements */
	NSString * attname;
	NSData * attachment;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_AddAttachment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * attname;
@property (retain) NSData * attachment;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_AddAttachmentResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ResultMessage * AddAttachmentResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_AddAttachmentResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ResultMessage * AddAttachmentResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetMessageStatusByUniqueID : NSObject {
	
/* elements */
	NSString * uniqueID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetMessageStatusByUniqueID *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * uniqueID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_MessageStatus : NSObject {
	
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
	NSNumber * Index;
	NSString * IDTag;
	NSNumber * AssignedID;
	NSString * UniqueJobID;
	USBoolean * IsSelected;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_MessageStatus *)deserializeNode:(xmlNodePtr)cur;
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
@property (retain) NSNumber * Index;
@property (retain) NSString * IDTag;
@property (retain) NSNumber * AssignedID;
@property (retain) NSString * UniqueJobID;
@property (retain) USBoolean * IsSelected;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetMessageStatusByUniqueIDResponse : NSObject {
	
/* elements */
	FAWebServiceMain_MessageStatus * GetMessageStatusByUniqueIDResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetMessageStatusByUniqueIDResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_MessageStatus * GetMessageStatusByUniqueIDResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetMessageStatusByUniqueIDEx : NSObject {
	
/* elements */
	NSString * uniqueID;
	NSNumber * recipientIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetMessageStatusByUniqueIDEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * uniqueID;
@property (retain) NSNumber * recipientIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetMessageStatusByUniqueIDExResponse : NSObject {
	
/* elements */
	FAWebServiceMain_MessageStatus * GetMessageStatusByUniqueIDExResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetMessageStatusByUniqueIDExResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_MessageStatus * GetMessageStatusByUniqueIDExResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetMessageStatusesCount : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetMessageStatusesCount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetMessageStatusesCountResponse : NSObject {
	
/* elements */
	NSNumber * GetMessageStatusesCountResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetMessageStatusesCountResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * GetMessageStatusesCountResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetMessageStatuses : NSObject {
	
/* elements */
	NSNumber * sortColumn;
	USBoolean * ascending;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetMessageStatuses *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * sortColumn;
@property (retain) USBoolean * ascending;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_ArrayOfMessageStatus : NSObject {
	
/* elements */
	NSMutableArray *MessageStatus;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_ArrayOfMessageStatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addMessageStatus:(FAWebServiceMain_MessageStatus *)toAdd;
@property (readonly) NSMutableArray * MessageStatus;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetMessageStatusesResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ArrayOfMessageStatus * GetMessageStatusesResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetMessageStatusesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ArrayOfMessageStatus * GetMessageStatusesResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetMessageStatusesEx : NSObject {
	
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
+ (FAWebServiceMain_GetMessageStatusesEx *)deserializeNode:(xmlNodePtr)cur;
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
@interface FAWebServiceMain_GetMessageStatusesExResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ArrayOfMessageStatus * GetMessageStatusesExResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetMessageStatusesExResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ArrayOfMessageStatus * GetMessageStatusesExResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetPendingMessageByUniqueID : NSObject {
	
/* elements */
	NSString * id_;
	NSNumber * recipientIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetPendingMessageByUniqueID *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * id_;
@property (retain) NSNumber * recipientIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
typedef enum {
	FAWebServiceMain_PRIORITY_none = 0,
	FAWebServiceMain_PRIORITY_LOW,
	FAWebServiceMain_PRIORITY_NORMAL,
	FAWebServiceMain_PRIORITY_HIGH,
	FAWebServiceMain_PRIORITY_URGENT,
} FAWebServiceMain_PRIORITY;
FAWebServiceMain_PRIORITY FAWebServiceMain_PRIORITY_enumFromString(NSString *string);
NSString * FAWebServiceMain_PRIORITY_stringFromEnum(FAWebServiceMain_PRIORITY enumValue);
@interface FAWebServiceMain_PendingMessage : NSObject {
	
/* elements */
	NSNumber * ID_;
	NSNumber * AssignedID;
	NSDate * DeliveryTime;
	NSNumber * Status;
	NSNumber * HoldValue;
	FAWebServiceMain_PRIORITY Priority;
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
+ (FAWebServiceMain_PendingMessage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * ID_;
@property (retain) NSNumber * AssignedID;
@property (retain) NSDate * DeliveryTime;
@property (retain) NSNumber * Status;
@property (retain) NSNumber * HoldValue;
@property (assign) FAWebServiceMain_PRIORITY Priority;
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
@interface FAWebServiceMain_GetPendingMessageByUniqueIDResponse : NSObject {
	
/* elements */
	FAWebServiceMain_PendingMessage * GetPendingMessageByUniqueIDResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetPendingMessageByUniqueIDResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_PendingMessage * GetPendingMessageByUniqueIDResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetPendingMessagesCount : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetPendingMessagesCount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetPendingMessagesCountResponse : NSObject {
	
/* elements */
	NSNumber * GetPendingMessagesCountResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetPendingMessagesCountResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * GetPendingMessagesCountResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetActivityRecordsCount : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetActivityRecordsCount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetActivityRecordsCountResponse : NSObject {
	
/* elements */
	NSNumber * GetActivityRecordsCountResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetActivityRecordsCountResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * GetActivityRecordsCountResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetActivityRecords : NSObject {
	
/* elements */
	NSNumber * sortColumn;
	USBoolean * ascending;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetActivityRecords *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * sortColumn;
@property (retain) USBoolean * ascending;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_Activity : NSObject {
	
/* elements */
	NSString * LastError;
	NSNumber * ID_;
	NSDate * DateTime;
	NSString * Type;
	NSNumber * Retries;
	NSString * FaxNumber;
	NSString * Sender;
	NSString * TransmissionStatus;
	NSString * StatusText;
	NSNumber * ConnectTime;
	NSNumber * TotalPages;
	NSNumber * TransferRate;
	USBoolean * FinalRetry;
	NSString * AuthorizeGroup;
	NSString * Authorizer;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_Activity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * LastError;
@property (retain) NSNumber * ID_;
@property (retain) NSDate * DateTime;
@property (retain) NSString * Type;
@property (retain) NSNumber * Retries;
@property (retain) NSString * FaxNumber;
@property (retain) NSString * Sender;
@property (retain) NSString * TransmissionStatus;
@property (retain) NSString * StatusText;
@property (retain) NSNumber * ConnectTime;
@property (retain) NSNumber * TotalPages;
@property (retain) NSNumber * TransferRate;
@property (retain) USBoolean * FinalRetry;
@property (retain) NSString * AuthorizeGroup;
@property (retain) NSString * Authorizer;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_ArrayOfActivity : NSObject {
	
/* elements */
	NSMutableArray *Activity;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_ArrayOfActivity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addActivity:(FAWebServiceMain_Activity *)toAdd;
@property (readonly) NSMutableArray * Activity;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetActivityRecordsResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ArrayOfActivity * GetActivityRecordsResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetActivityRecordsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ArrayOfActivity * GetActivityRecordsResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetActivityRecordsEx : NSObject {
	
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
+ (FAWebServiceMain_GetActivityRecordsEx *)deserializeNode:(xmlNodePtr)cur;
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
@interface FAWebServiceMain_GetActivityRecordsExResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ArrayOfActivity * GetActivityRecordsExResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetActivityRecordsExResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ArrayOfActivity * GetActivityRecordsExResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetPendingMessages : NSObject {
	
/* elements */
	NSNumber * sortColumn;
	USBoolean * ascending;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetPendingMessages *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * sortColumn;
@property (retain) USBoolean * ascending;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_ArrayOfPendingMessage : NSObject {
	
/* elements */
	NSMutableArray *PendingMessage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_ArrayOfPendingMessage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addPendingMessage:(FAWebServiceMain_PendingMessage *)toAdd;
@property (readonly) NSMutableArray * PendingMessage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetPendingMessagesResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ArrayOfPendingMessage * GetPendingMessagesResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetPendingMessagesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ArrayOfPendingMessage * GetPendingMessagesResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetPendingMessagesEx : NSObject {
	
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
+ (FAWebServiceMain_GetPendingMessagesEx *)deserializeNode:(xmlNodePtr)cur;
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
@interface FAWebServiceMain_GetPendingMessagesExResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ArrayOfPendingMessage * GetPendingMessagesExResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetPendingMessagesExResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ArrayOfPendingMessage * GetPendingMessagesExResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_RemoveMessageStatusbyUniqueID : NSObject {
	
/* elements */
	NSString * uniqueID;
	NSNumber * recipientIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_RemoveMessageStatusbyUniqueID *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * uniqueID;
@property (retain) NSNumber * recipientIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_RemoveMessageStatusbyUniqueIDResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ResultMessage * RemoveMessageStatusbyUniqueIDResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_RemoveMessageStatusbyUniqueIDResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ResultMessage * RemoveMessageStatusbyUniqueIDResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetReceivedMessages : NSObject {
	
/* elements */
	NSNumber * sortColumn;
	USBoolean * ascending;
	USBoolean * loadImage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetReceivedMessages *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * sortColumn;
@property (retain) USBoolean * ascending;
@property (retain) USBoolean * loadImage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_RxStatus : NSObject {
	
/* elements */
	NSString * ActualCallerID;
	NSNumber * BaudRate;
	NSString * CallerID;
	NSDate * CompletionTime;
	NSNumber * ConnectTime;
	NSString * DID;
	NSNumber * FileSize;
	NSNumber * ID_;
	NSNumber * NumberOfPages;
	NSDate * ReceiveTime;
	NSNumber * Status;
	NSString * StatusName;
	NSString * StatusText;
	NSString * TSI;
	NSData * Image;
	NSString * ImageFileName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_RxStatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * ActualCallerID;
@property (retain) NSNumber * BaudRate;
@property (retain) NSString * CallerID;
@property (retain) NSDate * CompletionTime;
@property (retain) NSNumber * ConnectTime;
@property (retain) NSString * DID;
@property (retain) NSNumber * FileSize;
@property (retain) NSNumber * ID_;
@property (retain) NSNumber * NumberOfPages;
@property (retain) NSDate * ReceiveTime;
@property (retain) NSNumber * Status;
@property (retain) NSString * StatusName;
@property (retain) NSString * StatusText;
@property (retain) NSString * TSI;
@property (retain) NSData * Image;
@property (retain) NSString * ImageFileName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_ArrayOfRxStatus : NSObject {
	
/* elements */
	NSMutableArray *RxStatus;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_ArrayOfRxStatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addRxStatus:(FAWebServiceMain_RxStatus *)toAdd;
@property (readonly) NSMutableArray * RxStatus;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetReceivedMessagesResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ArrayOfRxStatus * GetReceivedMessagesResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetReceivedMessagesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ArrayOfRxStatus * GetReceivedMessagesResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetReceivedMessagesEx : NSObject {
	
/* elements */
	NSNumber * sortColumn;
	USBoolean * ascending;
	NSNumber * start;
	NSNumber * count;
	USBoolean * loadImage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetReceivedMessagesEx *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * sortColumn;
@property (retain) USBoolean * ascending;
@property (retain) NSNumber * start;
@property (retain) NSNumber * count;
@property (retain) USBoolean * loadImage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetReceivedMessagesExResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ArrayOfRxStatus * GetReceivedMessagesExResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetReceivedMessagesExResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ArrayOfRxStatus * GetReceivedMessagesExResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetReceivedMessagesCount : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetReceivedMessagesCount *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetReceivedMessagesCountResponse : NSObject {
	
/* elements */
	NSNumber * GetReceivedMessagesCountResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetReceivedMessagesCountResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * GetReceivedMessagesCountResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_RemoveReceivedMessagebyName : NSObject {
	
/* elements */
	NSString * name;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_RemoveReceivedMessagebyName *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * name;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_RemoveReceivedMessagebyNameResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ResultMessage * RemoveReceivedMessagebyNameResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_RemoveReceivedMessagebyNameResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ResultMessage * RemoveReceivedMessagebyNameResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetTxStatusForJob : NSObject {
	
/* elements */
	NSString * uniqueJobID;
	NSNumber * recipientIndex;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetTxStatusForJob *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * uniqueJobID;
@property (retain) NSNumber * recipientIndex;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_TxStatus : NSObject {
	
/* elements */
	NSString * UniqueJobID;
	NSNumber * RecipientIndex;
	NSNumber * Attempt;
	NSString * ActionType;
	NSDate * ActionDate;
	NSString * ActionDescription;
	NSString * StatusValue;
	NSString * StatusDescription;
	NSString * StatusName;
	NSString * Csi;
	NSNumber * ConnectTime;
	NSNumber * Pages;
	NSString * DialedNumber;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_TxStatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * UniqueJobID;
@property (retain) NSNumber * RecipientIndex;
@property (retain) NSNumber * Attempt;
@property (retain) NSString * ActionType;
@property (retain) NSDate * ActionDate;
@property (retain) NSString * ActionDescription;
@property (retain) NSString * StatusValue;
@property (retain) NSString * StatusDescription;
@property (retain) NSString * StatusName;
@property (retain) NSString * Csi;
@property (retain) NSNumber * ConnectTime;
@property (retain) NSNumber * Pages;
@property (retain) NSString * DialedNumber;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_ArrayOfTxStatus : NSObject {
	
/* elements */
	NSMutableArray *TxStatus;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_ArrayOfTxStatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addTxStatus:(FAWebServiceMain_TxStatus *)toAdd;
@property (readonly) NSMutableArray * TxStatus;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface FAWebServiceMain_GetTxStatusForJobResponse : NSObject {
	
/* elements */
	FAWebServiceMain_ArrayOfTxStatus * GetTxStatusForJobResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (FAWebServiceMain_GetTxStatusForJobResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) FAWebServiceMain_ArrayOfTxStatus * GetTxStatusForJobResult;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "FAWebServiceMain.h"
@class FAWebServiceMainSoapBinding;
@class FAWebServiceMainSoap12Binding;
@interface FAWebServiceMain : NSObject {
	
}
+ (FAWebServiceMainSoapBinding *)FAWebServiceMainSoapBinding;
+ (FAWebServiceMainSoap12Binding *)FAWebServiceMainSoap12Binding;
@end
@class FAWebServiceMainSoapBindingResponse;
@class FAWebServiceMainSoapBindingOperation;
@protocol FAWebServiceMainSoapBindingResponseDelegate <NSObject>
- (void) operation:(FAWebServiceMainSoapBindingOperation *)operation completedWithResponse:(FAWebServiceMainSoapBindingResponse *)response;
@end
@interface FAWebServiceMainSoapBinding : NSObject <FAWebServiceMainSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(FAWebServiceMainSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (FAWebServiceMainSoapBindingResponse *)LogInUsingParameters:(FAWebServiceMain_LogIn *)aParameters ;
- (void)LogInAsyncUsingParameters:(FAWebServiceMain_LogIn *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)ReleaseSessionUsingParameters:(FAWebServiceMain_ReleaseSession *)aParameters ;
- (void)ReleaseSessionAsyncUsingParameters:(FAWebServiceMain_ReleaseSession *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)SetSenderInformationUsingParameters:(FAWebServiceMain_SetSenderInformation *)aParameters ;
- (void)SetSenderInformationAsyncUsingParameters:(FAWebServiceMain_SetSenderInformation *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)NewFaxMessageExUsingParameters:(FAWebServiceMain_NewFaxMessageEx *)aParameters ;
- (void)NewFaxMessageExAsyncUsingParameters:(FAWebServiceMain_NewFaxMessageEx *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)NewFaxMessageUsingParameters:(FAWebServiceMain_NewFaxMessage *)aParameters ;
- (void)NewFaxMessageAsyncUsingParameters:(FAWebServiceMain_NewFaxMessage *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)AddRecipientUsingParameters:(FAWebServiceMain_AddRecipient *)aParameters ;
- (void)AddRecipientAsyncUsingParameters:(FAWebServiceMain_AddRecipient *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)AddRecipientExUsingParameters:(FAWebServiceMain_AddRecipientEx *)aParameters ;
- (void)AddRecipientExAsyncUsingParameters:(FAWebServiceMain_AddRecipientEx *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)SendFaxUsingParameters:(FAWebServiceMain_SendFax *)aParameters ;
- (void)SendFaxAsyncUsingParameters:(FAWebServiceMain_SendFax *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)SendFaxExUsingParameters:(FAWebServiceMain_SendFaxEx *)aParameters ;
- (void)SendFaxExAsyncUsingParameters:(FAWebServiceMain_SendFaxEx *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)AddAttachmentUsingParameters:(FAWebServiceMain_AddAttachment *)aParameters ;
- (void)AddAttachmentAsyncUsingParameters:(FAWebServiceMain_AddAttachment *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetMessageStatusByUniqueIDUsingParameters:(FAWebServiceMain_GetMessageStatusByUniqueID *)aParameters ;
- (void)GetMessageStatusByUniqueIDAsyncUsingParameters:(FAWebServiceMain_GetMessageStatusByUniqueID *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetMessageStatusByUniqueIDExUsingParameters:(FAWebServiceMain_GetMessageStatusByUniqueIDEx *)aParameters ;
- (void)GetMessageStatusByUniqueIDExAsyncUsingParameters:(FAWebServiceMain_GetMessageStatusByUniqueIDEx *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetMessageStatusesCountUsingParameters:(FAWebServiceMain_GetMessageStatusesCount *)aParameters ;
- (void)GetMessageStatusesCountAsyncUsingParameters:(FAWebServiceMain_GetMessageStatusesCount *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetMessageStatusesUsingParameters:(FAWebServiceMain_GetMessageStatuses *)aParameters ;
- (void)GetMessageStatusesAsyncUsingParameters:(FAWebServiceMain_GetMessageStatuses *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetMessageStatusesExUsingParameters:(FAWebServiceMain_GetMessageStatusesEx *)aParameters ;
- (void)GetMessageStatusesExAsyncUsingParameters:(FAWebServiceMain_GetMessageStatusesEx *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetPendingMessageByUniqueIDUsingParameters:(FAWebServiceMain_GetPendingMessageByUniqueID *)aParameters ;
- (void)GetPendingMessageByUniqueIDAsyncUsingParameters:(FAWebServiceMain_GetPendingMessageByUniqueID *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetPendingMessagesCountUsingParameters:(FAWebServiceMain_GetPendingMessagesCount *)aParameters ;
- (void)GetPendingMessagesCountAsyncUsingParameters:(FAWebServiceMain_GetPendingMessagesCount *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetActivityRecordsCountUsingParameters:(FAWebServiceMain_GetActivityRecordsCount *)aParameters ;
- (void)GetActivityRecordsCountAsyncUsingParameters:(FAWebServiceMain_GetActivityRecordsCount *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetActivityRecordsUsingParameters:(FAWebServiceMain_GetActivityRecords *)aParameters ;
- (void)GetActivityRecordsAsyncUsingParameters:(FAWebServiceMain_GetActivityRecords *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetActivityRecordsExUsingParameters:(FAWebServiceMain_GetActivityRecordsEx *)aParameters ;
- (void)GetActivityRecordsExAsyncUsingParameters:(FAWebServiceMain_GetActivityRecordsEx *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetPendingMessagesUsingParameters:(FAWebServiceMain_GetPendingMessages *)aParameters ;
- (void)GetPendingMessagesAsyncUsingParameters:(FAWebServiceMain_GetPendingMessages *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetPendingMessagesExUsingParameters:(FAWebServiceMain_GetPendingMessagesEx *)aParameters ;
- (void)GetPendingMessagesExAsyncUsingParameters:(FAWebServiceMain_GetPendingMessagesEx *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)RemoveMessageStatusbyUniqueIDUsingParameters:(FAWebServiceMain_RemoveMessageStatusbyUniqueID *)aParameters ;
- (void)RemoveMessageStatusbyUniqueIDAsyncUsingParameters:(FAWebServiceMain_RemoveMessageStatusbyUniqueID *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetReceivedMessagesUsingParameters:(FAWebServiceMain_GetReceivedMessages *)aParameters ;
- (void)GetReceivedMessagesAsyncUsingParameters:(FAWebServiceMain_GetReceivedMessages *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetReceivedMessagesExUsingParameters:(FAWebServiceMain_GetReceivedMessagesEx *)aParameters ;
- (void)GetReceivedMessagesExAsyncUsingParameters:(FAWebServiceMain_GetReceivedMessagesEx *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetReceivedMessagesCountUsingParameters:(FAWebServiceMain_GetReceivedMessagesCount *)aParameters ;
- (void)GetReceivedMessagesCountAsyncUsingParameters:(FAWebServiceMain_GetReceivedMessagesCount *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)RemoveReceivedMessagebyNameUsingParameters:(FAWebServiceMain_RemoveReceivedMessagebyName *)aParameters ;
- (void)RemoveReceivedMessagebyNameAsyncUsingParameters:(FAWebServiceMain_RemoveReceivedMessagebyName *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoapBindingResponse *)GetTxStatusForJobUsingParameters:(FAWebServiceMain_GetTxStatusForJob *)aParameters ;
- (void)GetTxStatusForJobAsyncUsingParameters:(FAWebServiceMain_GetTxStatusForJob *)aParameters  delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)responseDelegate;
@end
@interface FAWebServiceMainSoapBindingOperation : NSOperation {
	FAWebServiceMainSoapBinding *binding;
	FAWebServiceMainSoapBindingResponse *response;
	id<FAWebServiceMainSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) FAWebServiceMainSoapBinding *binding;
@property (readonly) FAWebServiceMainSoapBindingResponse *response;
@property (nonatomic, assign) id<FAWebServiceMainSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate;
@end
@interface FAWebServiceMainSoapBinding_LogIn : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_LogIn * parameters;
}
@property (retain) FAWebServiceMain_LogIn * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_LogIn *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_ReleaseSession : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_ReleaseSession * parameters;
}
@property (retain) FAWebServiceMain_ReleaseSession * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_ReleaseSession *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_SetSenderInformation : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_SetSenderInformation * parameters;
}
@property (retain) FAWebServiceMain_SetSenderInformation * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_SetSenderInformation *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_NewFaxMessageEx : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_NewFaxMessageEx * parameters;
}
@property (retain) FAWebServiceMain_NewFaxMessageEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_NewFaxMessageEx *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_NewFaxMessage : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_NewFaxMessage * parameters;
}
@property (retain) FAWebServiceMain_NewFaxMessage * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_NewFaxMessage *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_AddRecipient : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_AddRecipient * parameters;
}
@property (retain) FAWebServiceMain_AddRecipient * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_AddRecipient *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_AddRecipientEx : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_AddRecipientEx * parameters;
}
@property (retain) FAWebServiceMain_AddRecipientEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_AddRecipientEx *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_SendFax : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_SendFax * parameters;
}
@property (retain) FAWebServiceMain_SendFax * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_SendFax *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_SendFaxEx : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_SendFaxEx * parameters;
}
@property (retain) FAWebServiceMain_SendFaxEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_SendFaxEx *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_AddAttachment : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_AddAttachment * parameters;
}
@property (retain) FAWebServiceMain_AddAttachment * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_AddAttachment *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetMessageStatusByUniqueID : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetMessageStatusByUniqueID * parameters;
}
@property (retain) FAWebServiceMain_GetMessageStatusByUniqueID * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetMessageStatusByUniqueID *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetMessageStatusByUniqueIDEx : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetMessageStatusByUniqueIDEx * parameters;
}
@property (retain) FAWebServiceMain_GetMessageStatusByUniqueIDEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetMessageStatusByUniqueIDEx *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetMessageStatusesCount : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetMessageStatusesCount * parameters;
}
@property (retain) FAWebServiceMain_GetMessageStatusesCount * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetMessageStatusesCount *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetMessageStatuses : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetMessageStatuses * parameters;
}
@property (retain) FAWebServiceMain_GetMessageStatuses * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetMessageStatuses *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetMessageStatusesEx : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetMessageStatusesEx * parameters;
}
@property (retain) FAWebServiceMain_GetMessageStatusesEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetMessageStatusesEx *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetPendingMessageByUniqueID : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetPendingMessageByUniqueID * parameters;
}
@property (retain) FAWebServiceMain_GetPendingMessageByUniqueID * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetPendingMessageByUniqueID *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetPendingMessagesCount : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetPendingMessagesCount * parameters;
}
@property (retain) FAWebServiceMain_GetPendingMessagesCount * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetPendingMessagesCount *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetActivityRecordsCount : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetActivityRecordsCount * parameters;
}
@property (retain) FAWebServiceMain_GetActivityRecordsCount * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetActivityRecordsCount *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetActivityRecords : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetActivityRecords * parameters;
}
@property (retain) FAWebServiceMain_GetActivityRecords * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetActivityRecords *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetActivityRecordsEx : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetActivityRecordsEx * parameters;
}
@property (retain) FAWebServiceMain_GetActivityRecordsEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetActivityRecordsEx *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetPendingMessages : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetPendingMessages * parameters;
}
@property (retain) FAWebServiceMain_GetPendingMessages * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetPendingMessages *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetPendingMessagesEx : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetPendingMessagesEx * parameters;
}
@property (retain) FAWebServiceMain_GetPendingMessagesEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetPendingMessagesEx *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_RemoveMessageStatusbyUniqueID : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_RemoveMessageStatusbyUniqueID * parameters;
}
@property (retain) FAWebServiceMain_RemoveMessageStatusbyUniqueID * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_RemoveMessageStatusbyUniqueID *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetReceivedMessages : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetReceivedMessages * parameters;
}
@property (retain) FAWebServiceMain_GetReceivedMessages * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetReceivedMessages *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetReceivedMessagesEx : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetReceivedMessagesEx * parameters;
}
@property (retain) FAWebServiceMain_GetReceivedMessagesEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetReceivedMessagesEx *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetReceivedMessagesCount : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetReceivedMessagesCount * parameters;
}
@property (retain) FAWebServiceMain_GetReceivedMessagesCount * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetReceivedMessagesCount *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_RemoveReceivedMessagebyName : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_RemoveReceivedMessagebyName * parameters;
}
@property (retain) FAWebServiceMain_RemoveReceivedMessagebyName * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_RemoveReceivedMessagebyName *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_GetTxStatusForJob : FAWebServiceMainSoapBindingOperation {
	FAWebServiceMain_GetTxStatusForJob * parameters;
}
@property (retain) FAWebServiceMain_GetTxStatusForJob * parameters;
- (id)initWithBinding:(FAWebServiceMainSoapBinding *)aBinding delegate:(id<FAWebServiceMainSoapBindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetTxStatusForJob *)aParameters
;
@end
@interface FAWebServiceMainSoapBinding_envelope : NSObject {
}
+ (FAWebServiceMainSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface FAWebServiceMainSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
@class FAWebServiceMainSoap12BindingResponse;
@class FAWebServiceMainSoap12BindingOperation;
@protocol FAWebServiceMainSoap12BindingResponseDelegate <NSObject>
- (void) operation:(FAWebServiceMainSoap12BindingOperation *)operation completedWithResponse:(FAWebServiceMainSoap12BindingResponse *)response;
@end
@interface FAWebServiceMainSoap12Binding : NSObject <FAWebServiceMainSoap12BindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(FAWebServiceMainSoap12BindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (FAWebServiceMainSoap12BindingResponse *)LogInUsingParameters:(FAWebServiceMain_LogIn *)aParameters ;
- (void)LogInAsyncUsingParameters:(FAWebServiceMain_LogIn *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)ReleaseSessionUsingParameters:(FAWebServiceMain_ReleaseSession *)aParameters ;
- (void)ReleaseSessionAsyncUsingParameters:(FAWebServiceMain_ReleaseSession *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)SetSenderInformationUsingParameters:(FAWebServiceMain_SetSenderInformation *)aParameters ;
- (void)SetSenderInformationAsyncUsingParameters:(FAWebServiceMain_SetSenderInformation *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)NewFaxMessageExUsingParameters:(FAWebServiceMain_NewFaxMessageEx *)aParameters ;
- (void)NewFaxMessageExAsyncUsingParameters:(FAWebServiceMain_NewFaxMessageEx *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)NewFaxMessageUsingParameters:(FAWebServiceMain_NewFaxMessage *)aParameters ;
- (void)NewFaxMessageAsyncUsingParameters:(FAWebServiceMain_NewFaxMessage *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)AddRecipientUsingParameters:(FAWebServiceMain_AddRecipient *)aParameters ;
- (void)AddRecipientAsyncUsingParameters:(FAWebServiceMain_AddRecipient *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)AddRecipientExUsingParameters:(FAWebServiceMain_AddRecipientEx *)aParameters ;
- (void)AddRecipientExAsyncUsingParameters:(FAWebServiceMain_AddRecipientEx *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)SendFaxUsingParameters:(FAWebServiceMain_SendFax *)aParameters ;
- (void)SendFaxAsyncUsingParameters:(FAWebServiceMain_SendFax *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)SendFaxExUsingParameters:(FAWebServiceMain_SendFaxEx *)aParameters ;
- (void)SendFaxExAsyncUsingParameters:(FAWebServiceMain_SendFaxEx *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)AddAttachmentUsingParameters:(FAWebServiceMain_AddAttachment *)aParameters ;
- (void)AddAttachmentAsyncUsingParameters:(FAWebServiceMain_AddAttachment *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetMessageStatusByUniqueIDUsingParameters:(FAWebServiceMain_GetMessageStatusByUniqueID *)aParameters ;
- (void)GetMessageStatusByUniqueIDAsyncUsingParameters:(FAWebServiceMain_GetMessageStatusByUniqueID *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetMessageStatusByUniqueIDExUsingParameters:(FAWebServiceMain_GetMessageStatusByUniqueIDEx *)aParameters ;
- (void)GetMessageStatusByUniqueIDExAsyncUsingParameters:(FAWebServiceMain_GetMessageStatusByUniqueIDEx *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetMessageStatusesCountUsingParameters:(FAWebServiceMain_GetMessageStatusesCount *)aParameters ;
- (void)GetMessageStatusesCountAsyncUsingParameters:(FAWebServiceMain_GetMessageStatusesCount *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetMessageStatusesUsingParameters:(FAWebServiceMain_GetMessageStatuses *)aParameters ;
- (void)GetMessageStatusesAsyncUsingParameters:(FAWebServiceMain_GetMessageStatuses *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetMessageStatusesExUsingParameters:(FAWebServiceMain_GetMessageStatusesEx *)aParameters ;
- (void)GetMessageStatusesExAsyncUsingParameters:(FAWebServiceMain_GetMessageStatusesEx *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetPendingMessageByUniqueIDUsingParameters:(FAWebServiceMain_GetPendingMessageByUniqueID *)aParameters ;
- (void)GetPendingMessageByUniqueIDAsyncUsingParameters:(FAWebServiceMain_GetPendingMessageByUniqueID *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetPendingMessagesCountUsingParameters:(FAWebServiceMain_GetPendingMessagesCount *)aParameters ;
- (void)GetPendingMessagesCountAsyncUsingParameters:(FAWebServiceMain_GetPendingMessagesCount *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetActivityRecordsCountUsingParameters:(FAWebServiceMain_GetActivityRecordsCount *)aParameters ;
- (void)GetActivityRecordsCountAsyncUsingParameters:(FAWebServiceMain_GetActivityRecordsCount *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetActivityRecordsUsingParameters:(FAWebServiceMain_GetActivityRecords *)aParameters ;
- (void)GetActivityRecordsAsyncUsingParameters:(FAWebServiceMain_GetActivityRecords *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetActivityRecordsExUsingParameters:(FAWebServiceMain_GetActivityRecordsEx *)aParameters ;
- (void)GetActivityRecordsExAsyncUsingParameters:(FAWebServiceMain_GetActivityRecordsEx *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetPendingMessagesUsingParameters:(FAWebServiceMain_GetPendingMessages *)aParameters ;
- (void)GetPendingMessagesAsyncUsingParameters:(FAWebServiceMain_GetPendingMessages *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetPendingMessagesExUsingParameters:(FAWebServiceMain_GetPendingMessagesEx *)aParameters ;
- (void)GetPendingMessagesExAsyncUsingParameters:(FAWebServiceMain_GetPendingMessagesEx *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)RemoveMessageStatusbyUniqueIDUsingParameters:(FAWebServiceMain_RemoveMessageStatusbyUniqueID *)aParameters ;
- (void)RemoveMessageStatusbyUniqueIDAsyncUsingParameters:(FAWebServiceMain_RemoveMessageStatusbyUniqueID *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetReceivedMessagesUsingParameters:(FAWebServiceMain_GetReceivedMessages *)aParameters ;
- (void)GetReceivedMessagesAsyncUsingParameters:(FAWebServiceMain_GetReceivedMessages *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetReceivedMessagesExUsingParameters:(FAWebServiceMain_GetReceivedMessagesEx *)aParameters ;
- (void)GetReceivedMessagesExAsyncUsingParameters:(FAWebServiceMain_GetReceivedMessagesEx *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetReceivedMessagesCountUsingParameters:(FAWebServiceMain_GetReceivedMessagesCount *)aParameters ;
- (void)GetReceivedMessagesCountAsyncUsingParameters:(FAWebServiceMain_GetReceivedMessagesCount *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)RemoveReceivedMessagebyNameUsingParameters:(FAWebServiceMain_RemoveReceivedMessagebyName *)aParameters ;
- (void)RemoveReceivedMessagebyNameAsyncUsingParameters:(FAWebServiceMain_RemoveReceivedMessagebyName *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
- (FAWebServiceMainSoap12BindingResponse *)GetTxStatusForJobUsingParameters:(FAWebServiceMain_GetTxStatusForJob *)aParameters ;
- (void)GetTxStatusForJobAsyncUsingParameters:(FAWebServiceMain_GetTxStatusForJob *)aParameters  delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)responseDelegate;
@end
@interface FAWebServiceMainSoap12BindingOperation : NSOperation {
	FAWebServiceMainSoap12Binding *binding;
	FAWebServiceMainSoap12BindingResponse *response;
	id<FAWebServiceMainSoap12BindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) FAWebServiceMainSoap12Binding *binding;
@property (readonly) FAWebServiceMainSoap12BindingResponse *response;
@property (nonatomic, assign) id<FAWebServiceMainSoap12BindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate;
@end
@interface FAWebServiceMainSoap12Binding_LogIn : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_LogIn * parameters;
}
@property (retain) FAWebServiceMain_LogIn * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_LogIn *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_ReleaseSession : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_ReleaseSession * parameters;
}
@property (retain) FAWebServiceMain_ReleaseSession * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_ReleaseSession *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_SetSenderInformation : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_SetSenderInformation * parameters;
}
@property (retain) FAWebServiceMain_SetSenderInformation * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_SetSenderInformation *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_NewFaxMessageEx : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_NewFaxMessageEx * parameters;
}
@property (retain) FAWebServiceMain_NewFaxMessageEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_NewFaxMessageEx *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_NewFaxMessage : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_NewFaxMessage * parameters;
}
@property (retain) FAWebServiceMain_NewFaxMessage * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_NewFaxMessage *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_AddRecipient : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_AddRecipient * parameters;
}
@property (retain) FAWebServiceMain_AddRecipient * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_AddRecipient *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_AddRecipientEx : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_AddRecipientEx * parameters;
}
@property (retain) FAWebServiceMain_AddRecipientEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_AddRecipientEx *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_SendFax : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_SendFax * parameters;
}
@property (retain) FAWebServiceMain_SendFax * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_SendFax *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_SendFaxEx : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_SendFaxEx * parameters;
}
@property (retain) FAWebServiceMain_SendFaxEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_SendFaxEx *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_AddAttachment : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_AddAttachment * parameters;
}
@property (retain) FAWebServiceMain_AddAttachment * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_AddAttachment *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetMessageStatusByUniqueID : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetMessageStatusByUniqueID * parameters;
}
@property (retain) FAWebServiceMain_GetMessageStatusByUniqueID * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetMessageStatusByUniqueID *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetMessageStatusByUniqueIDEx : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetMessageStatusByUniqueIDEx * parameters;
}
@property (retain) FAWebServiceMain_GetMessageStatusByUniqueIDEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetMessageStatusByUniqueIDEx *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetMessageStatusesCount : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetMessageStatusesCount * parameters;
}
@property (retain) FAWebServiceMain_GetMessageStatusesCount * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetMessageStatusesCount *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetMessageStatuses : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetMessageStatuses * parameters;
}
@property (retain) FAWebServiceMain_GetMessageStatuses * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetMessageStatuses *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetMessageStatusesEx : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetMessageStatusesEx * parameters;
}
@property (retain) FAWebServiceMain_GetMessageStatusesEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetMessageStatusesEx *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetPendingMessageByUniqueID : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetPendingMessageByUniqueID * parameters;
}
@property (retain) FAWebServiceMain_GetPendingMessageByUniqueID * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetPendingMessageByUniqueID *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetPendingMessagesCount : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetPendingMessagesCount * parameters;
}
@property (retain) FAWebServiceMain_GetPendingMessagesCount * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetPendingMessagesCount *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetActivityRecordsCount : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetActivityRecordsCount * parameters;
}
@property (retain) FAWebServiceMain_GetActivityRecordsCount * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetActivityRecordsCount *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetActivityRecords : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetActivityRecords * parameters;
}
@property (retain) FAWebServiceMain_GetActivityRecords * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetActivityRecords *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetActivityRecordsEx : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetActivityRecordsEx * parameters;
}
@property (retain) FAWebServiceMain_GetActivityRecordsEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetActivityRecordsEx *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetPendingMessages : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetPendingMessages * parameters;
}
@property (retain) FAWebServiceMain_GetPendingMessages * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetPendingMessages *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetPendingMessagesEx : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetPendingMessagesEx * parameters;
}
@property (retain) FAWebServiceMain_GetPendingMessagesEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetPendingMessagesEx *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_RemoveMessageStatusbyUniqueID : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_RemoveMessageStatusbyUniqueID * parameters;
}
@property (retain) FAWebServiceMain_RemoveMessageStatusbyUniqueID * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_RemoveMessageStatusbyUniqueID *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetReceivedMessages : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetReceivedMessages * parameters;
}
@property (retain) FAWebServiceMain_GetReceivedMessages * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetReceivedMessages *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetReceivedMessagesEx : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetReceivedMessagesEx * parameters;
}
@property (retain) FAWebServiceMain_GetReceivedMessagesEx * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetReceivedMessagesEx *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetReceivedMessagesCount : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetReceivedMessagesCount * parameters;
}
@property (retain) FAWebServiceMain_GetReceivedMessagesCount * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetReceivedMessagesCount *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_RemoveReceivedMessagebyName : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_RemoveReceivedMessagebyName * parameters;
}
@property (retain) FAWebServiceMain_RemoveReceivedMessagebyName * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_RemoveReceivedMessagebyName *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_GetTxStatusForJob : FAWebServiceMainSoap12BindingOperation {
	FAWebServiceMain_GetTxStatusForJob * parameters;
}
@property (retain) FAWebServiceMain_GetTxStatusForJob * parameters;
- (id)initWithBinding:(FAWebServiceMainSoap12Binding *)aBinding delegate:(id<FAWebServiceMainSoap12BindingResponseDelegate>)aDelegate
	parameters:(FAWebServiceMain_GetTxStatusForJob *)aParameters
;
@end
@interface FAWebServiceMainSoap12Binding_envelope : NSObject {
}
+ (FAWebServiceMainSoap12Binding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface FAWebServiceMainSoap12BindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
