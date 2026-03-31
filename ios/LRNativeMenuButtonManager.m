#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LRNativeMenuButtonManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(icon, NSString)
RCT_EXPORT_VIEW_PROPERTY(tintColorHex, NSString)
RCT_EXPORT_VIEW_PROPERTY(menuItems, NSArray)
RCT_EXPORT_VIEW_PROPERTY(appearanceMode, NSString)
RCT_EXPORT_VIEW_PROPERTY(onMenuAction, RCTDirectEventBlock)

@end
