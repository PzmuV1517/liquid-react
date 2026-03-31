#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LRNativeMaterialViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(material, NSString)
RCT_EXPORT_VIEW_PROPERTY(appearanceMode, NSString)
RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)

@end
