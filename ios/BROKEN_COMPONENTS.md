# Broken Native Components

This file tracks all native components in liquid-react that are known to be broken or have major rendering issues in React Native environments.

## List of Broken Components

- **NativeMaterialView**: React Native children do not render correctly inside this view. Do not use until fixed.
- **NativeSegmentedControlView**: UIKit "Liquid Glass" rendering is not reliable. The selection pill/highlight may not appear or may only show during interaction. This is a UIKit limitation when bridging to React Native.

---

If you encounter additional broken components, please add them to this list and describe the issue.
