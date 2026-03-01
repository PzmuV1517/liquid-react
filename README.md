# liquid-react

Probably the only React Native library where every component is literally what iOS ships inside its own apps. `UIButton`, `UISwitch`, `UIToolbar`, `UITabBar` — actual UIKit, running through a thin bridge. We didn't simulate anything, we didn't approximate anything. iOS draws the UI. We just exposed the controls.

iOS 13+ to run it at all. iOS 26+ if you want the Liquid Glass look. iOS only, full stop.

Fair warning right up front: `NativeMaterialView` doesn't work as a container. The blur renders, but children placed inside it won't show up. Known issue, being worked on. For now, treat it as a visual backdrop only, not a wrapper.

## Installation

```bash
npm install liquid-react
cd ios && pod install
```

Rebuild your app after that. That's it.

## Components

### NativeButton

```tsx
import { NativeButton } from 'liquid-react';

<NativeButton
  title="Continue"
  buttonStyle="filled"
  onPress={() => console.log('pressed')}
  style={{ width: '100%' }}
/>
```

`buttonStyle` options: `filled`, `gray`, `tinted`, `plain`, `bordered`, `borderedTinted`, `borderedProminent`.

Default height: 44.

---

### NativeSwitch

```tsx
import { NativeSwitch } from 'liquid-react';

const [on, setOn] = useState(false);

<NativeSwitch
  value={on}
  onValueChange={(e) => setOn(e.nativeEvent.value)}
/>
```

It's a UISwitch. Works like one.

### NativeSegmentedControl

```tsx
import { NativeSegmentedControl } from 'liquid-react';

const [tab, setTab] = useState(0);

<NativeSegmentedControl
  segments={['Day', 'Week', 'Month']}
  selectedIndex={tab}
  onValueChange={(e) => setTab(e.nativeEvent.selectedIndex)}
  style={{ width: '100%' }}
/>
```

Quick note on this one: the selection highlight appears while you're pressing but disappears when you release. The control itself is totally functional. Selection state and events fire correctly. The visual material just doesn't settle right inside a bridged view. UIKit limitation. More detail at the bottom of this file if you're curious.

Default height: 32.

---

### NativeSearchBar

```tsx
import { NativeSearchBar } from 'liquid-react';

const [query, setQuery] = useState('');

<NativeSearchBar
  placeholder="Search..."
  text={query}
  onTextChanged={(e) => setQuery(e.nativeEvent.text)}
  onSearchPressed={(e) => runSearch(e.nativeEvent.text)}
  onCancelPressed={() => setQuery('')}
  style={{ width: '100%' }}
/>
```

The prop names don't follow the standard React Native text input convention. It's `onTextChanged`, `onSearchPressed`, `onCancelPressed` — not `onChange` or `onChangeText`. Easy thing to get wrong the first time.

Default height: 56.

---

### NativeNavigationBar

```tsx
import { NativeNavigationBar } from 'liquid-react';

<NativeNavigationBar
  title="Settings"
  translucent={true}
  style={{ width: '100%' }}
/>
```

Default height: 44.

### NativeToolbar

This one works differently from what you might expect. No `items` array prop. You nest `NativeToolbarButton` and `NativeToolbarMenu` as children directly inside the toolbar.

```tsx
import { NativeToolbar, NativeToolbarButton, NativeToolbarMenu } from 'liquid-react';

<NativeToolbar translucent={true} style={{ width: '100%' }}>
  <NativeToolbarButton systemItem="add" onPress={handleAdd} />
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

`systemItem` values include: `add`, `done`, `cancel`, `edit`, `save`, `flexibleSpace`, `fixedSpace`, `compose`, `reply`, `trash`, `undo`, `redo`, `close`, and a few more. Full list in the [API reference](docs/API_REFERENCE.md).

Default height: 44.

---

### NativeTabBar

```tsx
import { NativeTabBar } from 'liquid-react';

const [tab, setTab] = useState(0);

<NativeTabBar
  items={[
    { title: 'Home', icon: 'house' },
    { title: 'Search', icon: 'magnifyingglass' },
    { title: 'Profile', icon: 'person.crop.circle' },
  ]}
  selectedIndex={tab}
  onTabPress={(e) => setTab(e.nativeEvent.index)}
  translucent={true}
  style={{ position: 'absolute', bottom: 0, width: '100%', height: 83 }}
