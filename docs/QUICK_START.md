# Quick Start

## Before you start

You need macOS with Xcode 11+, a React Native project targeting iOS 13+, and CocoaPods. That's it.

## Setup

```bash
npm install liquid-react
cd ios && pod install
```

Rebuild your app after that. The native module won't link itself.

## First component

A working starting point using `NativeButton` inside a grouped container:

```jsx
import React from 'react';
import { SafeAreaView, StyleSheet } from 'react-native';
import { NativeGroupedContainer, NativeCardContainer, NativeButton } from 'liquid-react';

export default function App() {
  return (
    <SafeAreaView style={styles.container}>
      <NativeGroupedContainer insetGrouped={true} style={{ flex: 1 }}>
        <NativeCardContainer cornerRadius={12} style={styles.card}>
          <NativeButton
            title="Get Started"
            buttonStyle="filled"
            onPress={() => console.log('pressed')}
            style={{ width: '100%' }}
          />
        </NativeCardContainer>
      </NativeGroupedContainer>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#f2f2f7' },
  card: { margin: 16, padding: 16 },
});
```

`NativeMaterialView` looks like a natural wrapper here but children don't render inside it yet. Use `NativeGroupedContainer` or `NativeCardContainer` when you need a native background container.

## Common patterns

### Form with native controls

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

### Search bar

Note the prop names here — they don't follow standard React Native text input conventions:

```jsx
import { NativeSearchBar } from 'liquid-react';

function SearchScreen() {
  const [query, setQuery] = useState('');

  return (
    <NativeSearchBar
      placeholder="Search..."
      text={query}
      onTextChanged={(e) => setQuery(e.nativeEvent.text)}
      onSearchPressed={(e) => performSearch(e.nativeEvent.text)}
      onCancelPressed={() => setQuery('')}
      style={{ width: '100%' }}
    />
  );
}
```

It's `onTextChanged`, not `onChange` or `onChangeText`.

## Material types

```jsx
<NativeMaterialView material="systemUltraThinMaterial" style={{ height: 100 }} />
<NativeMaterialView material="systemThinMaterial" style={{ height: 100 }} />
<NativeMaterialView material="systemMaterial" style={{ height: 100 }} />
<NativeMaterialView material="systemThickMaterial" style={{ height: 100 }} />
<NativeMaterialView material="systemChromeMaterial" style={{ height: 100 }} />
```

Append `Light` or `Dark` to any material name to lock the appearance regardless of system settings.

## Button styles

```jsx
<NativeButton title="Filled" buttonStyle="filled" />
<NativeButton title="Tinted" buttonStyle="tinted" />
<NativeButton title="Gray" buttonStyle="gray" />
<NativeButton title="Bordered" buttonStyle="bordered" />
<NativeButton title="Plain" buttonStyle="plain" />
```

## Troubleshooting

**Module not found** — run `pod install` again and rebuild.

**Blur not showing** — check that the parent view has a non-zero frame. Also double-check your iOS deployment target is 13+.

**TypeScript errors** — install `@types/react` and `@types/react-native`.

**Build errors after updating** — clean and reinstall:

```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
npm run ios -- --reset-cache
```

## iOS version behavior

Components render using whatever UIKit does on that iOS version. iOS 13 through 25 uses that version's native look. iOS 26+ gives you Liquid Glass. Nothing gets polyfilled.

## Platform guard

This library is iOS only. If your project targets multiple platforms, guard the components:

```jsx
import { Platform, View } from 'react-native';
import { NativeMaterialView } from 'liquid-react';

function MyComponent() {
  if (Platform.OS !== 'ios') {
    return <View style={styles.fallback} />;
  }

  return (
    <NativeMaterialView
      material="systemMaterial"
      style={{ width: '100%', height: 200 }}
    />
  );
}
```

Or use platform-specific file extensions: `MyComponent.ios.tsx`, `MyComponent.android.tsx`.

## More reading

[API Reference](./API_REFERENCE.md) — all component props and types.

[Examples](./EXAMPLES.md) — complete working screen implementations.

[Architecture](./ARCHITECTURE.md) — how the bridge is structured.
