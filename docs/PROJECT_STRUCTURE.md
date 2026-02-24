# Project Structure

Complete file structure of the Liquid-React module.

```
liquid-react/
|
├── .github/                 # GitHub configuration files
│
├── 📦 Package Configuration
│   ├── package.json                 # NPM package configuration
│   ├── tsconfig.json                # TypeScript configuration
│   ├── liquid-react.podspec         # CocoaPods specification
│   ├── .gitignore                   # Git ignore rules
│   ├── .prettierrc                  # Code formatting rules
│   └── .prettierignore              # Prettier ignore rules
│
├── 📄 Documentation
│   ├── README.md                    # Main project documentation
│   ├── LICENSE                      # MIT license
│   ├── CONTRIBUTING.md              # Contribution guidelines
│   └── docs/
│       ├── README.md                # Documentation index
│       ├── EXAMPLES.md              # Usage examples
│       ├── API_REFERENCE.md         # Complete API documentation
│       ├── ARCHITECTURE.md          # Technical architecture
│       ├── APP_STORE_COMPLIANCE.md  # Legal compliance notes
│       └── COMPONENT_MAPPING.md     # UIKit mapping reference
│
├── 📱 JavaScript/TypeScript Layer
│   ├── index.js                     # Main entry point (re-exports from src/)
│   └── src/
│       ├── index.ts                 # Main exports
│       ├── types.ts                 # TypeScript type definitions
│       ├── nativeComponents.ts      # Native component registration
│       └── components.tsx           # React component wrappers
│
└── 🍎 Native iOS Layer
    └── ios/
        ├── LiquidReact-Bridging-Header.h             # Objective-C bridge
        │
        ├── 🌫️  Materials & Containers
        ├── LRNativeMaterialViewManager.swift         # UIVisualEffectView wrapper
        ├── LRNativeGroupedContainerManager.swift     # Grouped background container
        └── LRNativeCardContainerManager.swift        # Card container
        │
        ├── 🎛️  Controls
        ├── LRNativeButtonManager.swift               # UIButton wrapper
        ├── LRNativeSwitchManager.swift               # UISwitch wrapper
        ├── LRNativeSegmentedControlManager.swift     # UISegmentedControl wrapper
        └── LRNativeSearchBarManager.swift            # UISearchBar wrapper
        │
        └── 🧭 Navigation
            ├── LRNativeNavigationBarManager.swift    # UINavigationBar wrapper
            ├── LRNativeToolbarManager.swift          # UIToolbar wrapper
            └── LRNativeTabBarManager.swift           # UITabBar wrapper
```

## File Descriptions

### Package Configuration

**package.json**
- NPM package metadata
- Dependencies and peer dependencies
- Scripts for linting and testing
- Files to include in distribution

**tsconfig.json**
- TypeScript compiler options
- ES2019 target for React Native compatibility
- Declaration file generation

**liquid-react.podspec**
- CocoaPods specification
- iOS platform requirements (13.0+)
- Swift version (5.0)
- Source file patterns

### Documentation

**README.md**
- Installation instructions
- Quick start guide
- Component overview
- Material types reference
- Known limitations

**docs/API_REFERENCE.md**
- Complete prop documentation
- Event payloads
- Type definitions
- Layout guidelines

**docs/ARCHITECTURE.md**
- Design philosophy
- Component structure patterns
- Layout system explanation
- Performance optimizations

**docs/APP_STORE_COMPLIANCE.md**
- Public API verification
- Legal status confirmation
- Comparison with unsafe approaches
- Verification checklist

**docs/COMPONENT_MAPPING.md**
- 1:1 UIKit mapping table
- Implementation patterns
- Props mapping
- Public API verification

**docs/EXAMPLES.md**
- Complete app example
- Minimal examples
- Form example
- Testing guidelines

### JavaScript/TypeScript Layer

**src/types.ts**
- TypeScript interfaces for all components
- Material type definitions
- Button style enums
- Event payload types

**src/nativeComponents.ts**
- `requireNativeComponent` calls
- Registers native view managers
- Type-safe native component exports

**src/components.tsx**
- React component wrappers
- Default styles
- JSDoc documentation
- Child component support

