Components
==========

All components are re-exported from the top-level ``liquid-react`` package. Every component accepts all standard React Native ``ViewProps`` in addition to its own props (so ``style``, ``testID``, etc. all work). Events arrive as ``(e: { nativeEvent: PayloadType }) => void``.

.. contents:: On this page
   :local:
   :depth: 1

----

NativeMaterialView
------------------

Wraps ``UIVisualEffectView`` with one of Apple's system blur materials. The view renders the blur effect and composites content on top of it.

.. warning::

   React Native children do not render correctly inside ``NativeMaterialView`` due to a known bridging limitation. The blur effect itself renders fine, but child views are not visible. Do not use this component to contain other React Native views until this issue is resolved.

Default size: ``overflow: hidden`` applied automatically.

**Props**

.. list-table::
   :header-rows: 1
   :widths: 20 20 10 50

   * - Prop
     - Type
     - Default
     - Description
   * - ``material``
     - ``MaterialType``
     - ``'systemMaterial'``
     - The UIKit blur material to apply. See :ref:`material-types` for all values.
   * - ``onPress``
     - ``(e) => void``
     - —
     - Fired when the view is tapped. ``e.nativeEvent`` is empty.
   * - ``style``
     - ``ViewStyle``
     - —
     - Standard RN style. You must set width/height or flex.

**Example**

.. code-block:: tsx

   <NativeMaterialView
     material="systemUltraThinMaterial"
     style={{ width: '100%', height: 200, borderRadius: 16 }}
   />

----

NativeButton
------------

Wraps ``UIButton`` with system button configurations. The ``buttonStyle`` prop maps directly to ``UIButton.Configuration`` styles introduced in iOS 15, with graceful fallback on older versions.

Default size: ``height: 44``.

**Props**

.. list-table::
   :header-rows: 1
   :widths: 20 20 10 50

   * - Prop
     - Type
     - Default
     - Description
   * - ``title``
     - ``string``
     - required
     - Button label text.
   * - ``buttonStyle``
     - ``ButtonStyle``
     - ``'filled'``
     - Visual style. See :ref:`button-styles` for all values.
   * - ``onPress``
     - ``(e) => void``
     - —
     - Fired on tap. ``e.nativeEvent`` is empty.
   * - ``style``
     - ``ViewStyle``
     - —
     - Use to set width. Height defaults to 44.

**Example**

.. code-block:: tsx

   <NativeButton
     title="Continue"
     buttonStyle="filled"
     onPress={(e) => console.log('pressed')}
     style={{ width: '100%' }}
   />

   <NativeButton
     title="Cancel"
     buttonStyle="plain"
     onPress={onCancel}
   />

----

NativeSwitch
------------

Wraps ``UISwitch``. The appearance is fully controlled by iOS — tint colors adapt automatically to light/dark mode unless explicitly overridden.

No default size is applied; the switch uses its intrinsic size.

**Props**

.. list-table::
   :header-rows: 1
   :widths: 20 20 10 50

   * - Prop
     - Type
     - Default
     - Description
   * - ``value``
     - ``boolean``
     - ``false``
     - Controlled on/off state.
   * - ``onTintColor``
     - ``string``
     - system tint
     - Track color when the switch is on. Accepts any CSS hex color (e.g. ``'#007AFF'``).
   * - ``thumbTintColor``
     - ``string``
     - ``'#fff'``
     - Knob color.
   * - ``disabled``
     - ``boolean``
     - ``false``
     - Disables interaction.
   * - ``onValueChange``
     - ``(e) => void``
     - —
     - Fired when toggled. ``e.nativeEvent.value`` is the new boolean state.

**Example**

.. code-block:: tsx

   const [enabled, setEnabled] = React.useState(false);

   <NativeSwitch
     value={enabled}
     onValueChange={(e) => setEnabled(e.nativeEvent.value)}
   />

----

NativeSegmentedControl
----------------------

Wraps ``UISegmentedControl``.

.. warning::

   The Liquid Glass selection indicator rendering is unreliable when this control is embedded in a React Native bridged view. The highlight appears during press but disappears on release because UIKit cannot fully resolve the material environment. The control is functionally correct — ``onValueChange`` fires properly and ``selectedIndex`` is respected. Only the visual material effect is affected.

Default size: ``height: 32``.

**Props**

