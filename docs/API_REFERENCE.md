# API Reference

Complete reference for all Liquid-React components, props, and types.

## Table of Contents
- [Appearance Modes](#appearance-modes)
- [Materials & Containers](#materials--containers)
- [Controls](#controls)
- [Navigation](#navigation)
- [Types](#types)

---

## Appearance Modes

All visual components support an optional `appearanceMode` prop with these values:

- `auto` (default): keeps the current UIKit adaptive behavior.
- `system`: follows iOS system light/dark mode.
- `light`: forces light mode.
- `dark`: forces dark mode.

Use `LiquidReactAppearanceProvider` to set a global default and override per component when needed.

```jsx
import {
  LiquidReactAppearanceProvider,
  NativeButton,
} from 'liquid-react';

<LiquidReactAppearanceProvider mode="dark">
  <NativeButton title="Global Dark" />
  <NativeButton title="Forced Light" appearanceMode="light" />
</LiquidReactAppearanceProvider>
```

**Precedence:** component `appearanceMode` overrides provider `mode`; if neither is set, `auto` is used.

---

## Materials & Containers

### NativeMaterialView

Exposes `UIVisualEffectView` with system blur materials.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `material` | `MaterialType` | `'systemMaterial'` | System blur material style |
| `appearanceMode` | `AppearanceMode` | `'auto'` | Controls appearance behavior (`auto`, `system`, `light`, `dark`) |
| `onPress` | `() => void` | `undefined` | Called when view is tapped |
| `style` | `ViewStyle` | `undefined` | React Native style object |
| `children` | `ReactNode` | `undefined` | Child components |

**Example:**
```jsx
<NativeMaterialView 
  material="systemUltraThinMaterial"
  onPress={() => console.log('Pressed')}
>
  <Text>Content with native blur</Text>
</NativeMaterialView>
```

**UIKit Mapping:** `UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))`

---

### NativeGroupedContainer

UIView with system grouped background color.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `insetGrouped` | `boolean` | `true` | Use inset grouped style |
| `appearanceMode` | `AppearanceMode` | `'auto'` | Controls appearance behavior (`auto`, `system`, `light`, `dark`) |
| `style` | `ViewStyle` | `undefined` | React Native style object |
| `children` | `ReactNode` | `undefined` | Child components |

**Example:**
```jsx
<NativeGroupedContainer insetGrouped={true}>
  <Text>Grouped content</Text>
</NativeGroupedContainer>
```

**UIKit Mapping:** `UIView` with `backgroundColor = .systemGroupedBackground`

---

### NativeCardContainer

UIView with continuous corner radius.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `cornerRadius` | `number` | `10` | Corner radius in points |
| `appearanceMode` | `AppearanceMode` | `'auto'` | Controls appearance behavior (`auto`, `system`, `light`, `dark`) |
| `style` | `ViewStyle` | `undefined` | React Native style object |
| `children` | `ReactNode` | `undefined` | Child components |

**Example:**
```jsx
<NativeCardContainer cornerRadius={12}>
  <Text>Card content</Text>
</NativeCardContainer>
```

**UIKit Mapping:** `UIView` with `layer.cornerRadius` and `layer.cornerCurve = .continuous`

---

## Controls

### NativeButton

Native UIButton with system configurations.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `title` | `string` | `''` | Button title text (required) |
| `buttonStyle` | `ButtonStyle` | `'filled'` | System button style |
| `appearanceMode` | `AppearanceMode` | `'auto'` | Controls appearance behavior (`auto`, `system`, `light`, `dark`) |
| `onPress` | `() => void` | `undefined` | Called when button is pressed |
| `style` | `ViewStyle` | `undefined` | React Native style object |

**Example:**
```jsx
<NativeButton 
  title="Continue"
  buttonStyle="filled"
  onPress={() => console.log('Pressed')}
/>
```

**UIKit Mapping:** `UIButton(configuration: .filled())`

---

### NativeSwitch

Native UISwitch toggle control.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `value` | `boolean` | `false` | Switch on/off state |
| `appearanceMode` | `AppearanceMode` | `'auto'` | Controls appearance behavior (`auto`, `system`, `light`, `dark`) |
| `onValueChange` | `(event) => void` | `undefined` | Called when value changes |
| `style` | `ViewStyle` | `undefined` | React Native style object |

**Event Payload:**
```typescript
{
  nativeEvent: {
    value: boolean
  }
}
```

**Example:**
```jsx
const [enabled, setEnabled] = useState(false);

<NativeSwitch
  value={enabled}
  onValueChange={(e) => setEnabled(e.nativeEvent.value)}
/>
```

**UIKit Mapping:** `UISwitch`

---

### NativeSegmentedControl

Native UISegmentedControl for segmented selection.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `segments` | `string[]` | `[]` | Array of segment titles (required) |
| `selectedIndex` | `number` | `0` | Currently selected segment index |
| `appearanceMode` | `AppearanceMode` | `'auto'` | Controls appearance behavior (`auto`, `system`, `light`, `dark`) |
| `onValueChange` | `(event) => void` | `undefined` | Called when selection changes |
| `style` | `ViewStyle` | `undefined` | React Native style object |

**Event Payload:**
```typescript
{
  nativeEvent: {
    selectedIndex: number
  }
}
```

**Example:**
```jsx
const [index, setIndex] = useState(0);

<NativeSegmentedControl
  segments={['First', 'Second', 'Third']}
  selectedIndex={index}
  onValueChange={(e) => setIndex(e.nativeEvent.selectedIndex)}
/>
```

**UIKit Mapping:** `UISegmentedControl`

---

### NativeSearchBar

Native UISearchBar for search input.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `placeholder` | `string` | `''` | Placeholder text |
| `text` | `string` | `''` | Current search text |
| `appearanceMode` | `AppearanceMode` | `'auto'` | Controls appearance behavior (`auto`, `system`, `light`, `dark`) |
| `onChangeText` | `(event) => void` | `undefined` | Called when text changes |
| `onSearchPress` | `(event) => void` | `undefined` | Called when search button pressed |
| `onCancelPress` | `() => void` | `undefined` | Called when cancel button pressed |
| `style` | `ViewStyle` | `undefined` | React Native style object |

**Event Payload:**
```typescript
{
  nativeEvent: {
    text: string
  }
}
```

**Example:**
```jsx
const [search, setSearch] = useState('');

<NativeSearchBar
  placeholder="Search..."
  text={search}
  onChangeText={(e) => setSearch(e.nativeEvent.text)}
  onSearchPress={(e) => console.log('Search:', e.nativeEvent.text)}
/>
```

**UIKit Mapping:** `UISearchBar`

---

## Navigation

### NativeNavigationBar

Native UINavigationBar for top navigation.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `title` | `string` | `''` | Navigation bar title |
| `barTintColor` | `string` | `undefined` | Bar background color |
| `translucent` | `boolean` | `true` | Enable translucency |
| `appearanceMode` | `AppearanceMode` | `'auto'` | Controls appearance behavior (`auto`, `system`, `light`, `dark`) |
| `style` | `ViewStyle` | `undefined` | React Native style object |

**Example:**
```jsx
<NativeNavigationBar
  title="My App"
  translucent={true}
  barTintColor="#007AFF"
/>
```

**UIKit Mapping:** `UINavigationBar`

---

### NativeToolbar

Native UIToolbar for bottom toolbars.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `items` | `ToolbarItem[]` | `[]` | Array of toolbar items |
| `translucent` | `boolean` | `true` | Enable translucency |
| `appearanceMode` | `AppearanceMode` | `'auto'` | Controls appearance behavior (`auto`, `system`, `light`, `dark`) |
| `style` | `ViewStyle` | `undefined` | React Native style object |

**ToolbarItem Type:**
```typescript
{
  title?: string;          // Custom title
  systemItem?: ToolbarSystemItem;  // System item type
}
```

**Example:**
```jsx
<NativeToolbar
  items={[
    { systemItem: 'add' },
    { systemItem: 'flexibleSpace' },
    { title: 'Custom' },
    { systemItem: 'done' }
  ]}
  translucent={true}
/>
```

**UIKit Mapping:** `UIToolbar`

---

### NativeTabBar

Native UITabBar for tab navigation.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `items` | `TabBarItem[]` | `[]` | Array of tab items (required) |
| `selectedIndex` | `number` | `0` | Currently selected tab index |
| `translucent` | `boolean` | `true` | Enable translucency |
| `appearanceMode` | `AppearanceMode` | `'auto'` | Controls appearance behavior (`auto`, `system`, `light`, `dark`) |
| `onTabPress` | `(event) => void` | `undefined` | Called when tab is pressed |
| `style` | `ViewStyle` | `undefined` | React Native style object |

**TabBarItem Type:**
```typescript
{
  title: string;           // Tab title (required)
  icon?: string;           // SF Symbol name
  systemItem?: TabBarSystemItem;  // System tab item
}
```

**Event Payload:**
```typescript
{
  nativeEvent: {
    index: number
  }
}
```

**Example:**
```jsx
const [tab, setTab] = useState(0);

<NativeTabBar
  items={[
    { title: 'Home', icon: 'house' },
    { title: 'Search', icon: 'magnifyingglass' },
    { title: 'Profile', icon: 'person' }
  ]}
  selectedIndex={tab}
  onTabPress={(e) => setTab(e.nativeEvent.index)}
/>
```

**UIKit Mapping:** `UITabBar`

---

## Types

### AppearanceMode

Appearance mode values shared by visual components and `LiquidReactAppearanceProvider`:

```typescript
type AppearanceMode = 'system' | 'auto' | 'light' | 'dark';
```

**Semantics:**
- `auto`: Keep UIKit default adaptive behavior.
- `system`: Follow iOS system light/dark mode.
- `light`: Force light mode.
- `dark`: Force dark mode.

---

### MaterialType

All available UIKit system blur materials:

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

**Thickness Hierarchy:**
- `UltraThin` - Lightest blur
- `Thin` - Light blur
- `Material` - Standard blur (default)
- `Thick` - Heavy blur
- `Chrome` - Extra heavy blur

**Appearance Variants:**
- No suffix - Adapts to system (light/dark)
- `Light` - Light appearance only
- `Dark` - Dark appearance only

---

### ButtonStyle

UIButton configuration styles:

```typescript
type ButtonStyle =
  | 'filled'              // Solid background (default)
  | 'gray'                // Gray background
  | 'tinted'              // Tinted background
  | 'plain'               // No background
  | 'bordered'            // Border outline
  | 'borderedTinted'      // Tinted border
  | 'borderedProminent';  // Prominent border
```

**UIKit Mapping:** `UIButton.Configuration.*`

---

### ToolbarSystemItem

System toolbar item types:

```typescript
type ToolbarSystemItem =
  | 'done' | 'cancel' | 'edit' | 'save' | 'add'
  | 'flexibleSpace' | 'fixedSpace'
  | 'compose' | 'reply' | 'action' | 'organize'
  | 'bookmarks' | 'search' | 'refresh' | 'stop'
  | 'camera' | 'trash' | 'play' | 'pause'
  | 'rewind' | 'fastForward'
  | 'undo' | 'redo' | 'close';
```

**UIKit Mapping:** `UIBarButtonItem.SystemItem`

---

### TabBarSystemItem

System tab bar item types:

```typescript
type TabBarSystemItem =
  | 'more' | 'favorites' | 'featured' | 'topRated'
  | 'recents' | 'contacts' | 'history' | 'bookmarks'
  | 'search' | 'downloads' | 'mostRecent' | 'mostViewed';
```

**UIKit Mapping:** `UITabBarItem.SystemItem`

---

## Layout Guidelines

### Recommended Heights
- `NativeButton`: 44pt (default iOS touch target)
- `NativeSegmentedControl`: 32pt
- `NativeSearchBar`: 56pt
- `NativeNavigationBar`: 44pt
- `NativeToolbar`: 44pt
- `NativeTabBar`: 49pt
- `NativeSwitch`: Intrinsic size (51×31pt)

### Container Sizing
All container components accept standard React Native `style` props:
- `width` / `height`
- `flex`
- `padding` / `margin`
- `backgroundColor` (overrides system colors)

### Best Practices
1. Always provide explicit `width` and `height` or use `flex` layout
2. Use `SafeAreaView` for navigation/tab bars
3. Respect iOS safe areas
4. Test on multiple iOS versions
5. Support both light and dark mode

---

## Platform Support

- **iOS:** 13.0+ ✅
- **Android:** Not supported ❌
- **Web:** Not supported ❌

Liquid-React is iOS-only by design.

---

## See Also

- [Examples](./EXAMPLES.md) - Usage examples
- [Architecture](./ARCHITECTURE.md) - Technical architecture
- [App Store Compliance](./APP_STORE_COMPLIANCE.md) - Legal compliance
