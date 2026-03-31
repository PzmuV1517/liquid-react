#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LRNativeToolbarManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(translucent, BOOL)
RCT_EXPORT_VIEW_PROPERTY(appearanceMode, NSString)
RCT_EXPORT_VIEW_PROPERTY(onToolbarButtonPress, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onToolbarMenuAction, RCTDirectEventBlock)

@end
