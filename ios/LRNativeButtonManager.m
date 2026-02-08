#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LRNativeButtonManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(title, NSString)
RCT_EXPORT_VIEW_PROPERTY(buttonStyle, NSString)
RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)

@end
