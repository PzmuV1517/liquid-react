# Quick Start Guide

Get started with Liquid-React in 5 minutes.

## Prerequisites

- macOS with Xcode 11+
- React Native 0.65.0+
- iOS 13.0+ target
- CocoaPods installed

## Installation

### 1. Install Package

```bash
npm install liquid-react
# or
yarn add liquid-react
```

### 2. Install iOS Dependencies

```bash
cd ios
pod install
cd ..
```

### 3. Rebuild Your App

```bash
npm run ios
```

That's it! You're ready to use native iOS components.

## First Component

Create a simple app with a native material view and button:

```jsx
import React from 'react';
import { SafeAreaView, Text, StyleSheet } from 'react-native';
import { NativeMaterialView, NativeButton } from 'liquid-react';

export default function App() {
  return (
    <SafeAreaView style={styles.container}>
      <NativeMaterialView
        material="systemUltraThinMaterial"
        style={styles.material}
      >
        <Text style={styles.title}>Welcome to Liquid React</Text>
        <Text style={styles.subtitle}>
          Native iOS components in React Native
        </Text>

        <NativeButton
          title="Get Started"
          buttonStyle="filled"
          onPress={() => console.log('Button pressed!')}
          style={styles.button}
        />
      </NativeMaterialView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f2f2f7',
  },
  material: {
    margin: 20,
    padding: 24,
    borderRadius: 16,
    alignItems: 'center',
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    marginBottom: 8,
    color: '#000',
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    marginBottom: 24,
  },
  button: {
    width: '100%',
  },
});
```

## Common Patterns

### Material Background with Content

```jsx
<NativeMaterialView material="systemMaterial">
  {/* Your content here */}
</NativeMaterialView>
```

### Form with Native Controls

```jsx
import { NativeSwitch, NativeSegmentedControl } from 'liquid-react';

function SettingsForm() {
  const [enabled, setEnabled] = useState(false);
  const [theme, setTheme] = useState(0);

  return (
    <>
      <NativeSwitch
        value={enabled}
        onValueChange={(e) => setEnabled(e.nativeEvent.value)}
      />

      <NativeSegmentedControl
        segments={['Light', 'Dark', 'Auto']}
        selectedIndex={theme}
        onValueChange={(e) => setTheme(e.nativeEvent.selectedIndex)}
      />
    </>
  );
}
```

### Search Interface

```jsx
import { NativeSearchBar } from 'liquid-react';

function SearchScreen() {
  const [query, setQuery] = useState('');

  return (
    <NativeSearchBar
      placeholder="Search..."
      text={query}
      onChangeText={(e) => setQuery(e.nativeEvent.text)}
      onSearchPress={(e) => performSearch(e.nativeEvent.text)}
    />
  );
}
```

## Material Types

Try different blur intensities:

```jsx
// Lightest
<NativeMaterialView material="systemUltraThinMaterial" />

// Light
<NativeMaterialView material="systemThinMaterial" />

// Standard
<NativeMaterialView material="systemMaterial" />

// Heavy
<NativeMaterialView material="systemThickMaterial" />

// Heaviest
<NativeMaterialView material="systemChromeMaterial" />
```

## Button Styles

Experiment with different button styles:

```jsx
<NativeButton title="Filled" buttonStyle="filled" />
<NativeButton title="Tinted" buttonStyle="tinted" />
<NativeButton title="Gray" buttonStyle="gray" />
<NativeButton title="Bordered" buttonStyle="bordered" />
<NativeButton title="Plain" buttonStyle="plain" />
```

## Troubleshooting

### Module not found

```bash
cd ios && pod install
```

### TypeScript errors

```bash
npm install --save-dev @types/react @types/react-native
```

### Blur not appearing

Make sure:
- Parent has non-zero size
- iOS 13.0+ deployment target
- Running on device or simulator (not just TypeScript checks)

### Build errors

```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
npm run ios -- --reset-cache
```

## Next Steps

1. **[Examples](./EXAMPLES.md)** - See complete working examples
2. **[API Reference](./API_REFERENCE.md)** - Learn all component props
3. **[Architecture](./ARCHITECTURE.md)** - Understand how it works

## iOS-Only Notice

⚠️ Liquid-React is **iOS-only**. Android and web are not supported by design.

To handle platform-specific code:

```jsx
import { Platform } from 'react-native';
import { NativeMaterialView } from 'liquid-react';

function MyComponent() {
  if (Platform.OS !== 'ios') {
    <View style={styles.fallback}>
      <Text>Liquid-React is iOS-only</Text>
    </View>;
    return 0;
  }

  return <NativeMaterialView material="systemMaterial" />;
}
```

Or use React Native's platform-specific files:
- `MyComponent.ios.tsx` - iOS implementation with Liquid-React
- `MyComponent.android.tsx` - Android fallback
- `MyComponent.web.tsx` - Web fallback

## App Store Compliance

✅ Liquid-React uses only public APIs
✅ Safe for App Store submission
✅ No private frameworks or hacks

See [App Store Compliance](./APP_STORE_COMPLIANCE.md) for details.

## Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/liquid-react/issues)
- **Examples**: [docs/EXAMPLES.md](./EXAMPLES.md)
- **API Docs**: [docs/API_REFERENCE.md](./API_REFERENCE.md)

## What You Get

- ✅ Native UIKit components
- ✅ Real Liquid Glass rendering
- ✅ iOS-controlled visuals
- ✅ System animations
- ✅ App Store safe

## What You Don't Get

- ❌ Cross-platform support
- ❌ Custom blur tuning
- ❌ Pixel-perfect Control Center clone
- ❌ Private API access

**This is a thin bridge to UIKit, not a UI framework.**

---

**Happy building with native iOS components! 🎉**
