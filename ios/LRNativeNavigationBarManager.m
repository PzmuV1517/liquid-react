#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LRNativeNavigationBarManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(title, NSString)
RCT_EXPORT_VIEW_PROPERTY(translucent, BOOL)

@end
