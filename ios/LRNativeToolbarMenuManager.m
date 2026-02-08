#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LRNativeToolbarMenuManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(icon, NSString)
RCT_EXPORT_VIEW_PROPERTY(title, NSString)
RCT_EXPORT_VIEW_PROPERTY(menuItems, NSArray)
RCT_EXPORT_VIEW_PROPERTY(disabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(onMenuAction, RCTBubblingEventBlock)

@end
