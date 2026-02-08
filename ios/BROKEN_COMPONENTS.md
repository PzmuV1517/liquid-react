# Broken Native Components

This file tracks all native components in liquid-react that are known to be broken or have major rendering issues in React Native environments.

## List of Broken Components

- **NativeMaterialView**: React Native children do not render correctly inside this view. Use is not recommended until this issue is resolved.
- **NativeSegmentedControlView**: UIKit "Liquid Glass" rendering for this component is not reliable. The selection pill/highlight may not appear or may only show during interaction. This is a UIKit limitation when bridging to React Native. We are currently investigating the issue and exploring potential fixes, but for now this component should be mostly avoided in production apps until we can ensure consistent behavior across all platforms.

---

If you encounter additional broken components, please submit a pull request to add them to this list and describe the issue.
