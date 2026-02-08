#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LRNativeTabBarManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(items, NSArray)
RCT_EXPORT_VIEW_PROPERTY(selectedIndex, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(translucent, BOOL)
RCT_EXPORT_VIEW_PROPERTY(onTabPress, RCTBubblingEventBlock)

@end
