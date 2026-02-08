# Liquid-React Documentation

Complete documentation for the Liquid-React native iOS module.

## Quick Start

- **[Quick Start Guide](./QUICK_START.md)** - Get started in 5 minutes
- **[Main README](../README.md)** - Installation and basic usage
- **[Examples](./EXAMPLES.md)** - Complete code examples

## Technical Documentation

- **[API Reference](./API_REFERENCE.md)** - Complete API documentation for all components
- **[Architecture](./ARCHITECTURE.md)** - Technical architecture and implementation details
- **[Component Mapping](./COMPONENT_MAPPING.md)** - Complete UIKit mapping table
- **[Project Structure](./PROJECT_STRUCTURE.md)** - File structure and organization
- **[App Store Compliance](./APP_STORE_COMPLIANCE.md)** - Legal compliance and public API verification

## Overview

Liquid-React is a production-ready React Native iOS module that exposes Apple's native UIKit components using only public APIs. It provides authentic "Liquid Glass" rendering by delegating all visual decisions to iOS.

### Key Principles

1. **Public APIs Only** - 100% App Store safe
2. **Real Native UIKit** - No simulation or recreation
3. **iOS Controls Everything** - Blur, vibrancy, depth controlled by Apple
4. **Frame-Based Layout** - Compatible with React Native
5. **Minimal Bridge Traffic** - Efficient native integration

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
