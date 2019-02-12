// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: google/cloud/speech/v1beta1/cloud_speech.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

 #import "CloudSpeech.pbobjc.h"
 #import "Annotations.pbobjc.h"
 #import "Operations.pbobjc.h"
 #import "Status.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"

#pragma mark - CloudSpeechRoot

@implementation CloudSpeechRoot

+ (GPBExtensionRegistry*)extensionRegistry {
  // This is called by +initialize so there is no need to worry
  // about thread safety and initialization of registry.
  static GPBExtensionRegistry* registry = nil;
  if (!registry) {
    GPBDebugCheckRuntimeVersion();
    registry = [[GPBExtensionRegistry alloc] init];
    [registry addExtensions:[AnnotationsRoot extensionRegistry]];
    [registry addExtensions:[OperationsRoot extensionRegistry]];
    [registry addExtensions:[StatusRoot extensionRegistry]];
  }
  return registry;
}

@end

#pragma mark - CloudSpeechRoot_FileDescriptor

static GPBFileDescriptor *CloudSpeechRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPBDebugCheckRuntimeVersion();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"google.cloud.speech.v1beta1"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - SyncRecognizeRequest

@implementation SyncRecognizeRequest

@dynamic hasConfig, config;
@dynamic hasAudio, audio;

typedef struct SyncRecognizeRequest__storage_ {
  uint32_t _has_storage_[1];
  RecognitionConfig *config;
  RecognitionAudio *audio;
} SyncRecognizeRequest__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "config",
        .dataTypeSpecific.className = GPBStringifySymbol(RecognitionConfig),
        .number = SyncRecognizeRequest_FieldNumber_Config,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(SyncRecognizeRequest__storage_, config),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "audio",
        .dataTypeSpecific.className = GPBStringifySymbol(RecognitionAudio),
        .number = SyncRecognizeRequest_FieldNumber_Audio,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(SyncRecognizeRequest__storage_, audio),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[SyncRecognizeRequest class]
                                     rootClass:[CloudSpeechRoot class]
                                          file:CloudSpeechRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(SyncRecognizeRequest__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - AsyncRecognizeRequest

@implementation AsyncRecognizeRequest

@dynamic hasConfig, config;
@dynamic hasAudio, audio;

typedef struct AsyncRecognizeRequest__storage_ {
  uint32_t _has_storage_[1];
  RecognitionConfig *config;
  RecognitionAudio *audio;
} AsyncRecognizeRequest__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "config",
        .dataTypeSpecific.className = GPBStringifySymbol(RecognitionConfig),
        .number = AsyncRecognizeRequest_FieldNumber_Config,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(AsyncRecognizeRequest__storage_, config),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "audio",
        .dataTypeSpecific.className = GPBStringifySymbol(RecognitionAudio),
        .number = AsyncRecognizeRequest_FieldNumber_Audio,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(AsyncRecognizeRequest__storage_, audio),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[AsyncRecognizeRequest class]
                                     rootClass:[CloudSpeechRoot class]
                                          file:CloudSpeechRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(AsyncRecognizeRequest__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - StreamingRecognizeRequest

@implementation StreamingRecognizeRequest

@dynamic streamingRequestOneOfCase;
@dynamic streamingConfig;
@dynamic audioContent;

typedef struct StreamingRecognizeRequest__storage_ {
  uint32_t _has_storage_[2];
  StreamingRecognitionConfig *streamingConfig;
  NSData *audioContent;
} StreamingRecognizeRequest__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "streamingConfig",
        .dataTypeSpecific.className = GPBStringifySymbol(StreamingRecognitionConfig),
        .number = StreamingRecognizeRequest_FieldNumber_StreamingConfig,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(StreamingRecognizeRequest__storage_, streamingConfig),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "audioContent",
        .dataTypeSpecific.className = NULL,
        .number = StreamingRecognizeRequest_FieldNumber_AudioContent,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(StreamingRecognizeRequest__storage_, audioContent),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBytes,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[StreamingRecognizeRequest class]
                                     rootClass:[CloudSpeechRoot class]
                                          file:CloudSpeechRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(StreamingRecognizeRequest__storage_)
                                         flags:0];
    static const char *oneofs[] = {
      "streamingRequest",
    };
    [localDescriptor setupOneofs:oneofs
                           count:(uint32_t)(sizeof(oneofs) / sizeof(char*))
                   firstHasIndex:-1];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

void StreamingRecognizeRequest_ClearStreamingRequestOneOfCase(StreamingRecognizeRequest *message) {
  GPBDescriptor *descriptor = [message descriptor];
  GPBOneofDescriptor *oneof = [descriptor.oneofs objectAtIndex:0];
  GPBMaybeClearOneof(message, oneof, -1, 0);
}
#pragma mark - StreamingRecognitionConfig

@implementation StreamingRecognitionConfig

@dynamic hasConfig, config;
@dynamic singleUtterance;
@dynamic interimResults;

typedef struct StreamingRecognitionConfig__storage_ {
  uint32_t _has_storage_[1];
  RecognitionConfig *config;
} StreamingRecognitionConfig__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "config",
        .dataTypeSpecific.className = GPBStringifySymbol(RecognitionConfig),
        .number = StreamingRecognitionConfig_FieldNumber_Config,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(StreamingRecognitionConfig__storage_, config),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "singleUtterance",
        .dataTypeSpecific.className = NULL,
        .number = StreamingRecognitionConfig_FieldNumber_SingleUtterance,
        .hasIndex = 1,
        .offset = 2,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "interimResults",
        .dataTypeSpecific.className = NULL,
        .number = StreamingRecognitionConfig_FieldNumber_InterimResults,
        .hasIndex = 3,
        .offset = 4,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[StreamingRecognitionConfig class]
                                     rootClass:[CloudSpeechRoot class]
                                          file:CloudSpeechRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(StreamingRecognitionConfig__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - RecognitionConfig

@implementation RecognitionConfig

@dynamic encoding;
@dynamic sampleRate;
@dynamic languageCode;
@dynamic maxAlternatives;
@dynamic profanityFilter;
@dynamic hasSpeechContext, speechContext;

typedef struct RecognitionConfig__storage_ {
  uint32_t _has_storage_[1];
  RecognitionConfig_AudioEncoding encoding;
  int32_t sampleRate;
  int32_t maxAlternatives;
  NSString *languageCode;
  SpeechContext *speechContext;
} RecognitionConfig__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "encoding",
        .dataTypeSpecific.enumDescFunc = RecognitionConfig_AudioEncoding_EnumDescriptor,
        .number = RecognitionConfig_FieldNumber_Encoding,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(RecognitionConfig__storage_, encoding),
        .flags = GPBFieldOptional | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "sampleRate",
        .dataTypeSpecific.className = NULL,
        .number = RecognitionConfig_FieldNumber_SampleRate,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(RecognitionConfig__storage_, sampleRate),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "languageCode",
        .dataTypeSpecific.className = NULL,
        .number = RecognitionConfig_FieldNumber_LanguageCode,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(RecognitionConfig__storage_, languageCode),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "maxAlternatives",
        .dataTypeSpecific.className = NULL,
        .number = RecognitionConfig_FieldNumber_MaxAlternatives,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(RecognitionConfig__storage_, maxAlternatives),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "profanityFilter",
        .dataTypeSpecific.className = NULL,
        .number = RecognitionConfig_FieldNumber_ProfanityFilter,
        .hasIndex = 4,
        .offset = 5,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "speechContext",
        .dataTypeSpecific.className = GPBStringifySymbol(SpeechContext),
        .number = RecognitionConfig_FieldNumber_SpeechContext,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(RecognitionConfig__storage_, speechContext),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[RecognitionConfig class]
                                     rootClass:[CloudSpeechRoot class]
                                          file:CloudSpeechRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(RecognitionConfig__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t RecognitionConfig_Encoding_RawValue(RecognitionConfig *message) {
  GPBDescriptor *descriptor = [RecognitionConfig descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:RecognitionConfig_FieldNumber_Encoding];
  return GPBGetMessageInt32Field(message, field);
}

void SetRecognitionConfig_Encoding_RawValue(RecognitionConfig *message, int32_t value) {
  GPBDescriptor *descriptor = [RecognitionConfig descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:RecognitionConfig_FieldNumber_Encoding];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - Enum RecognitionConfig_AudioEncoding

GPBEnumDescriptor *RecognitionConfig_AudioEncoding_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "EncodingUnspecified\000Linear16\000Flac\000Mulaw\000"
        "Amr\000AmrWb\000";
    static const int32_t values[] = {
        RecognitionConfig_AudioEncoding_EncodingUnspecified,
        RecognitionConfig_AudioEncoding_Linear16,
        RecognitionConfig_AudioEncoding_Flac,
        RecognitionConfig_AudioEncoding_Mulaw,
        RecognitionConfig_AudioEncoding_Amr,
        RecognitionConfig_AudioEncoding_AmrWb,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(RecognitionConfig_AudioEncoding)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:RecognitionConfig_AudioEncoding_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL RecognitionConfig_AudioEncoding_IsValidValue(int32_t value__) {
  switch (value__) {
    case RecognitionConfig_AudioEncoding_EncodingUnspecified:
    case RecognitionConfig_AudioEncoding_Linear16:
    case RecognitionConfig_AudioEncoding_Flac:
    case RecognitionConfig_AudioEncoding_Mulaw:
    case RecognitionConfig_AudioEncoding_Amr:
    case RecognitionConfig_AudioEncoding_AmrWb:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - SpeechContext

@implementation SpeechContext

@dynamic phrasesArray, phrasesArray_Count;

typedef struct SpeechContext__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *phrasesArray;
} SpeechContext__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "phrasesArray",
        .dataTypeSpecific.className = NULL,
        .number = SpeechContext_FieldNumber_PhrasesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(SpeechContext__storage_, phrasesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[SpeechContext class]
                                     rootClass:[CloudSpeechRoot class]
                                          file:CloudSpeechRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(SpeechContext__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - RecognitionAudio

@implementation RecognitionAudio

@dynamic audioSourceOneOfCase;
@dynamic content;
@dynamic uri;

typedef struct RecognitionAudio__storage_ {
  uint32_t _has_storage_[2];
  NSData *content;
  NSString *uri;
} RecognitionAudio__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "content",
        .dataTypeSpecific.className = NULL,
        .number = RecognitionAudio_FieldNumber_Content,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(RecognitionAudio__storage_, content),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBytes,
      },
      {
        .name = "uri",
        .dataTypeSpecific.className = NULL,
        .number = RecognitionAudio_FieldNumber_Uri,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(RecognitionAudio__storage_, uri),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[RecognitionAudio class]
                                     rootClass:[CloudSpeechRoot class]
                                          file:CloudSpeechRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(RecognitionAudio__storage_)
                                         flags:0];
    static const char *oneofs[] = {
      "audioSource",
    };
    [localDescriptor setupOneofs:oneofs
                           count:(uint32_t)(sizeof(oneofs) / sizeof(char*))
                   firstHasIndex:-1];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

void RecognitionAudio_ClearAudioSourceOneOfCase(RecognitionAudio *message) {
  GPBDescriptor *descriptor = [message descriptor];
  GPBOneofDescriptor *oneof = [descriptor.oneofs objectAtIndex:0];
  GPBMaybeClearOneof(message, oneof, -1, 0);
}
#pragma mark - SyncRecognizeResponse

@implementation SyncRecognizeResponse

@dynamic resultsArray, resultsArray_Count;

typedef struct SyncRecognizeResponse__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *resultsArray;
} SyncRecognizeResponse__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "resultsArray",
        .dataTypeSpecific.className = GPBStringifySymbol(SpeechRecognitionResult),
        .number = SyncRecognizeResponse_FieldNumber_ResultsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(SyncRecognizeResponse__storage_, resultsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[SyncRecognizeResponse class]
                                     rootClass:[CloudSpeechRoot class]
                                          file:CloudSpeechRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(SyncRecognizeResponse__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - AsyncRecognizeResponse

@implementation AsyncRecognizeResponse

@dynamic resultsArray, resultsArray_Count;

typedef struct AsyncRecognizeResponse__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *resultsArray;
} AsyncRecognizeResponse__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "resultsArray",
        .dataTypeSpecific.className = GPBStringifySymbol(SpeechRecognitionResult),
        .number = AsyncRecognizeResponse_FieldNumber_ResultsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(AsyncRecognizeResponse__storage_, resultsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[AsyncRecognizeResponse class]
                                     rootClass:[CloudSpeechRoot class]
                                          file:CloudSpeechRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(AsyncRecognizeResponse__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - StreamingRecognizeResponse

@implementation StreamingRecognizeResponse

@dynamic hasError, error;
@dynamic resultsArray, resultsArray_Count;
@dynamic resultIndex;
@dynamic endpointerType;

typedef struct StreamingRecognizeResponse__storage_ {
  uint32_t _has_storage_[1];
  int32_t resultIndex;
  StreamingRecognizeResponse_EndpointerType endpointerType;
  Status *error;
  NSMutableArray *resultsArray;
} StreamingRecognizeResponse__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "error",
        .dataTypeSpecific.className = GPBStringifySymbol(Status),
        .number = StreamingRecognizeResponse_FieldNumber_Error,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(StreamingRecognizeResponse__storage_, error),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "resultsArray",
        .dataTypeSpecific.className = GPBStringifySymbol(StreamingRecognitionResult),
        .number = StreamingRecognizeResponse_FieldNumber_ResultsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(StreamingRecognizeResponse__storage_, resultsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "resultIndex",
        .dataTypeSpecific.className = NULL,
        .number = StreamingRecognizeResponse_FieldNumber_ResultIndex,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(StreamingRecognizeResponse__storage_, resultIndex),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "endpointerType",
        .dataTypeSpecific.enumDescFunc = StreamingRecognizeResponse_EndpointerType_EnumDescriptor,
        .number = StreamingRecognizeResponse_FieldNumber_EndpointerType,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(StreamingRecognizeResponse__storage_, endpointerType),
        .flags = GPBFieldOptional | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[StreamingRecognizeResponse class]
                                     rootClass:[CloudSpeechRoot class]
                                          file:CloudSpeechRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(StreamingRecognizeResponse__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t StreamingRecognizeResponse_EndpointerType_RawValue(StreamingRecognizeResponse *message) {
  GPBDescriptor *descriptor = [StreamingRecognizeResponse descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:StreamingRecognizeResponse_FieldNumber_EndpointerType];
  return GPBGetMessageInt32Field(message, field);
}

void SetStreamingRecognizeResponse_EndpointerType_RawValue(StreamingRecognizeResponse *message, int32_t value) {
  GPBDescriptor *descriptor = [StreamingRecognizeResponse descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:StreamingRecognizeResponse_FieldNumber_EndpointerType];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - Enum StreamingRecognizeResponse_EndpointerType

GPBEnumDescriptor *StreamingRecognizeResponse_EndpointerType_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "EndpointerEventUnspecified\000StartOfSpeech"
        "\000EndOfSpeech\000EndOfAudio\000EndOfUtterance\000";
    static const int32_t values[] = {
        StreamingRecognizeResponse_EndpointerType_EndpointerEventUnspecified,
        StreamingRecognizeResponse_EndpointerType_StartOfSpeech,
        StreamingRecognizeResponse_EndpointerType_EndOfSpeech,
        StreamingRecognizeResponse_EndpointerType_EndOfAudio,
        StreamingRecognizeResponse_EndpointerType_EndOfUtterance,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(StreamingRecognizeResponse_EndpointerType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:StreamingRecognizeResponse_EndpointerType_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL StreamingRecognizeResponse_EndpointerType_IsValidValue(int32_t value__) {
  switch (value__) {
    case StreamingRecognizeResponse_EndpointerType_EndpointerEventUnspecified:
    case StreamingRecognizeResponse_EndpointerType_StartOfSpeech:
    case StreamingRecognizeResponse_EndpointerType_EndOfSpeech:
    case StreamingRecognizeResponse_EndpointerType_EndOfAudio:
    case StreamingRecognizeResponse_EndpointerType_EndOfUtterance:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - StreamingRecognitionResult

@implementation StreamingRecognitionResult

@dynamic alternativesArray, alternativesArray_Count;
@dynamic isFinal;
@dynamic stability;

typedef struct StreamingRecognitionResult__storage_ {
  uint32_t _has_storage_[1];
  float stability;
  NSMutableArray *alternativesArray;
} StreamingRecognitionResult__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "alternativesArray",
        .dataTypeSpecific.className = GPBStringifySymbol(SpeechRecognitionAlternative),
        .number = StreamingRecognitionResult_FieldNumber_AlternativesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(StreamingRecognitionResult__storage_, alternativesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "isFinal",
        .dataTypeSpecific.className = NULL,
        .number = StreamingRecognitionResult_FieldNumber_IsFinal,
        .hasIndex = 0,
        .offset = 1,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "stability",
        .dataTypeSpecific.className = NULL,
        .number = StreamingRecognitionResult_FieldNumber_Stability,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(StreamingRecognitionResult__storage_, stability),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeFloat,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[StreamingRecognitionResult class]
                                     rootClass:[CloudSpeechRoot class]
                                          file:CloudSpeechRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(StreamingRecognitionResult__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - SpeechRecognitionResult

@implementation SpeechRecognitionResult

@dynamic alternativesArray, alternativesArray_Count;

typedef struct SpeechRecognitionResult__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *alternativesArray;
} SpeechRecognitionResult__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "alternativesArray",
        .dataTypeSpecific.className = GPBStringifySymbol(SpeechRecognitionAlternative),
        .number = SpeechRecognitionResult_FieldNumber_AlternativesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(SpeechRecognitionResult__storage_, alternativesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[SpeechRecognitionResult class]
                                     rootClass:[CloudSpeechRoot class]
                                          file:CloudSpeechRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(SpeechRecognitionResult__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - SpeechRecognitionAlternative

@implementation SpeechRecognitionAlternative

@dynamic transcript;
@dynamic confidence;

typedef struct SpeechRecognitionAlternative__storage_ {
  uint32_t _has_storage_[1];
  float confidence;
  NSString *transcript;
} SpeechRecognitionAlternative__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "transcript",
        .dataTypeSpecific.className = NULL,
        .number = SpeechRecognitionAlternative_FieldNumber_Transcript,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(SpeechRecognitionAlternative__storage_, transcript),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "confidence",
        .dataTypeSpecific.className = NULL,
        .number = SpeechRecognitionAlternative_FieldNumber_Confidence,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(SpeechRecognitionAlternative__storage_, confidence),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeFloat,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[SpeechRecognitionAlternative class]
                                     rootClass:[CloudSpeechRoot class]
                                          file:CloudSpeechRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(SpeechRecognitionAlternative__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)