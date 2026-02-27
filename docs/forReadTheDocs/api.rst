API Reference
=============

Complete type reference for all props, event payloads, and enum values exported by liquid-react.

.. contents:: On this page
   :local:
   :depth: 1

----

.. _material-types:

MaterialType
------------

Controls which ``UIVisualEffectView`` material is applied to ``NativeMaterialView``.

.. code-block:: typescript

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

The first five values are adaptive (they respond to light/dark mode automatically). The ``Light`` and ``Dark`` suffixed variants lock the material to that appearance regardless of the system setting.

**Adaptive materials (lightest to heaviest)**

.. list-table::
   :header-rows: 1
   :widths: 40 60

   * - Value
     - Description
   * - ``systemUltraThinMaterial``
     - Very subtle blur, nearly transparent.
   * - ``systemThinMaterial``
     - Light blur, slightly more opaque.
   * - ``systemMaterial``
     - Standard system material — used in sheets, cards, popovers.
   * - ``systemThickMaterial``
     - Heavier blur, more opaque.
   * - ``systemChromeMaterial``
     - Heaviest blur, used in chrome areas like tab bars.

----

.. _button-styles:

ButtonStyle
-----------

Maps to ``UIButton.Configuration`` button styles.

.. code-block:: typescript

   type ButtonStyle =
     | 'filled'
     | 'gray'
     | 'tinted'
     | 'plain'
     | 'bordered'
     | 'borderedTinted'
     | 'borderedProminent';

.. list-table::
   :header-rows: 1
   :widths: 25 75

   * - Value
     - Description
   * - ``filled``
     - Solid background in the tint color. Primary action button.
   * - ``gray``
     - Gray background. Secondary action.
   * - ``tinted``
     - Tinted background (lighter than filled).
   * - ``plain``
     - No background, just the label. Tertiary action.
   * - ``bordered``
     - Outlined border.
   * - ``borderedTinted``
     - Outlined border with tinted text.
   * - ``borderedProminent``
     - Prominent bordered style.

----

.. _toolbar-system-items:

ToolbarSystemItem
-----------------

Maps to ``UIBarButtonItem.SystemItem``. Used on ``NativeToolbarButton``.

.. code-block:: typescript

   type ToolbarSystemItem =
     | 'done' | 'cancel' | 'edit' | 'save' | 'add'
     | 'flexibleSpace' | 'fixedSpace'
     | 'compose' | 'reply' | 'action' | 'organize'
     | 'bookmarks' | 'search' | 'refresh' | 'stop'
     | 'camera' | 'trash' | 'play' | 'pause'
     | 'rewind' | 'fastForward' | 'undo' | 'redo' | 'close';

``flexibleSpace`` and ``fixedSpace`` are layout items — they don't fire ``onPress``. ``flexibleSpace`` expands to fill available space; ``fixedSpace`` is a fixed-size gap.

----

.. _toolbar-menu-item:

ToolbarMenuItem
---------------

Used in the ``menuItems`` prop of ``NativeToolbarMenu`` and ``NativeMenuButton``. Items can be nested to create submenus.

.. code-block:: typescript

   interface ToolbarMenuItem {
     id?: string;
     title: string;
     icon?: string;
     destructive?: boolean;
     disabled?: boolean;
     children?: ToolbarMenuItem[];
   }

.. list-table::
   :header-rows: 1
   :widths: 20 20 60

   * - Field
     - Type
     - Description
   * - ``id``
     - ``string``
     - Identifier returned in ``onMenuAction``. Defaults to ``title`` if omitted.
   * - ``title``
     - ``string``
     - Display label. Required.
   * - ``icon``
     - ``string``
     - SF Symbols name (e.g. ``'trash'``, ``'star.fill'``).
   * - ``destructive``
     - ``boolean``
     - Renders the item in red with the ``UIMenuElement.Attributes.destructive`` attribute.
   * - ``disabled``
     - ``boolean``
     - Grays out the item and prevents selection.
   * - ``children``
     - ``ToolbarMenuItem[]``
     - Child items that form a submenu. UIKit renders this as a nested ``UIMenu``.

----

.. _tab-bar-item:

TabBarItem
----------

Used in the ``items`` prop of ``NativeTabBar``.

.. code-block:: typescript

   interface TabBarItem {
     title: string;
     icon?: string;
     systemItem?: TabBarSystemItem;
   }

If ``systemItem`` is provided, UIKit uses the system icon and label. ``icon`` is an SF Symbols name and overrides ``systemItem`` when both are set.

**TabBarSystemItem values**

