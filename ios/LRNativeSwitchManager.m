#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LRNativeSwitchManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(value, BOOL)
RCT_EXPORT_VIEW_PROPERTY(onTintColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(thumbTintColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(disabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(appearanceMode, NSString)
RCT_EXPORT_VIEW_PROPERTY(onValueChange, RCTBubblingEventBlock)

@end
