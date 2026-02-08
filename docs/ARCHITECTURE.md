# Architecture Overview

## Design Philosophy

Liquid-React is a **thin declarative bridge**, not a UI framework. Apple renders the UI; we simply expose it through React Native.

## Core Principles

1. **Delegate to iOS** - All visual rendering decisions made by UIKit
2. **Public APIs Only** - 100% App Store compliance
3. **No Simulation** - Real UIVisualEffectView, not custom blur
4. **Frame-Based Layout** - React Native's layout system (no Auto Layout)
5. **Minimal Bridge Traffic** - Efficient prop updates

## Architecture Layers

```
┌─────────────────────────────────────────┐
│         React JavaScript Layer          │
│   (components.tsx, types.ts)            │
└─────────────────┬───────────────────────┘
                  │
                  │ React Native Bridge
                  │
┌─────────────────▼───────────────────────┐
│       Native View Managers (Swift)      │
│   (LRNative*Manager.swift)              │
└─────────────────┬───────────────────────┘
                  │
                  │ Direct UIKit Calls
                  │
┌─────────────────▼───────────────────────┐
│          Apple UIKit Framework          │
│   UIVisualEffectView, UIButton, etc.    │
└─────────────────────────────────────────┘
```

## Component Structure

Each component follows this pattern:

### JavaScript Layer
```typescript
// src/components.tsx
export const NativeMaterialView: React.FC<Props> = (props) => {
  return <RNNativeMaterialView {...props} />;
};
```

### Native View Manager
```swift
// ios/LRNativeMaterialViewManager.swift
@objc(LRNativeMaterialViewManager)
class LRNativeMaterialViewManager: RCTViewManager {
    override func view() -> UIView! {
        return NativeMaterialView()
    }
}
```

### Native View Implementation
```swift
class NativeMaterialView: UIView {
    private var effectView: UIVisualEffectView?
    
    @objc var material: NSString = "systemMaterial" {
        didSet { updateMaterial() }
    }
    
    private func updateMaterial() {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        effectView = UIVisualEffectView(effect: blurEffect)
    }
}
```

### Objective-C Bridge
```objc
// ios/LiquidReact-Bridging-Header.h
@interface RCT_EXTERN_MODULE(LRNativeMaterialViewManager, RCTViewManager)
RCT_EXPORT_VIEW_PROPERTY(material, NSString)
@end
```

## Component-to-UIKit Mapping

| React Component | UIKit Component | Purpose |
|----------------|-----------------|---------|
| `NativeMaterialView` | `UIVisualEffectView` | System blur materials |
| `NativeButton` | `UIButton` | Native button with configurations |
| `NativeSwitch` | `UISwitch` | Toggle control |
| `NativeSegmentedControl` | `UISegmentedControl` | Segmented picker |
| `NativeSearchBar` | `UISearchBar` | Search input |
| `NativeNavigationBar` | `UINavigationBar` | Top navigation |
| `NativeToolbar` | `UIToolbar` | Bottom toolbar |
| `NativeTabBar` | `UITabBar` | Tab navigation |
| `NativeGroupedContainer` | `UIView` | Grouped background |
| `NativeCardContainer` | `UIView` | Card with corners |

## Layout System

### Frame-Based Layout
React Native uses frame-based layout (not Auto Layout):

```swift
override func layoutSubviews() {
    super.layoutSubviews()
    effectView?.frame = bounds
    contentView.frame = bounds
}
```

### Child View Hierarchy
```swift
override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
    contentView.insertSubview(subview, at: atIndex)
}

override func removeReactSubview(_ subview: UIView!) {
    subview.removeFromSuperview()
}
```

## Props & Events

### Props (JavaScript → Native)
```typescript
// Define in types.ts
export interface NativeMaterialViewProps extends ViewProps {
  material?: MaterialType;
  onPress?: BubblingEventHandler<{}>;
}

// Export in bridging header
RCT_EXPORT_VIEW_PROPERTY(material, NSString)
RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)

// Set in Swift
@objc var material: NSString = "systemMaterial" {
    didSet { updateMaterial() }
}
```

### Events (Native → JavaScript)
```swift
@objc var onPress: RCTBubblingEventBlock?

@objc private func handleTap() {
    onPress?([:]) // Empty payload
}

@objc private func handleValueChange() {
    onValueChange?(["value": switchControl.isOn]) // Data payload
}
```

## Material System

### System Materials
Liquid-React exposes all UIKit blur styles:

```swift
private func getBlurEffect(for material: String) -> UIBlurEffect {
    let style: UIBlurEffect.Style
    
    switch material {
    case "systemUltraThinMaterial":
        style = .systemUltraThinMaterial
    case "systemMaterial":
        style = .systemMaterial
    // ... all 15 system materials
    default:
        style = .systemMaterial
    }
    
    return UIBlurEffect(style: style)
}
```

### No Custom Tuning
❌ Cannot adjust blur intensity  
❌ Cannot customize vibrancy  
❌ Cannot override tint  

