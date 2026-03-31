# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 1.1.0 - 2026-04-08 at 02:21 AM :3

### Added
- Added `LiquidReactAppearanceProvider` with global `mode` support.
- Added shared `AppearanceMode` values: `system`, `auto`, `light`, `dark`.
- Added optional `appearanceMode` prop to visual components:
  - `NativeMaterialView`
  - `NativeButton`
  - `NativeSwitch`
  - `NativeSegmentedControl`
  - `NativeSearchBar`
  - `NativeNavigationBar`
  - `NativeToolbar`
  - `NativeTabBar`
  - `NativeGroupedContainer`
  - `NativeCardContainer`
  - `NativeStackView`
  - `NativeMenuButton`

### Behavior
- `auto` keeps current UIKit adaptive behavior (default).
- `system` follows iOS system light/dark mode.
- `light` forces light mode.
- `dark` forces dark mode.
- Precedence: component `appearanceMode` overrides provider `mode`.

### Fixes
- Fixed React Native autolinking metadata

## [1.0.0] - 2026-02-08

### Initial Release 🎉

#### Components Added
- **Materials & Containers**
  - `NativeMaterialView` - UIVisualEffectView with 15 system blur materials
  - `NativeGroupedContainer` - System grouped background
  - `NativeCardContainer` - Cards with continuous corner radius

- **Controls**
  - `NativeButton` - UIButton with 7 system configurations
  - `NativeSwitch` - UISwitch toggle control
  - `NativeSegmentedControl` - UISegmentedControl picker
  - `NativeSearchBar` - UISearchBar with delegate events

- **Navigation**
  - `NativeNavigationBar` - UINavigationBar with translucency
  - `NativeToolbar` - UIToolbar with 24 system items
  - `NativeTabBar` - UITabBar with SF Symbols support

#### Features
- ✅ 100% public Apple APIs (App Store safe)
- ✅ Real native UIKit rendering (no simulation)
- ✅ TypeScript type definitions
- ✅ Frame-based layout (React Native compatible)
- ✅ Native event handling
- ✅ Child view hierarchy support
- ✅ iOS 13.0+ support
- ✅ Swift 5.0

#### Documentation
- Complete API reference for all components
- Architecture and implementation guide
- App Store compliance verification
- Component-to-UIKit mapping table
- Usage examples and patterns
- Quick start guide
- Project structure documentation

#### Package
- NPM package configuration
- CocoaPods podspec
- TypeScript configuration
- Proper peer dependencies
- Distribution files configured

### Non-Goals (By Design)
- ❌ No Android/Web support (iOS-only)
- ❌ No custom blur tuning (iOS controls visuals)
- ❌ No private APIs
- ❌ No Auto Layout (frame-based only)
- ❌ No pixel-perfect Control Center imitation

### Requirements
- iOS 13.0+
- Swift 5.0+
- React Native 0.65.0+
- Xcode 11+

---

## Future Releases

Future versions will maintain:
- Public API commitment
- Backward compatibility
- iOS-only focus
- No private frameworks

Potential additions (only if using public APIs):
- Additional UIKit components
- iOS version-specific features
- Performance optimizations
- Documentation improvements

---

[1.0.0]: https://github.com/yourusername/liquid-react/releases/tag/v1.0.0