.. list-table::
   :header-rows: 1
   :widths: 20 20 10 50

   * - Prop
     - Type
     - Default
     - Description
   * - ``segments``
     - ``string[]``
     - required
     - Array of segment labels.
   * - ``selectedIndex``
     - ``number``
     - ``0``
     - Controlled selected segment index.
   * - ``onValueChange``
     - ``(e) => void``
     - —
     - Fired when a segment is tapped. ``e.nativeEvent.selectedIndex`` is the new index.

**Example**

.. code-block:: tsx

   const [tab, setTab] = React.useState(0);

   <NativeSegmentedControl
     segments={['Day', 'Week', 'Month']}
     selectedIndex={tab}
     onValueChange={(e) => setTab(e.nativeEvent.selectedIndex)}
     style={{ width: '100%' }}
   />

----

NativeSearchBar
---------------

Wraps ``UISearchBar``. Renders the native iOS search bar with the system keyboard integration and cancel button behavior.

Default size: ``height: 56``.

**Props**

.. list-table::
   :header-rows: 1
   :widths: 20 20 10 50

   * - Prop
     - Type
     - Default
     - Description
   * - ``placeholder``
     - ``string``
     - ``'Search'``
     - Placeholder text shown when the field is empty.
   * - ``text``
     - ``string``
     - ``''``
     - Controlled text value.
   * - ``onTextChanged``
     - ``(e) => void``
     - —
     - Fired on every keystroke. ``e.nativeEvent.text`` is the current string.
   * - ``onSearchPressed``
     - ``(e) => void``
     - —
     - Fired when the user taps the Search key. ``e.nativeEvent.text`` is the submitted string.
   * - ``onCancelPressed``
     - ``(e) => void``
     - —
     - Fired when the Cancel button is tapped. ``e.nativeEvent`` is empty.

**Example**

.. code-block:: tsx

   const [query, setQuery] = React.useState('');

   <NativeSearchBar
     placeholder="Search items..."
     text={query}
     onTextChanged={(e) => setQuery(e.nativeEvent.text)}
     onSearchPressed={(e) => runSearch(e.nativeEvent.text)}
     onCancelPressed={() => setQuery('')}
     style={{ width: '100%' }}
   />

----

NativeNavigationBar
-------------------

Wraps ``UINavigationBar``. Renders a standalone navigation bar — useful for custom layouts where you want the bar without a full navigation controller.

Default size: ``height: 44``.

**Props**

.. list-table::
   :header-rows: 1
   :widths: 20 20 10 50

   * - Prop
     - Type
     - Default
     - Description
   * - ``title``
     - ``string``
     - —
     - Title text displayed in the center of the bar.
   * - ``translucent``
     - ``boolean``
     - ``true``
     - When true, applies the system material blur behind the bar.

**Example**

.. code-block:: tsx

   <NativeNavigationBar
     title="Settings"
     translucent={true}
     style={{ width: '100%' }}
   />

----

NativeToolbar
-------------

Wraps ``UIToolbar``. Accepts ``NativeToolbarButton`` and ``NativeToolbarMenu`` as direct children. The toolbar manages the native bar button item layout internally — do not place arbitrary views inside it.

Default size: ``height: 44``.

**Props**

.. list-table::
   :header-rows: 1
   :widths: 20 20 10 50

   * - Prop
     - Type
     - Default
     - Description
   * - ``translucent``
     - ``boolean``
     - ``true``
     - When true, applies system material blur behind the toolbar.
   * - ``children``
     - ``ReactNode``
     - —
     - Should only contain ``NativeToolbarButton`` and ``NativeToolbarMenu`` components.

**Example**

.. code-block:: tsx

   <NativeToolbar
     translucent={true}
     style={{ width: '100%', position: 'absolute', bottom: 0 }}
   >
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

----

NativeToolbarButton
-------------------

Wraps ``UIBarButtonItem``. Must be a direct child of ``NativeToolbar``.

You can configure it with a system item, a title, an SF Symbol icon, or a combination. When using ``systemItem``, the appropriate system icon and accessibility label are applied automatically.

No default size (intrinsic to the bar button item).

**Props**

