# Examples

This page contains comprehensive examples of using Liquid-React components.

## Complete App Example

```jsx
import React, { useState } from 'react';
import { View, Text, StyleSheet, SafeAreaView, ScrollView } from 'react-native';
import {
  NativeMaterialView,
  NativeButton,
  NativeSwitch,
  NativeSegmentedControl,
  NativeSearchBar,
  NativeNavigationBar,
  NativeToolbar,
  NativeToolbarButton,
  NativeTabBar,
  NativeGroupedContainer,
  NativeCardContainer,
} from 'liquid-react';

export default function App() {
  const [switchValue, setSwitchValue] = useState(false);
  const [selectedSegment, setSelectedSegment] = useState(0);
  const [searchText, setSearchText] = useState('');
  const [selectedTab, setSelectedTab] = useState(0);

  return (
    <SafeAreaView style={styles.container}>
      {/* Navigation Bar */}
      <NativeNavigationBar
        title="Liquid React Demo"
        translucent={true}
        style={styles.navigationBar}
      />

      <ScrollView style={styles.content}>
        {/* Material View with Controls */}
        <NativeMaterialView
          material="systemUltraThinMaterial"
          style={styles.materialSection}
        >
          <Text style={styles.sectionTitle}>Material View</Text>
          <Text style={styles.sectionDescription}>
            Native UIVisualEffectView with system blur
          </Text>
        </NativeMaterialView>

        {/* Grouped Container */}
        <NativeGroupedContainer insetGrouped={true} style={styles.section}>
          <Text style={styles.sectionTitle}>Native Controls</Text>

          {/* Card with Button */}
          <NativeCardContainer cornerRadius={12} style={styles.card}>
            <Text style={styles.cardTitle}>Native Button</Text>
            <NativeButton
              title="Press Me"
              buttonStyle="filled"
              onPress={() => console.log('Button pressed')}
              style={styles.button}
            />
          </NativeCardContainer>

          {/* Card with Switch */}
          <NativeCardContainer cornerRadius={12} style={styles.card}>
            <View style={styles.cardRow}>
              <Text style={styles.cardTitle}>Native Switch</Text>
              <NativeSwitch
                value={switchValue}
                onValueChange={(e) => setSwitchValue(e.nativeEvent.value)}
              />
            </View>
          </NativeCardContainer>

          {/* Card with Segmented Control */}
          <NativeCardContainer cornerRadius={12} style={styles.card}>
            <Text style={styles.cardTitle}>Segmented Control</Text>
            <NativeSegmentedControl
              segments={['Option 1', 'Option 2', 'Option 3']}
              selectedIndex={selectedSegment}
              onValueChange={(e) => setSelectedSegment(e.nativeEvent.selectedIndex)}
              style={styles.segmentedControl}
            />
          </NativeCardContainer>

          {/* Search Bar */}
          <NativeSearchBar
            placeholder="Search..."
            text={searchText}
            onTextChanged={(e) => setSearchText(e.nativeEvent.text)}
            onSearchPressed={(e) => console.log('Search:', e.nativeEvent.text)}
            style={styles.searchBar}
          />
        </NativeGroupedContainer>

        {/* Different Material Styles */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Material Variations</Text>

          <NativeMaterialView
            material="systemThinMaterial"
            style={styles.materialCard}
          >
            <Text style={styles.materialText}>systemThinMaterial</Text>
          </NativeMaterialView>

          <NativeMaterialView
            material="systemMaterial"
            style={styles.materialCard}
          >
            <Text style={styles.materialText}>systemMaterial</Text>
          </NativeMaterialView>

          <NativeMaterialView
            material="systemThickMaterial"
            style={styles.materialCard}
          >
            <Text style={styles.materialText}>systemThickMaterial</Text>
          </NativeMaterialView>

          <NativeMaterialView
            material="systemChromeMaterial"
            style={styles.materialCard}
          >
            <Text style={styles.materialText}>systemChromeMaterial</Text>
          </NativeMaterialView>
        </View>

        {/* Button Style Variations */}
        <NativeGroupedContainer insetGrouped={true} style={styles.section}>
          <Text style={styles.sectionTitle}>Button Styles</Text>

          <NativeCardContainer cornerRadius={12} style={styles.card}>
            <NativeButton
              title="Filled"
              buttonStyle="filled"
              onPress={() => {}}
              style={styles.buttonVariation}
            />
            <NativeButton
              title="Gray"
              buttonStyle="gray"
              onPress={() => {}}
              style={styles.buttonVariation}
            />
            <NativeButton
              title="Tinted"
              buttonStyle="tinted"
              onPress={() => {}}
              style={styles.buttonVariation}
            />
            <NativeButton
              title="Bordered"
              buttonStyle="bordered"
              onPress={() => {}}
              style={styles.buttonVariation}
            />
            <NativeButton
              title="Plain"
              buttonStyle="plain"
              onPress={() => {}}
              style={styles.buttonVariation}
            />
          </NativeCardContainer>
        </NativeGroupedContainer>
      </ScrollView>

      {/* Toolbar */}
      <NativeToolbar translucent={true} style={styles.toolbar}>
        <NativeToolbarButton systemItem="add" onPress={() => {}} />
        <NativeToolbarButton systemItem="flexibleSpace" />
        <NativeToolbarButton title="Custom" onPress={() => {}} />
        <NativeToolbarButton systemItem="flexibleSpace" />
        <NativeToolbarButton systemItem="done" onPress={() => {}} />
      </NativeToolbar>

      {/* Tab Bar */}
      <NativeTabBar
        items={[
          { title: 'Home', icon: 'house' },
          { title: 'Search', icon: 'magnifyingglass' },
          { title: 'Settings', icon: 'gearshape' },
        ]}
        selectedIndex={selectedTab}
        onTabPress={(e) => setSelectedTab(e.nativeEvent.index)}
        translucent={true}
        style={styles.tabBar}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f2f2f7',
  },
  navigationBar: {
    width: '100%',
  },
  content: {
    flex: 1,
  },
  section: {
    marginVertical: 12,
    paddingHorizontal: 16,
  },
  materialSection: {
    margin: 16,
    padding: 20,
    borderRadius: 12,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: '700',
    marginBottom: 8,
    color: '#000',
  },
  sectionDescription: {
    fontSize: 14,
    color: '#666',
  },
  card: {
    padding: 16,
    marginBottom: 12,
  },
  cardRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  cardTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 12,
    color: '#000',
  },
  button: {
    width: '100%',
  },
  buttonVariation: {
    marginBottom: 10,
  },
  segmentedControl: {
    width: '100%',
  },
  searchBar: {
    width: '100%',
    marginTop: 12,
  },
  materialCard: {
    padding: 20,
    marginBottom: 12,
    borderRadius: 12,
    minHeight: 60,
    justifyContent: 'center',
    alignItems: 'center',
  },
  materialText: {
    fontSize: 14,
    fontWeight: '600',
    color: '#000',
  },
  toolbar: {
    width: '100%',
  },
  tabBar: {
    width: '100%',
  },
});
```