✅ iOS controls all visual properties  
✅ Adapts to system appearance  
✅ Respects accessibility settings  

## Animation Strategy

### UIKit Animations Only
```swift
UIView.animate(withDuration: 0.3) {
    self.alpha = 1.0
}
```

### Property Animators
```swift
let animator = UIViewPropertyAnimator(
    duration: 0.3,
    curve: .easeInOut
) {
    self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
}
animator.startAnimation()
```

### What We Don't Do
❌ JavaScript-driven animations  
❌ Custom timing curves  
❌ Manual Core Animation  
❌ Override UIKit defaults  

## Performance Optimizations

### View Reuse
```swift
private var effectView: UIVisualEffectView?

private func updateMaterial() {
    effectView?.removeFromSuperview() // Reuse or recreate
    effectView = UIVisualEffectView(effect: blurEffect)
}
```

### Minimal Re-renders
- Props update only when changed
- Frame calculations in `layoutSubviews()`
- Cached system effects where possible

### Bridge Efficiency
- Direct property setters
- Bubbling events only when needed
- No unnecessary serialization

## Threading

### Main Queue Setup
```swift
override static func requiresMainQueueSetup() -> Bool {
    return true // UIKit requires main thread
}
```

All UIKit operations run on main thread automatically.

## Debugging

### Enable React Native debugging
```bash
npm start -- --reset-cache
```

### Xcode debugging
- Set breakpoints in Swift view managers
- Use `po` to inspect UIKit views
- Check view hierarchy in Debug View Hierarchy

### Common Issues

**Blur not appearing:**
- Check material prop value
- Ensure parent has non-zero frame
- Verify iOS version (13.0+)

**Layout problems:**
- Check parent provides frame
- Verify `layoutSubviews()` implementation
- Use React Native Inspector

## Testing

### Unit Testing
Test JavaScript component exports:
```typescript
import { NativeMaterialView } from 'liquid-react';
expect(NativeMaterialView).toBeDefined();
```

### Integration Testing
Test on real iOS device:
- Visual inspection
- Different iOS versions
- Light/dark mode
- Accessibility settings

### No Snapshot Tests
Visual appearance controlled by iOS, not deterministic across versions.

## Extending the Module

### Adding New Components

1. **Create Swift View Manager**
```swift
@objc(LRNativeCustomViewManager)
class LRNativeCustomViewManager: RCTViewManager {
    override func view() -> UIView! {
        return NativeCustomView()
    }
}
```

2. **Implement Native View**
```swift
class NativeCustomView: UIView {
    // UIKit component integration
}
```

3. **Export to Objective-C**
```objc
@interface RCT_EXTERN_MODULE(LRNativeCustomViewManager, RCTViewManager)
RCT_EXPORT_VIEW_PROPERTY(customProp, NSString)
@end
```

4. **Create TypeScript Types**
```typescript
export interface NativeCustomViewProps extends ViewProps {
  customProp?: string;
}
```

5. **Register Component**
```typescript
export const RNNativeCustomView = 
  requireNativeComponent<NativeCustomViewProps>('LRNativeCustomView');
```

### Guidelines for New Components
- ✅ Must use public UIKit API
- ✅ Must delegate rendering to iOS
- ✅ Must use frame-based layout
- ✅ Props must map directly to UIKit properties
- ❌ No custom drawing
- ❌ No private APIs

## Version Compatibility

### Minimum Requirements
- iOS 13.0+
- Swift 5.0+
- React Native 0.65.0+

### iOS Version Differences
Different iOS versions render materials differently. This is **expected and correct**—iOS controls the visuals.

iOS 13: Initial Liquid Glass materials  
iOS 14: Enhanced vibrancy  
iOS 15: Refined blur algorithms  
iOS 16+: Continued refinements  

## Build Configuration

### CocoaPods Integration
```ruby
# liquid-react.podspec
s.platform     = :ios, "13.0"
s.source_files = "ios/**/*.{h,m,swift}"
s.dependency   'React-Core'
s.swift_version = "5.0"
```

### Xcode Project Settings
- Swift Compiler Language Version: Swift 5
- Deployment Target: iOS 13.0
- Enable Bitcode: No (React Native requirement)

## Memory Management

### ARC (Automatic Reference Counting)
All Swift code uses ARC—no manual memory management.

### View Lifecycle
```swift
deinit {
    // ARC handles cleanup automatically
    // No manual cleanup needed for UIKit views
}
```

### Avoiding Retain Cycles
Use `[weak self]` in closures when needed:
```swift
button.addAction(UIAction { [weak self] _ in
    self?.handlePress()
}, for: .touchUpInside)
```

## Documentation

- [README.md](../README.md) - User-facing documentation
- [EXAMPLES.md](./EXAMPLES.md) - Usage examples
- [ARCHITECTURE.md](./ARCHITECTURE.md) - This document
- [APP_STORE_COMPLIANCE.md](./APP_STORE_COMPLIANCE.md) - Legal compliance
