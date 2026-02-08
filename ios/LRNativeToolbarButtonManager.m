#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LRNativeToolbarButtonManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(icon, NSString)
RCT_EXPORT_VIEW_PROPERTY(title, NSString)
RCT_EXPORT_VIEW_PROPERTY(systemItem, NSString)
RCT_EXPORT_VIEW_PROPERTY(disabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)

@end
