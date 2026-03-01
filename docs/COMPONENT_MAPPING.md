# Component-to-UIKit Mapping Table

This table documents the **exact 1:1 mapping** between Liquid-React components and native UIKit classes.

## Complete Mapping

| React Component | Native Swift Class | UIKit Component | Purpose |
|----------------|-------------------|-----------------|---------|
| `NativeMaterialView` | `LRNativeMaterialViewManager` | `UIVisualEffectView` | System blur materials with vibrancy |
| `NativeButton` | `LRNativeButtonManager` | `UIButton` | Native buttons with system configurations |
| `NativeSwitch` | `LRNativeSwitchManager` | `UISwitch` | Toggle control (on/off) |
| `NativeSegmentedControl` | `LRNativeSegmentedControlManager` | `UISegmentedControl` | Segmented picker control |
| `NativeSearchBar` | `LRNativeSearchBarManager` | `UISearchBar` | Search input with cancel button |
| `NativeNavigationBar` | `LRNativeNavigationBarManager` | `UINavigationBar` | Top navigation bar |
| `NativeToolbar` | `LRNativeToolbarManager` | `UIToolbar` | Bottom toolbar with bar button items |
| `NativeTabBar` | `LRNativeTabBarManager` | `UITabBar` | Tab navigation bar |
| `NativeGroupedContainer` | `LRNativeGroupedContainerManager` | `UIView` | Container with system grouped background |
| `NativeCardContainer` | `LRNativeCardContainerManager` | `UIView` | Card with continuous corner radius |

## Implementation Patterns

### Pattern 1: Direct UIKit Wrapper (No Subclassing)

**Components:** `NativeButton`, `NativeSwitch`, `NativeSegmentedControl`, `NativeSearchBar`

```swift
class NativeButton: UIView {
    private var button: UIButton!  // Contains UIKit component
    
    @objc var title: NSString = "" {
        didSet { updateButton() }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = bounds  // Frame-based layout
    }
}
```

**Characteristics:**
- UIKit component is a child of wrapper view
- Props map to UIKit properties
- No custom drawing
- Frame-based layout

### Pattern 2: Effect View Container

**Components:** `NativeMaterialView`

```swift
class NativeMaterialView: UIView {
    private var effectView: UIVisualEffectView?
    private var contentView: UIView!
    
    @objc var material: NSString = "systemMaterial" {
        didSet { updateMaterial() }
    }
    
    private func updateMaterial() {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        effectView = UIVisualEffectView(effect: blurEffect)
    }
    
    override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
        contentView.insertSubview(subview, at: atIndex)
    }
}
```

**Characteristics:**
- Effect view as background
- Content view for React children
- System-controlled visual effects
- Child view management

### Pattern 3: System Background Container

**Components:** `NativeGroupedContainer`, `NativeCardContainer`

```swift
class NativeCardContainer: UIView {
    @objc var cornerRadius: CGFloat = 10.0 {
        didSet { updateAppearance() }
    }
    
    private func updateAppearance() {
        backgroundColor = .secondarySystemGroupedBackground
        layer.cornerRadius = cornerRadius
        layer.cornerCurve = .continuous  // Native corner curve
    }
}
```

**Characteristics:**
- System background colors
- Native corner curves
- Simple container pattern
- OS-controlled appearance

### Pattern 4: Navigation Components

**Components:** `NativeNavigationBar`, `NativeToolbar`, `NativeTabBar`

```swift
class NativeNavigationBar: UIView {
    private var navigationBar: UINavigationBar!
    private var navigationItem: UINavigationItem!
    
    private func updateAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationBar.standardAppearance = appearance
    }
}
```

**Characteristics:**
- Uses UIKit bar components
- System appearance API
- Translucent by default
- Standard iOS navigation patterns

## Props Mapping

### Material View Props → UIVisualEffectView

| React Prop | Swift Property | UIKit API |
|-----------|---------------|-----------|
| `material` | `material: NSString` | `UIBlurEffect.Style` |
| `onPress` | `onPress: RCTBubblingEventBlock` | `UITapGestureRecognizer` |

### Button Props → UIButton

| React Prop | Swift Property | UIKit API |
|-----------|---------------|-----------|
| `title` | `title: NSString` | `UIButton.Configuration.title` |
| `buttonStyle` | `buttonStyle: NSString` | `UIButton.Configuration.*` |
| `onPress` | `onPress: RCTBubblingEventBlock` | `UIButton.addTarget` |

### Switch Props → UISwitch

| React Prop | Swift Property | UIKit API |
|-----------|---------------|-----------|
| `value` | `value: Bool` | `UISwitch.isOn` |
| `onValueChange` | `onValueChange: RCTBubblingEventBlock` | `UISwitch.valueChanged` |

### Segmented Control Props → UISegmentedControl

| React Prop | Swift Property | UIKit API |
|-----------|---------------|-----------|
| `segments` | `segments: NSArray` | `UISegmentedControl.insertSegment` |
| `selectedIndex` | `selectedIndex: NSInteger` | `UISegmentedControl.selectedSegmentIndex` |
| `onValueChange` | `onValueChange: RCTBubblingEventBlock` | `UISegmentedControl.valueChanged` |

### Search Bar Props → UISearchBar

| React Prop | Swift Property | UIKit API |
|-----------|---------------|-----------|
| `placeholder` | `placeholder: NSString` | `UISearchBar.placeholder` |
| `text` | `text: NSString` | `UISearchBar.text` |
| `onChangeText` | `onChangeText: RCTBubblingEventBlock` | `UISearchBarDelegate.textDidChange` |
| `onSearchPress` | `onSearchPress: RCTBubblingEventBlock` | `UISearchBarDelegate.searchButtonClicked` |
| `onCancelPress` | `onCancelPress: RCTBubblingEventBlock` | `UISearchBarDelegate.cancelButtonClicked` |