/>
```

You have to give this one an explicit height in `style`. It won't size itself. On a normal iPhone with a home indicator, 83 to 95 works for most layouts, but that depends on your app.

---

### NativeMenuButton

Standalone context menu button. Same idea as `NativeToolbarMenu` but lives anywhere in your layout, not just inside a toolbar.

```tsx
import { NativeMenuButton } from 'liquid-react';

<NativeMenuButton
  icon="ellipsis.circle"
  menuItems={[
    { id: 'edit', title: 'Edit', icon: 'pencil' },
    { id: 'delete', title: 'Delete', icon: 'trash', destructive: true },
  ]}
  onMenuAction={(e) => handleAction(e.nativeEvent.id)}
  style={{ width: 44, height: 44 }}
/>
```

---

### NativeGroupedContainer / NativeCardContainer

```tsx
import { NativeGroupedContainer, NativeCardContainer } from 'liquid-react';

<NativeGroupedContainer insetGrouped={true} style={{ flex: 1 }}>
  <NativeCardContainer cornerRadius={10} style={{ margin: 16, padding: 16 }}>
    <Text>Card content</Text>
  </NativeCardContainer>
</NativeGroupedContainer>
```

`NativeGroupedContainer` sets `systemGroupedBackground`. `NativeCardContainer` goes inside it with `secondarySystemGroupedBackground` and a continuous corner radius. If you've built an iOS settings screen before, this is exactly that look.

---

### NativeStackView

Wraps `UIStackView`. Good for laying out a few native components without needing to fight flexbox.

```tsx
import { NativeStackView, NativeButton } from 'liquid-react';

<NativeStackView axis="vertical" spacing={8} alignment="fill" style={{ width: '100%' }}>
  <NativeButton title="Primary" buttonStyle="filled" onPress={save} />
  <NativeButton title="Cancel" buttonStyle="plain" onPress={cancel} />
</NativeStackView>
```

`axis`: `vertical` or `horizontal`. `alignment`: `fill`, `leading`, `trailing`, `center`, `firstBaseline`, `lastBaseline`. `distribution`: `fill`, `fillEqually`, `fillProportionally`, `equalSpacing`, `equalCentering`.

---

### NativeMaterialView

Wraps `UIVisualEffectView` with system blur materials.

```tsx
import { NativeMaterialView } from 'liquid-react';

<NativeMaterialView
  material="systemUltraThinMaterial"
  style={{ width: '100%', height: 200, borderRadius: 16 }}
/>
```

> **Broken:** React Native children don't render inside this component right now. The blur itself is visible, but child views aren't. Don't use it as a container until this is fixed.

Material options (lightest to heaviest): `systemUltraThinMaterial`, `systemThinMaterial`, `systemMaterial`, `systemThickMaterial`, `systemChromeMaterial`. Each has `Light` and `Dark` suffixed variants that lock to that appearance.

---

## Cross-version behavior

iOS 13 through 25 renders things whatever way that iOS version normally renders UIKit controls. iOS 26+ gives you Liquid Glass. Nothing gets polyfilled or faked across any version. The library just calls UIKit and UIKit does whatever it does on that version.

## What this library doesn't do

iOS only. No Android, no web, no plans for either. Blur intensity isn't something you can configure because Apple doesn't expose that as a public API. No SwiftUI. No private APIs.

Everything is App Store safe.

## Documentation

Full prop reference, type definitions, and more examples in [docs/](./docs/).

## Contributing

We try to keep up with new components Apple releases, but we're students so it doesn't always happen fast. If you want to add something or fix a bug, check [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT

---

## About the NativeSegmentedControl visual bug

The component itself is correct. Selection works, `selectedIndex` updates, events fire. The issue is purely visual: the Liquid Glass selection highlight appears while you're pressing and then vanishes when you lift your finger.

Why it happens: UIKit requires a specific set of conditions to resolve the material environment on a segmented control. No custom styling (no `backgroundColor`, `tintColor`, or `selectedSegmentTintColor`). Segments added before `selectedSegmentIndex` is ever touched. Layout forced after selection and frame changes. And a real `UIVisualEffectView` ancestor with a settled frame already in place. Getting all of that in sync through a React Native bridge, where layout and prop updates come through asynchronously, just isn't something we've been able to crack yet.

Not React Native's fault. Not a bug here. Just a UIKit constraint with no clean workaround we've found.

## Notes

They said it can't be done. We proved them wrong.