**src/index.ts**
- Main entry point
- Re-exports all components
- Type exports

### Native iOS Layer

**LiquidReact-Bridging-Header.h**
- Objective-C to Swift bridge
- `RCT_EXTERN_MODULE` declarations
- `RCT_EXPORT_VIEW_PROPERTY` exports
- Connects Swift managers to React Native

**Material View Manager**
- Wraps `UIVisualEffectView`
- Supports all 15 system materials
- Handles child view hierarchy
- Tap gesture support

**Button Manager**
- Wraps `UIButton`
- Supports 7 button configurations
- Native press handling
- System animations

**Switch Manager**
- Wraps `UISwitch`
- Value change events
- Intrinsic size support

**Segmented Control Manager**
- Wraps `UISegmentedControl`
- Dynamic segment management
- Selection change events

**Search Bar Manager**
- Wraps `UISearchBar`
- Implements `UISearchBarDelegate`
- Text change, search, and cancel events

**Navigation Bar Manager**
- Wraps `UINavigationBar`
- Appearance API support
- Translucency control

**Toolbar Manager**
- Wraps `UIToolbar`
- System bar button items
- Flexible/fixed space support

**Tab Bar Manager**
- Wraps `UITabBar`
- System and custom tab items
- Selection change events
- SF Symbols icon support

**Container Managers**
- System background colors
- Continuous corner radius
- Child view support

## Build Artifacts (Not in Git)

```
liquid-react/
├── node_modules/          # NPM dependencies (gitignored)
├── lib/                   # Compiled TypeScript (gitignored)
├── ios/build/             # Xcode build output (gitignored)
└── ios/Pods/              # CocoaPods dependencies (gitignored)
```

## Distribution Files

When published to NPM, the package includes:

```
liquid-react/
├── src/                   # TypeScript source
├── ios/                   # Native Swift code
├── liquid-react.podspec   # CocoaPods spec
├── package.json           # Package metadata
├── README.md              # Documentation
└── LICENSE                # MIT license
```

## Development Workflow

### 1. Install Dependencies
```bash
npm install
cd ios && pod install
```

### 2. Link to Test App
```bash
cd ../your-react-native-app
npm link ../liquid-react
cd ios && pod install
```

### 3. Build Test App
```bash
npm run ios
```

### 4. Modify and Test
- Edit Swift files in `ios/`
- Edit TypeScript in `src/`
- Rebuild to see changes

## File Counts

- **TypeScript files:** 4
- **Swift files:** 10
- **Documentation files:** 6
- **Configuration files:** 4
- **Total source files:** 24

## Lines of Code (Approximate)

- **TypeScript:** ~800 lines
- **Swift:** ~1,500 lines
- **Documentation:** ~3,500 lines
- **Total:** ~5,800 lines

## Naming Conventions

### TypeScript
- Components: `NativeMaterialView` (PascalCase)
- Types: `MaterialType` (PascalCase)
- Props: `material` (camelCase)

### Swift
- Managers: `LRNativeMaterialViewManager` (PascalCase)
- Views: `NativeMaterialView` (PascalCase)
- Properties: `@objc var material` (camelCase)
- Methods: `updateMaterial()` (camelCase)

### Files
- Swift: `LRNative*Manager.swift`
- TypeScript: `*.ts` or `*.tsx`
- Docs: `*.md` (UPPERCASE)

## Module Prefix

All native classes use `LR` prefix (Liquid React):
- `LRNativeMaterialViewManager`
- `LRNativeButtonManager`
- etc.

This prevents naming conflicts with other native modules.

## Version Control

Tracked files:
- ✅ Source code (Swift, TypeScript)
- ✅ Configuration files
- ✅ Documentation
- ✅ Package manifests

Ignored files:
- ❌ Build artifacts
- ❌ Dependencies (node_modules, Pods)
- ❌ IDE-specific files
- ❌ OS-specific files (.DS_Store)

## See Also

- [Architecture](./ARCHITECTURE.md) - Technical implementation details
- [Component Mapping](./COMPONENT_MAPPING.md) - UIKit mapping reference
- [Contributing](../CONTRIBUTING.md) - Development guidelines
