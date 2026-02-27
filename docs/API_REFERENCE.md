# API Reference

Complete prop reference for all liquid-react components, types, and event payloads.

---

## Components

### NativeMaterialView

Wraps `UIVisualEffectView`. Renders the system blur effect.

> ⚠️ **React Native children don't render inside this component.** The blur effect itself is visible, but child views are not. This is a known bridging issue.

Default style: `overflow: 'hidden'`.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `material` | `MaterialType` | `'systemMaterial'` | The UIKit blur material. See [MaterialType](#materialtype). |
| `onPress` | `(e) => void` | — | Fired on tap. `e.nativeEvent` is empty. |
| `style` | `ViewStyle` | — | Width/height or flex required. |

---

### NativeButton

Wraps `UIButton` with `UIButton.Configuration` styles.

Default style: `height: 44`.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `title` | `string` | required | Button label. |
| `buttonStyle` | `ButtonStyle` | `'filled'` | Visual style. See [ButtonStyle](#buttonstyle). |
| `onPress` | `(e) => void` | — | Fired on tap. `e.nativeEvent` is empty. |
| `style` | `ViewStyle` | — | Use to set width. |

---

### NativeSwitch

Wraps `UISwitch`.

No default size — uses the switch's intrinsic size.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `value` | `boolean` | `false` | Controlled on/off state. |
| `onTintColor` | `string` | system tint | Track color when on (hex string, e.g. `'#007AFF'`). |
| `thumbTintColor` | `string` | `'#fff'` | Knob color. |
| `disabled` | `boolean` | `false` | Disables interaction. |
| `onValueChange` | `(e) => void` | — | Fired on toggle. `e.nativeEvent.value` is the new boolean. |

---

### NativeSegmentedControl

Wraps `UISegmentedControl`.

> ⚠️ **Liquid Glass selection rendering is unreliable.** The selection indicator appears on press but disappears on release due to a UIKit material environment limitation when bridged. The control is functionally correct — `onValueChange` fires and `selectedIndex` is respected. Only the visual material effect is affected.

Default style: `height: 32`.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `segments` | `string[]` | required | Array of segment labels. |
| `selectedIndex` | `number` | `0` | Controlled selected index. |
| `onValueChange` | `(e) => void` | — | Fired on selection. `e.nativeEvent.selectedIndex` is the new index. |

---

### NativeSearchBar

Wraps `UISearchBar`.

Default style: `height: 56`.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `placeholder` | `string` | `'Search'` | Placeholder text. |
| `text` | `string` | `''` | Controlled text value. |
| `onTextChanged` | `(e) => void` | — | Fired on every keystroke. `e.nativeEvent.text` is the current string. |
| `onSearchPressed` | `(e) => void` | — | Fired when the Search key is tapped. `e.nativeEvent.text` is the submitted string. |
| `onCancelPressed` | `(e) => void` | — | Fired when Cancel is tapped. `e.nativeEvent` is empty. |

---

### NativeNavigationBar

Wraps `UINavigationBar`.

Default style: `height: 44`.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `title` | `string` | — | Title text centered in the bar. |
| `translucent` | `boolean` | `true` | When true, applies the system material blur behind the bar. |

---

### NativeToolbar

Wraps `UIToolbar`. Accepts `NativeToolbarButton` and `NativeToolbarMenu` as direct children — don't place arbitrary views inside it.

Default style: `height: 44`.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `translucent` | `boolean` | `true` | System material blur behind the toolbar. |
| `children` | `ReactNode` | — | Only `NativeToolbarButton` and `NativeToolbarMenu`. |

**Example:**
```tsx
<NativeToolbar translucent={true} style={{ width: '100%' }}>
  <NativeToolbarButton systemItem="add" onPress={addItem} />
  <NativeToolbarButton systemItem="flexibleSpace" />
  <NativeToolbarMenu
    icon="ellipsis.circle"
    menuItems={[
      { id: 'share', title: 'Share', icon: 'square.and.arrow.up' },
      { id: 'delete', title: 'Delete', icon: 'trash', destructive: true },
    ]}
    onMenuAction={(e) => handleAction(e.nativeEvent.id)}
  />
</NativeToolbar>
```

---

### NativeToolbarButton

Wraps `UIBarButtonItem`. Must be a direct child of `NativeToolbar`.

Use `systemItem` for standard system items, or `icon`/`title` for custom ones. `flexibleSpace` and `fixedSpace` are layout-only items and don't fire `onPress`.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `systemItem` | `ToolbarSystemItem` | — | UIKit system bar button item. See [ToolbarSystemItem](#toolbarsystemitem). |
| `icon` | `string` | — | SF Symbols name. Ignored if `systemItem` is set. |
| `title` | `string` | — | Label text. |
| `disabled` | `boolean` | `false` | Disables interaction. |
| `onPress` | `(e) => void` | — | Fired on tap. `e.nativeEvent` is empty. |

---

### NativeToolbarMenu

Wraps `UIBarButtonItem` with an attached `UIMenu`. Must be a direct child of `NativeToolbar`. Supports nested submenus via `children` in `ToolbarMenuItem`.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `menuItems` | `ToolbarMenuItem[]` | required | Menu items. See [ToolbarMenuItem](#toolbarmenuitem). |
| `icon` | `string` | — | SF Symbols name for the button. |
| `title` | `string` | — | Label text for the button. |
| `disabled` | `boolean` | `false` | Disables the menu button. |
| `onMenuAction` | `(e) => void` | — | Fired on item selection. `e.nativeEvent.id` and `e.nativeEvent.title` identify the item. |

---

### NativeTabBar

Wraps `UITabBar`.

Default style: `height: 49`. **Always set `height` explicitly in the `style` prop** — the view doesn't size itself automatically.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `items` | `TabBarItem[]` | required | Array of tab items. See [TabBarItem](#tabbaritem). |
| `selectedIndex` | `number` | `0` | Controlled selected tab. |
| `translucent` | `boolean` | `true` | System material blur behind the bar. |
| `onTabPress` | `(e) => void` | — | Fired on tab tap. `e.nativeEvent.index` is the tapped index. |

On iPhone with a home indicator, a typical total height (including safe area) is `83`–`95pt`.

---

### NativeGroupedContainer

A `UIView` with `systemGroupedBackground` applied.

Default style: `overflow: 'hidden'`.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `insetGrouped` | `boolean` | `false` | When true, uses the inset grouped background style. |

---

### NativeCardContainer

A `UIView` with `secondarySystemGroupedBackground` and a continuous corner radius. Matches the card cells in Settings, Contacts, etc.

Default style: `overflow: 'hidden'`.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `cornerRadius` | `number` | `10` | Corner radius in points. Uses `CALayer.cornerCurve = .continuous`. |

---

### NativeStackView

Wraps `UIStackView`. No default size or spacing.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `axis` | `'vertical' \| 'horizontal'` | `'vertical'` | Layout direction. |
| `spacing` | `number` | `0` | Points between arranged subviews. |
| `alignment` | `StackAlignment` | `'fill'` | Cross-axis alignment. See [StackAlignment](#stackalignment). |
| `distribution` | `StackDistribution` | `'fill'` | Distribution along the axis. See [StackDistribution](#stackdistribution). |

---

### NativeMenuButton

A standalone `UIButton` that shows a `UIMenu` on press. Works anywhere — no `NativeToolbar` required.

No default size. Set width/height via `style`.

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `menuItems` | `ToolbarMenuItem[]` | required | Menu items. See [ToolbarMenuItem](#toolbarmenuitem). |
| `icon` | `string` | — | SF Symbols name for the button icon. |
| `tintColorHex` | `string` | system tint | Icon tint color as a hex string. |
| `onMenuAction` | `(e) => void` | — | Fired on item selection. `e.nativeEvent.id` and `e.nativeEvent.title` identify the item. |

---

## Types

### MaterialType

Controls the `UIVisualEffectView` blur material on `NativeMaterialView`.

```typescript
type MaterialType =
  | 'systemUltraThinMaterial'   // lightest, nearly transparent
  | 'systemThinMaterial'
  | 'systemMaterial'            // standard — used in sheets, cards
  | 'systemThickMaterial'
  | 'systemChromeMaterial'      // heaviest — used in chrome areas
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

The unsuffixed values adapt to light/dark mode automatically. `Light`/`Dark` suffixed variants lock to that appearance.

---

### ButtonStyle

Maps to `UIButton.Configuration` styles.

```typescript
type ButtonStyle =
  | 'filled'             // solid tint background — primary action
  | 'gray'               // gray background — secondary action
  | 'tinted'             // light tinted background
  | 'plain'              // no background — tertiary action
  | 'bordered'           // border outline
  | 'borderedTinted'     // tinted border
  | 'borderedProminent'; // prominent bordered style
```

---

### ToolbarSystemItem

Maps to `UIBarButtonItem.SystemItem`. Used on `NativeToolbarButton`.

```typescript
type ToolbarSystemItem =
  | 'done' | 'cancel' | 'edit' | 'save' | 'add'
  | 'flexibleSpace' | 'fixedSpace'
  | 'compose' | 'reply' | 'action' | 'organize'
  | 'bookmarks' | 'search' | 'refresh' | 'stop'
  | 'camera' | 'trash' | 'play' | 'pause'
  | 'rewind' | 'fastForward' | 'undo' | 'redo' | 'close';
```

`flexibleSpace` expands to fill available space. `fixedSpace` is a fixed-size gap. Neither fires `onPress`.

---

### ToolbarMenuItem

Used in `menuItems` on `NativeToolbarMenu` and `NativeMenuButton`. Items can be nested to create submenus.

```typescript
interface ToolbarMenuItem {
  id?: string;              // returned in onMenuAction — defaults to title if omitted
  title: string;            // required
  icon?: string;            // SF Symbols name
  destructive?: boolean;    // renders in red with UIMenuElement.Attributes.destructive
  disabled?: boolean;       // grays out and prevents selection
  children?: ToolbarMenuItem[];  // nested items become a UIMenu submenu
}
```

---

### TabBarItem

Used in `items` on `NativeTabBar`.

```typescript
interface TabBarItem {
  title: string;
  icon?: string;               // SF Symbols name
  systemItem?: TabBarSystemItem;
}
```

If `systemItem` is set, UIKit provides the system icon and label. `icon` takes precedence over `systemItem` when both are provided.

**TabBarSystemItem values:**
```typescript
type TabBarSystemItem =
  | 'more' | 'favorites' | 'featured' | 'topRated'
  | 'recents' | 'contacts' | 'history' | 'bookmarks'
  | 'search' | 'downloads' | 'mostRecent' | 'mostViewed';
```

---

### StackAlignment

Cross-axis alignment for `NativeStackView`. Maps to `UIStackView.Alignment`.

```typescript
type StackAlignment =
  | 'fill'
  | 'leading'
  | 'trailing'
  | 'center'
  | 'firstBaseline'  // horizontal stacks only
  | 'lastBaseline';  // horizontal stacks only
```

---

### StackDistribution

How the stack distributes arranged views along its axis. Maps to `UIStackView.Distribution`.

```typescript
type StackDistribution =
  | 'fill'                // one view expands to fill remaining space
  | 'fillEqually'         // all views the same size
  | 'fillProportionally'  // sized proportionally to intrinsic content size
  | 'equalSpacing'        // equal spacing between views
  | 'equalCentering';     // equal spacing between centers
```

---

## Event Payloads

All events follow the RN native event pattern: `(e: { nativeEvent: T }) => void`.

| Event | `e.nativeEvent` |
|-------|----------------|
| `NativeButton.onPress` | `{}` |
| `NativeMaterialView.onPress` | `{}` |
| `NativeSwitch.onValueChange` | `{ value: boolean }` |
| `NativeSegmentedControl.onValueChange` | `{ selectedIndex: number }` |
| `NativeSearchBar.onTextChanged` | `{ text: string }` |
| `NativeSearchBar.onSearchPressed` | `{ text: string }` |
| `NativeSearchBar.onCancelPressed` | `{}` |
| `NativeTabBar.onTabPress` | `{ index: number }` |
| `NativeToolbarButton.onPress` | `{}` |
| `NativeToolbarMenu.onMenuAction` | `{ id: string; title: string }` |
| `NativeMenuButton.onMenuAction` | `{ id: string; title: string }` |

---

## Default Sizes

Applied automatically; override via `style`.

| Component | Default |
|-----------|---------|
| `NativeButton` | `height: 44` |
| `NativeSegmentedControl` | `height: 32` |
| `NativeSearchBar` | `height: 56` |
| `NativeNavigationBar` | `height: 44` |
| `NativeToolbar` | `height: 44` |
| `NativeTabBar` | `height: 49` |
| `NativeMaterialView` | `overflow: 'hidden'` |
| `NativeGroupedContainer` | `overflow: 'hidden'` |
| `NativeCardContainer` | `overflow: 'hidden'` |
| `NativeSwitch` | intrinsic (no override) |
| `NativeStackView` | none — fully prop-driven |
| `NativeMenuButton` | none — set via `style` |

---

## Known Limitations

- **iOS only.** The native module doesn't load on Android or web.
- **No Auto Layout.** React Native uses frame-based layout. Components need a frame from `style` or a flex parent.
- **System-controlled colors.** Material colors, blur appearance, and most tints are controlled by iOS.
- **No custom blur intensity.** `UIVisualEffectView` doesn't expose blur radius as a public API.
- **NativeMaterialView children.** Child views don't render inside the blur view. Tracked as a known issue.
- **NativeSegmentedControl Liquid Glass.** Selection indicator disappears on release. Functionally correct — only the material effect is affected.

---

## Platform Support

iOS 13.0+ only. Android and web are not supported.

---

## See Also

- [Examples](./EXAMPLES.md)
- [Architecture](./ARCHITECTURE.md)
- [App Store Compliance](./APP_STORE_COMPLIANCE.md)
