# Liquid-React

**Production-ready React Native iOS module exposing Apple's native UIKit Liquid Glass components**

## Introduction

**What is Liquid-React?**

Liquid-React is a React Native iOS-only module that provides direct access to Apple's native UIKit components, rendered using the same Liquid Glass pipeline Apple uses in its own apps. This is **not** a simulation or recreation—it's a thin declarative bridge to real UIKit views.

**Why choose Liquid-React?**

- ✅ **Real Native UIKit** - Uses `UIVisualEffectView`, `UIButton`, `UINavigationBar`, etc.
- ✅ **Public APIs Only** - 100% App Store safe
- ✅ **True Liquid Glass** - iOS controls all blur, vibrancy, depth, and motion
- ✅ **Zero Custom Rendering** - No Skia, no Metal, no shaders
- ✅ **iOS Minimum Version:** 13.0
- ✅ **Swift 5.0**

Unlike other "liquid glass" libraries that use blur effects or shaders to imitate the look, Liquid-React delegates **all visual rendering to iOS**.

## Installation

```bash
npm install liquid-react
# or
yarn add liquid-react
```

### iOS Setup

```bash
cd ios && pod install
```

## Usage

### Basic Material View

```jsx
import { NativeMaterialView, NativeButton } from 'liquid-react';

function App() {
  return (
    <NativeMaterialView 
      material="systemUltraThinMaterial"
      style={{ flex: 1, padding: 20 }}
    >
      <NativeButton 
        title="Continue" 
        buttonStyle="filled"
        onPress={() => console.log('Pressed')}
      />
    </NativeMaterialView>
  );
}
```

### Native Controls

```jsx
import { 
  NativeSwitch, 
  NativeSegmentedControl,
  NativeSearchBar 
} from 'liquid-react';

function ControlsExample() {
  const [enabled, setEnabled] = useState(false);
  const [selectedIndex, setSelectedIndex] = useState(0);
  const [searchText, setSearchText] = useState('');

  return (
    <>
      <NativeSwitch 
        value={enabled}
        onValueChange={(e) => setEnabled(e.nativeEvent.value)}
      />
      
      <NativeSegmentedControl
        segments={['First', 'Second', 'Third']}
        selectedIndex={selectedIndex}
        onValueChange={(e) => setSelectedIndex(e.nativeEvent.selectedIndex)}
      />
      
      <NativeSearchBar
        placeholder="Search..."
        text={searchText}
        onChangeText={(e) => setSearchText(e.nativeEvent.text)}
      />
    </>
  );
}
```

### Navigation and Toolbars

```jsx
import { 
  NativeNavigationBar,
  NativeToolbar,
  NativeTabBar 
} from 'liquid-react';

function NavigationExample() {
  return (
    <>
      <NativeNavigationBar 
        title="My App"
        translucent={true}
        style={{ width: '100%' }}
      />
      
      <NativeToolbar
        items={[
          { systemItem: 'add' },
          { systemItem: 'flexibleSpace' },
          { title: 'Custom' },
          { systemItem: 'flexibleSpace' },
          { systemItem: 'done' }
        ]}
        translucent={true}
      />
      
      <NativeTabBar
        items={[
          { title: 'Home', icon: 'house' },
          { title: 'Search', icon: 'magnifyingglass' },
          { title: 'Profile', icon: 'person' }
        ]}
        selectedIndex={0}
        onTabPress={(e) => console.log(e.nativeEvent.index)}
      />
    </>
  );
}
```

### Containers

```jsx
import { 
  NativeGroupedContainer,
  NativeCardContainer 
} from 'liquid-react';

function ContainerExample() {
  return (
    <NativeGroupedContainer insetGrouped={true}>
      <NativeCardContainer cornerRadius={12}>
        <Text>Card Content</Text>
      </NativeCardContainer>
    </NativeGroupedContainer>
  );
}
```

## Available Components

### Materials & Containers
- `NativeMaterialView` → `UIVisualEffectView`
- `NativeGroupedContainer` → `UIView` + system background
- `NativeCardContainer` → `UIView` with continuous corners

### Navigation & Structure
- `NativeNavigationBar` → `UINavigationBar`
- `NativeToolbar` → `UIToolbar`
- `NativeTabBar` → `UITabBar`

### Controls
- `NativeButton` → `UIButton`
- `NativeSwitch` → `UISwitch`
- `NativeSegmentedControl` → `UISegmentedControl`
- `NativeSearchBar` → `UISearchBar`

## Material Types

All UIKit system materials are supported:

```typescript
type MaterialType =
  | 'systemUltraThinMaterial'
  | 'systemThinMaterial'
  | 'systemMaterial'
  | 'systemThickMaterial'
  | 'systemChromeMaterial'
  | 'systemUltraThinMaterialLight'
  | 'systemThinMaterialLight'
  | 'systemMaterialLight'
  | 'systemThickMaterialLight'
  | 'systemChromeMaterialLight'
  | 'systemUltraThinMaterialDark'
  | 'systemThinMaterialDark'
  | 'systemMaterialDark'
  | 'systemThickMaterialDark'
  | 'systemChromeMaterialDark';
```

## Button Styles

```typescript
type ButtonStyle =
  | 'filled'      // Default filled button
  | 'gray'        // Gray background
  | 'tinted'      // Tinted background
  | 'plain'       // Plain text
  | 'bordered'    // Bordered outline
  | 'borderedTinted'     // Tinted border
  | 'borderedProminent'; // Prominent border
```

## Explicit Non-Goals

❌ Cross-platform support (iOS only)  
❌ Custom blur intensity  
❌ Private API usage  
❌ SwiftUI components  
❌ Custom animations  
❌ Pixel-perfect Control Center imitation  

## Known Limitations

1. **iOS renders everything** - Visual behavior varies across iOS versions
2. **Frame-based layout** - No Auto Layout (React Native uses frame layout)
3. **No Auto Layout constraints** - Parent must provide frame
4. **System-controlled colors** - Appearance changes with iOS theme
5. **No custom materials** - Only Apple's predefined materials

## App Store Compliance

✅ Uses only public APIs  
✅ No private frameworks  
✅ No runtime injection  
✅ No reverse-engineered behaviors  
✅ Safe for App Store submission  

## License

MIT

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md)

## Documentation

See [docs/](./docs/) for detailed architecture and API reference.

```
Make sure the component you are using supports the props you are passing, and refer to the documentation for more details on available props and their usage.

## Contributing
We welcome contributions to Liquid-React! We try to regularly update the library with new components Apple releases, but because we are also students, we might not always be able to keep up with the pace of Apple's updates. If you want to contribute, please check out our [contributing guidelines](CONTRIBUTING.md) for more information on how to get started.

##Notes
They said it can't be done. We proved them wrong.
