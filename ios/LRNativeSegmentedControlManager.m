#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LRNativeSegmentedControlManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(segments, NSArray)
RCT_EXPORT_VIEW_PROPERTY(selectedIndex, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(onValueChange, RCTBubblingEventBlock)

@end
