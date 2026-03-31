# Documentation

## Where to start

- [Quick Start](./QUICK_START.md)
- [Main README](../README.md)
- [Examples](./EXAMPLES.md)

## Reference

- [API Reference](./API_REFERENCE.md)
- [Architecture](./ARCHITECTURE.md)
- [Component Mapping](./COMPONENT_MAPPING.md)
- [Project Structure](./PROJECT_STRUCTURE.md)
- [App Store Compliance](./APP_STORE_COMPLIANCE.md)

## Overview

React Native iOS bindings for real UIKit components. iOS handles all rendering. The library is a thin bridge, not a UI framework. Everything uses public Apple APIs, so it's safe for App Store submission.

Visual components support `appearanceMode` (`auto`, `system`, `light`, `dark`) and can share a global default via `LiquidReactAppearanceProvider`.

## Component Guide

### Materials & Containers
- `NativeMaterialView` - UIVisualEffectView with system blur materials
- `NativeGroupedContainer` - System grouped background containers
- `NativeCardContainer` - Cards with continuous corner radius

### Controls
- `NativeButton` - UIButton with system configurations
- `NativeSwitch` - UISwitch toggle control
- `NativeSegmentedControl` - UISegmentedControl picker
- `NativeSearchBar` - UISearchBar for search input

### Navigation
- `NativeNavigationBar` - UINavigationBar for top navigation
- `NativeToolbar` - UIToolbar for bottom toolbars
- `NativeTabBar` - UITabBar for tab navigation

## Learning Path

1. **Start with [Quick Start](./QUICK_START.md)** - Get up and running in 5 minutes
2. **Browse [Examples](./EXAMPLES.md)** to see working code
3. **Review [API Reference](./API_REFERENCE.md)** for detailed prop documentation
4. **Read [Architecture](./ARCHITECTURE.md)** to understand how it works
5. **Check [App Store Compliance](./APP_STORE_COMPLIANCE.md)** before publishing
6. **Study [Component Mapping](./COMPONENT_MAPPING.md)** to see UIKit relationships

## Requirements

- iOS 13.0+
- Swift 5.0+
- React Native 0.65.0+
- Xcode 11+

## Installation

```bash
npm install liquid-react
cd ios && pod install
```

## Basic Usage

```jsx
import { NativeMaterialView, NativeButton } from 'liquid-react';

function App() {
  return (
    <NativeMaterialView material="systemUltraThinMaterial">
      <NativeButton 
        title="Continue" 
        buttonStyle="filled"
        onPress={() => console.log('Pressed')}
      />
    </NativeMaterialView>
  );
}
```

## Support

- **GitHub Issues**: [Report bugs or request features](https://github.com/yourusername/liquid-react/issues)
- **Discussions**: [Ask questions and share ideas](https://github.com/yourusername/liquid-react/discussions)

## Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) for development guidelines.

## License

MIT - See [LICENSE](../LICENSE)