.. code-block:: typescript

   type TabBarSystemItem =
     | 'more' | 'favorites' | 'featured' | 'topRated'
     | 'recents' | 'contacts' | 'history' | 'bookmarks'
     | 'search' | 'downloads' | 'mostRecent' | 'mostViewed';

----

.. _stack-alignment:

StackAlignment
--------------

Cross-axis alignment for ``NativeStackView``. Maps directly to ``UIStackView.Alignment``.

.. code-block:: typescript

   type StackAlignment =
     | 'fill'
     | 'leading'
     | 'trailing'
     | 'center'
     | 'firstBaseline'
     | 'lastBaseline';

``firstBaseline`` and ``lastBaseline`` apply only to horizontal stacks.

----

.. _stack-distribution:

StackDistribution
-----------------

How the stack distributes arranged views along its axis. Maps to ``UIStackView.Distribution``.

.. code-block:: typescript

   type StackDistribution =
     | 'fill'
     | 'fillEqually'
     | 'fillProportionally'
     | 'equalSpacing'
     | 'equalCentering';

.. list-table::
   :header-rows: 1
   :widths: 30 70

   * - Value
     - Description
   * - ``fill``
     - One view expands to fill remaining space.
   * - ``fillEqually``
     - All views are the same size.
   * - ``fillProportionally``
     - Views are sized proportionally to their intrinsic content size.
   * - ``equalSpacing``
     - Views have equal spacing between them.
   * - ``equalCentering``
     - Views are centered with equal space between their centers.

----

Event Payloads
--------------

Events follow the React Native native event pattern: the handler receives ``(e: { nativeEvent: T })``.

.. list-table::
   :header-rows: 1
   :widths: 40 60

   * - Event
     - ``e.nativeEvent`` shape
   * - ``NativeButton.onPress``
     - ``{}``
   * - ``NativeMaterialView.onPress``
     - ``{}``
   * - ``NativeSwitch.onValueChange``
     - ``{ value: boolean }``
   * - ``NativeSegmentedControl.onValueChange``
     - ``{ selectedIndex: number }``
   * - ``NativeSearchBar.onTextChanged``
     - ``{ text: string }``
   * - ``NativeSearchBar.onSearchPressed``
     - ``{ text: string }``
   * - ``NativeSearchBar.onCancelPressed``
     - ``{}``
   * - ``NativeTabBar.onTabPress``
     - ``{ index: number }``
   * - ``NativeToolbarButton.onPress``
     - ``{}``
   * - ``NativeToolbarMenu.onMenuAction``
     - ``{ id: string; title: string }``
   * - ``NativeMenuButton.onMenuAction``
     - ``{ id: string; title: string }``

----

Default Sizes
-------------

These sizes are applied automatically unless you override them via the ``style`` prop.

.. list-table::
   :header-rows: 1
   :widths: 40 60

   * - Component
     - Default style
   * - ``NativeButton``
     - ``height: 44``
   * - ``NativeSegmentedControl``
     - ``height: 32``
   * - ``NativeSearchBar``
     - ``height: 56``
   * - ``NativeNavigationBar``
     - ``height: 44``
   * - ``NativeToolbar``
     - ``height: 44``
   * - ``NativeTabBar``
     - ``height: 49``
   * - ``NativeMaterialView``
     - ``overflow: 'hidden'``
   * - ``NativeGroupedContainer``
     - ``overflow: 'hidden'``
   * - ``NativeCardContainer``
     - ``overflow: 'hidden'``
   * - ``NativeSwitch``
     - intrinsic size (no override)
   * - ``NativeToolbarButton``
     - intrinsic size (no override)
   * - ``NativeToolbarMenu``
     - intrinsic size (no override)
   * - ``NativeMenuButton``
     - no default (set via ``style``)
   * - ``NativeStackView``
     - no default (fully prop-driven)

----

Known Limitations
-----------------

- **iOS only.** Android and web are not supported. The native module will not load on other platforms.
- **No Auto Layout.** React Native uses frame-based layout. Components must be given a frame via the ``style`` prop or a flex parent.
- **System-controlled colors.** Background colors, blur effect colors, and tint colors are managed by iOS. You can't override the material color.
- **No custom blur intensity.** Apple's ``UIVisualEffectView`` does not expose blur radius as a public API.
- **NativeMaterialView children broken.** See the component docs. The blur renders correctly but RN children are not visible inside it.
- **NativeSegmentedControl Liquid Glass.** The selection indicator doesn't persist visually due to a UIKit material environment limitation when bridged.

App Store Compliance
--------------------

liquid-react uses **only public Apple APIs**. No private frameworks, no runtime injection, no reverse-engineered internals. It is safe to ship in App Store builds.