## Public API Verification

Every component uses **only** public APIs:

### UIVisualEffectView (iOS 8.0+)
✅ Public API since iOS 8  
✅ Documented: [developer.apple.com/documentation/uikit/uivisualeffectview](https://developer.apple.com/documentation/uikit/uivisualeffectview)  
✅ System blur materials: iOS 13.0+  

### UIButton (iOS 2.0+)
✅ Public API since iOS 2  
✅ Configuration API: iOS 15.0+  
✅ Documented: [developer.apple.com/documentation/uikit/uibutton](https://developer.apple.com/documentation/uikit/uibutton)  

### UISwitch (iOS 2.0+)
✅ Public API since iOS 2  
✅ Documented: [developer.apple.com/documentation/uikit/uiswitch](https://developer.apple.com/documentation/uikit/uiswitch)  

### UISegmentedControl (iOS 2.0+)
✅ Public API since iOS 2  
✅ Documented: [developer.apple.com/documentation/uikit/uisegmentedcontrol](https://developer.apple.com/documentation/uikit/uisegmentedcontrol)  

### UISearchBar (iOS 2.0+)
✅ Public API since iOS 2  
✅ Documented: [developer.apple.com/documentation/uikit/uisearchbar](https://developer.apple.com/documentation/uikit/uisearchbar)  

### UINavigationBar (iOS 2.0+)
✅ Public API since iOS 2  
✅ Appearance API: iOS 13.0+  
✅ Documented: [developer.apple.com/documentation/uikit/uinavigationbar](https://developer.apple.com/documentation/uikit/uinavigationbar)  

### UIToolbar (iOS 2.0+)
✅ Public API since iOS 2  
✅ Documented: [developer.apple.com/documentation/uikit/uitoolbar](https://developer.apple.com/documentation/uikit/uitoolbar)  

### UITabBar (iOS 2.0+)
✅ Public API since iOS 2  
✅ Documented: [developer.apple.com/documentation/uikit/uitabbar](https://developer.apple.com/documentation/uikit/uitabbar)  

## What We Do NOT Use

### ❌ Private APIs (NEVER USED)

```swift
// NEVER USED - Would cause App Store rejection
import UIKitPrivate
_UIBackdropView
_UIVisualEffectHost
CABackdropLayer (private)
```

### ❌ Private Methods (NEVER CALLED)

```swift
// NEVER CALLED - Would cause App Store rejection
_setCornerRadius:
_setContinuousCornerRadius:
_setBackdropViewSettings:
```

### ❌ Runtime Hacks (NEVER APPLIED)

```swift
// NEVER APPLIED - Would cause App Store rejection
NSClassFromString("_UIBackdropView")
method_exchangeImplementations()
class_addMethod() for private classes
```

## Layout Philosophy

### Frame-Based (React Native)

```swift
override func layoutSubviews() {
    super.layoutSubviews()
    button.frame = bounds  // Direct frame assignment
}
```

✅ Compatible with React Native  
✅ Simple and predictable  
✅ No constraint conflicts  

### NOT Auto Layout

```swift
// NEVER USED
button.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([...])
```

❌ Not compatible with React Native layout  
❌ Would conflict with RN's frame updates  

## Animation Strategy

### Native UIKit Animations

```swift
UIView.animate(withDuration: 0.3) {
    self.alpha = 1.0
}
```

✅ System timing curves  
✅ Hardware accelerated  
✅ iOS-controlled motion  

### NOT Custom Animations

```swift
// NEVER USED
CABasicAnimation (manual)
Custom timing functions
JavaScript-driven animations
```

❌ Would override iOS defaults  
❌ Inconsistent with system  

## Event Flow

### JavaScript → Native (Props)

```
JavaScript                 Bridge                    Native
---------                 -------                   -------
<NativeButton       →     RCT_EXPORT_VIEW_      →   @objc var title
  title="Press" />        PROPERTY(title)               didSet { ... }
```

### Native → JavaScript (Events)

```
Native                    Bridge                    JavaScript
------                   -------                   ----------
@objc handlePress()  →   onPress?([...])       →   onPress={() => {}}
```

## File Structure

```
liquid-react/
├── src/
│   ├── types.ts                    # TypeScript type definitions
│   ├── nativeComponents.ts         # requireNativeComponent calls
│   ├── components.tsx              # React component wrappers
│   └── index.ts                    # Main exports
├── ios/
│   ├── LiquidReact-Bridging-Header.h           # ObjC bridge
│   ├── LRNativeMaterialViewManager.swift       # Material view
│   ├── LRNativeButtonManager.swift             # Button
│   ├── LRNativeSwitchManager.swift             # Switch
│   ├── LRNativeSegmentedControlManager.swift   # Segmented control
│   ├── LRNativeSearchBarManager.swift          # Search bar
│   ├── LRNativeNavigationBarManager.swift      # Navigation bar
│   ├── LRNativeToolbarManager.swift            # Toolbar
│   ├── LRNativeTabBarManager.swift             # Tab bar
│   ├── LRNativeGroupedContainerManager.swift   # Grouped container
│   └── LRNativeCardContainerManager.swift      # Card container
└── liquid-react.podspec            # CocoaPods spec
```

## Summary

- **10 Components** = **10 UIKit Classes**
- **100% Public APIs** = **100% App Store Safe**
- **Zero Custom Rendering** = **Zero Visual Overrides**
- **Frame Layout** = **React Native Compatible**
- **Native Events** = **Efficient Bridge**

This is a **thin declarative bridge**, not a UI framework.  
**Apple renders the UI. We simply expose it.**