## Minimal Examples

### Material View Only

```jsx
import React from 'react';
import { View, Text } from 'react-native';
import { NativeMaterialView } from 'liquid-react';

export default function MinimalMaterialExample() {
  return (
    <NativeMaterialView
      material="systemMaterial"
      style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}
    >
      <Text style={{ fontSize: 24, fontWeight: 'bold' }}>
        Native Blur Material
      </Text>
    </NativeMaterialView>
  );
}
```

### Button Example

```jsx
import React from 'react';
import { View, Alert } from 'react-native';
import { NativeButton } from 'liquid-react';

export default function ButtonExample() {
  return (
    <View style={{ padding: 20 }}>
      <NativeButton
        title="Tap Me"
        buttonStyle="filled"
        onPress={() => Alert.alert('Success', 'Button was pressed!')}
        style={{ width: '100%', marginBottom: 10 }}
      />
      <NativeButton
        title="Secondary Action"
        buttonStyle="bordered"
        onPress={() => Alert.alert('Info', 'Secondary action triggered')}
        style={{ width: '100%' }}
      />
    </View>
  );
}
```

### Form Example

```jsx
import React, { useState } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import {
  NativeGroupedContainer,
  NativeCardContainer,
  NativeSwitch,
  NativeSegmentedControl,
  NativeButton,
} from 'liquid-react';

export default function FormExample() {
  const [notifications, setNotifications] = useState(true);
  const [theme, setTheme] = useState(0);

  const handleSubmit = () => {
    console.log('Form submitted:', { notifications, theme });
  };

  return (
    <NativeGroupedContainer insetGrouped={true} style={styles.container}>
      <NativeCardContainer cornerRadius={12} style={styles.card}>
        <View style={styles.row}>
          <Text style={styles.label}>Enable Notifications</Text>
          <NativeSwitch
            value={notifications}
            onValueChange={(e) => setNotifications(e.nativeEvent.value)}
          />
        </View>
      </NativeCardContainer>

      <NativeCardContainer cornerRadius={12} style={styles.card}>
        <Text style={styles.label}>Theme</Text>
        <NativeSegmentedControl
          segments={['Light', 'Dark', 'Auto']}
          selectedIndex={theme}
          onValueChange={(e) => setTheme(e.nativeEvent.selectedIndex)}
          style={styles.segmentedControl}
        />
      </NativeCardContainer>

      <NativeButton
        title="Save Settings"
        buttonStyle="filled"
        onPress={handleSubmit}
        style={styles.button}
      />
    </NativeGroupedContainer>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
  },
  card: {
    padding: 16,
    marginBottom: 12,
  },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  label: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 12,
  },
  segmentedControl: {
    width: '100%',
  },
  button: {
    marginTop: 20,
  },
});
```

## Testing

To test these examples in your React Native project:

1. Install liquid-react
2. Copy any example into your App.tsx/App.jsx
3. Run on iOS device or simulator
4. Observe native UIKit rendering

## Notes

- All examples use **only** public UIKit APIs
- Visual appearance controlled entirely by iOS
- Behavior may vary across iOS versions (this is expected)
- Examples are iOS-only