.. list-table::
   :header-rows: 1
   :widths: 20 20 10 50

   * - Prop
     - Type
     - Default
     - Description
   * - ``systemItem``
     - ``ToolbarSystemItem``
     - —
     - A UIKit system bar button item (e.g. ``'add'``, ``'done'``, ``'flexibleSpace'``). See :ref:`toolbar-system-items`.
   * - ``icon``
     - ``string``
     - —
     - SF Symbols name (e.g. ``'star.fill'``). Ignored if ``systemItem`` is set.
   * - ``title``
     - ``string``
     - —
     - Label text. Can be used alongside ``icon``.
   * - ``disabled``
     - ``boolean``
     - ``false``
     - Disables tap interaction.
   * - ``onPress``
     - ``(e) => void``
     - —
     - Fired on tap. ``e.nativeEvent`` is empty.

**Example**

.. code-block:: tsx

   {/* system item */}
   <NativeToolbarButton systemItem="done" onPress={dismiss} />

   {/* SF Symbol icon */}
   <NativeToolbarButton icon="plus" onPress={addItem} />

   {/* flexible space — pushes items to edges */}
   <NativeToolbarButton systemItem="flexibleSpace" />

----

NativeToolbarMenu
-----------------

Wraps ``UIBarButtonItem`` with an attached ``UIMenu``. Must be a direct child of ``NativeToolbar``. Menu items can be nested to create submenus.

No default size (intrinsic to the bar button item).

**Props**

.. list-table::
   :header-rows: 1
   :widths: 20 20 10 50

   * - Prop
     - Type
     - Default
     - Description
   * - ``menuItems``
     - ``ToolbarMenuItem[]``
     - required
     - Array of menu items. See :ref:`toolbar-menu-item`.
   * - ``icon``
     - ``string``
     - —
     - SF Symbols name for the button that opens the menu.
   * - ``title``
     - ``string``
     - —
     - Label text for the button.
   * - ``disabled``
     - ``boolean``
     - ``false``
     - Disables the entire menu button.
   * - ``onMenuAction``
     - ``(e) => void``
     - —
     - Fired when a menu item is selected. ``e.nativeEvent.id`` and ``e.nativeEvent.title`` identify the item.

**Example**

.. code-block:: tsx

   <NativeToolbarMenu
     icon="ellipsis.circle"
     menuItems={[
       { id: 'rename', title: 'Rename', icon: 'pencil' },
       { id: 'duplicate', title: 'Duplicate', icon: 'doc.on.doc' },
       {
         id: 'more',
         title: 'More',
         children: [
           { id: 'export', title: 'Export', icon: 'square.and.arrow.up' },
           { id: 'print', title: 'Print', icon: 'printer' },
         ],
       },
       { id: 'delete', title: 'Delete', icon: 'trash', destructive: true },
     ]}
     onMenuAction={(e) => console.log('tapped', e.nativeEvent.id)}
   />

----

NativeTabBar
------------

Wraps ``UITabBar``. Tab items can use SF Symbol icons, system items, or just a title.

Default size: ``height: 49``. You must set a height explicitly in the ``style`` prop — the native view does not size itself automatically.

**Props**

.. list-table::
   :header-rows: 1
   :widths: 20 20 10 50

   * - Prop
     - Type
     - Default
     - Description
   * - ``items``
     - ``TabBarItem[]``
     - required
     - Array of tab items. See :ref:`tab-bar-item`.
   * - ``selectedIndex``
     - ``number``
     - ``0``
     - Controlled selected tab index.
   * - ``translucent``
     - ``boolean``
     - ``true``
     - When true, applies system material blur behind the tab bar.
   * - ``onTabPress``
     - ``(e) => void``
     - —
     - Fired when a tab is tapped. ``e.nativeEvent.index`` is the selected index.

.. note::

   Always set ``height`` in the ``style`` prop. On iPhone with a home indicator the typical height is ``83``–``95`` to account for the safe area. Use ``SafeAreaInsets`` if you need to calculate this dynamically.

**Example**

.. code-block:: tsx

   const [tab, setTab] = React.useState(0);

   <NativeTabBar
     items={[
       { title: 'Home', icon: 'house' },
       { title: 'Search', icon: 'magnifyingglass' },
       { title: 'Library', icon: 'books.vertical' },
       { title: 'Profile', icon: 'person.crop.circle' },
     ]}
     selectedIndex={tab}
     onTabPress={(e) => setTab(e.nativeEvent.index)}
     translucent={true}
     style={{ position: 'absolute', bottom: 0, width: '100%', height: 83 }}
   />

----

NativeGroupedContainer
-----------------------

