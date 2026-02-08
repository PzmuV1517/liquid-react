#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LRNativeSearchBarManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(placeholder, NSString)
RCT_EXPORT_VIEW_PROPERTY(text, NSString)
RCT_EXPORT_VIEW_PROPERTY(onChangeText, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSearchPress, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onCancelPress, RCTBubblingEventBlock)

@end
