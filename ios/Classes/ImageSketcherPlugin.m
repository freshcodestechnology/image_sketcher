#import "ImageSketcherPlugin.h"
#if __has_include(<image_sketcher/image_sketcher-Swift.h>)
#import <image_sketcher/image_sketcher-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "image_sketcher-Swift.h"
#endif

@implementation ImageSketcherPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftImageSketcherPlugin registerWithRegistrar:registrar];
}
@end