A plain ``UIView`` with ``systemGroupedBackground`` applied. Use it as a section background, matching the look of grouped settings tables.

Default size: ``overflow: hidden`` applied automatically.

**Props**

.. list-table::
   :header-rows: 1
   :widths: 20 20 10 50

   * - Prop
     - Type
     - Default
     - Description
   * - ``insetGrouped``
     - ``boolean``
     - ``false``
     - When true, uses ``systemGroupedBackground`` (same as the inset grouped table style). When false, uses the plain grouped background.

**Example**

.. code-block:: tsx

   <NativeGroupedContainer
     insetGrouped={true}
     style={{ flex: 1 }}
   >
     <NativeCardContainer cornerRadius={10} style={{ margin: 16 }}>
       {/* card contents */}
     </NativeCardContainer>
   </NativeGroupedContainer>

----

NativeCardContainer
-------------------

A ``UIView`` with ``secondarySystemGroupedBackground`` and a continuous corner radius. Matches the card cells in Settings, Contacts, and other system apps.

Default size: ``overflow: hidden`` applied automatically.

**Props**

.. list-table::
   :header-rows: 1
   :widths: 20 20 10 50

   * - Prop
     - Type
     - Default
     - Description
   * - ``cornerRadius``
     - ``number``
     - ``10``
     - Corner radius in points. Uses ``CALayer.cornerCurve = .continuous``.

**Example**

.. code-block:: tsx

   <NativeCardContainer
     cornerRadius={12}
     style={{ margin: 16, padding: 16 }}
   >
     <Text style={{ fontSize: 17 }}>Card title</Text>
     <Text style={{ color: '#8e8e93' }}>Supporting text</Text>
   </NativeCardContainer>

----

NativeStackView
---------------

Wraps ``UIStackView``. Arranges its children along a vertical or horizontal axis. Layout is entirely prop-driven — no default size or spacing is applied.

**Props**

.. list-table::
   :header-rows: 1
   :widths: 20 20 10 50

   * - Prop
     - Type
     - Default
     - Description
   * - ``axis``
     - ``'vertical' | 'horizontal'``
     - ``'vertical'``
     - The layout direction.
   * - ``spacing``
     - ``number``
     - ``0``
     - Points of spacing between arranged subviews.
   * - ``alignment``
     - ``StackAlignment``
     - ``'fill'``
     - Cross-axis alignment. See :ref:`stack-alignment`.
   * - ``distribution``
     - ``StackDistribution``
     - ``'fill'``
     - How arranged views are distributed along the axis. See :ref:`stack-distribution`.

**Example**

.. code-block:: tsx

   <NativeStackView
     axis="vertical"
     spacing={12}
     alignment="fill"
     style={{ width: '100%' }}
   >
     <NativeButton title="First" buttonStyle="filled" />
     <NativeButton title="Second" buttonStyle="gray" />
   </NativeStackView>

----

NativeMenuButton
----------------

A standalone ``UIButton`` that shows a ``UIMenu`` on press. Unlike ``NativeToolbarMenu``, this works anywhere in your layout — no ``NativeToolbar`` required.

No default size applied; size it via the ``style`` prop.

**Props**

.. list-table::
   :header-rows: 1
   :widths: 20 20 10 50

   * - Prop
     - Type
     - Default
     - Description
   * - ``menuItems``
     - ``ToolbarMenuItem[]``
     - required
     - Array of menu items. See :ref:`toolbar-menu-item`.
   * - ``icon``
     - ``string``
     - —
     - SF Symbols name for the button icon.
   * - ``tintColorHex``
     - ``string``
     - system tint
     - Icon/label tint color as a hex string (e.g. ``'#FF3B30'``).
   * - ``onMenuAction``
     - ``(e) => void``
     - —
     - Fired when a menu item is selected. ``e.nativeEvent.id`` and ``e.nativeEvent.title`` identify the item.

**Example**

.. code-block:: tsx

   <NativeMenuButton
     icon="ellipsis.circle"
     tintColorHex="#007AFF"
     menuItems={[
       { id: 'edit', title: 'Edit', icon: 'pencil' },
       { id: 'delete', title: 'Delete', icon: 'trash', destructive: true },
     ]}
     onMenuAction={(e) => handleAction(e.nativeEvent.id)}
     style={{ width: 44, height: 44 }}
   />
