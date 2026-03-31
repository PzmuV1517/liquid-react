#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LRNativeSearchBarManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(placeholder, NSString)
RCT_EXPORT_VIEW_PROPERTY(text, NSString)
RCT_EXPORT_VIEW_PROPERTY(appearanceMode, NSString)
RCT_EXPORT_VIEW_PROPERTY(onTextChanged, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSearchPressed, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onCancelPressed, RCTDirectEventBlock)

@end
