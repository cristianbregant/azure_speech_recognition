#import "AzureSpeechRecognitionPlugin.h"
#if __has_include(<azure_speech_recognition/azure_speech_recognition-Swift.h>)
#import <azure_speech_recognition/azure_speech_recognition-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "azure_speech_recognition-Swift.h"
#endif

@implementation AzureSpeechRecognitionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAzureSpeechRecognitionPlugin registerWithRegistrar:registrar];
}
@end
