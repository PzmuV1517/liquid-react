#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LRNativeStackViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(axis, NSString)
RCT_EXPORT_VIEW_PROPERTY(spacing, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(alignment, NSString)
RCT_EXPORT_VIEW_PROPERTY(distribution, NSString)
RCT_EXPORT_VIEW_PROPERTY(appearanceMode, NSString)

@end
