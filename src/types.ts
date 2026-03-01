import type { ViewProps } from 'react-native';
import type { ReactNode } from 'react';

type BubblingEventHandler<T> = (event: T) => void;
type DirectEventHandler<T> = (event: T) => void;

// Material types
export type MaterialType =
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

// Button types
export type ButtonStyle =
| 'filled'
| 'gray'
| 'tinted'
| 'plain'
| 'bordered'
| 'borderedTinted'
| 'borderedProminent';

// Toolbar item types
export type ToolbarSystemItem =
| 'done'
| 'cancel'
| 'edit'
| 'save'
| 'add'
| 'flexibleSpace'
| 'fixedSpace'
| 'compose'
| 'reply'
| 'action'
| 'organize'
| 'bookmarks'
| 'search'
| 'refresh'
| 'stop'
| 'camera'
| 'trash'
| 'play'
| 'pause'
| 'rewind'
| 'fastForward'
| 'undo'
| 'redo'
| 'close';

export interface ToolbarMenuItem {
id?: string;
title: string;
icon?: string;
destructive?: boolean;
disabled?: boolean;
children?: ToolbarMenuItem[];
}

export interface ToolbarItem {
  icon?: string;
  title?: string;
  systemItem?: ToolbarSystemItem;
  disabled?: boolean;
}

export interface ToolbarMenuActionEvent {
id: string;
title: string;
}

// TabBar types
export type TabBarSystemItem =
| 'more'
| 'favorites'
| 'featured'
| 'topRated'
| 'recents'
| 'contacts'
| 'history'
| 'bookmarks'
| 'search'
| 'downloads'
| 'mostRecent'
| 'mostViewed';

export interface TabBarItem {
title: string;
icon?: string;
systemItem?: TabBarSystemItem;
}

// Event types
export interface ValueChangeEvent {
value: boolean;
}

export interface SegmentedControlValueChangeEvent {
selectedIndex: number;
}

export interface SearchBarChangeEvent {
text: string;
}

export interface TabBarPressEvent {
index: number;
}

// Component prop types
export interface NativeMaterialViewProps extends ViewProps {
material?: MaterialType;
onPress?: BubblingEventHandler<{}>;
}

export interface NativeButtonProps extends ViewProps {
title: string;
buttonStyle?: ButtonStyle;
onPress?: BubblingEventHandler<{}>;
}

export interface NativeSwitchProps extends ViewProps {
value?: boolean;
onTintColor?: string;
thumbTintColor?: string;
disabled?: boolean;
onValueChange?: BubblingEventHandler<ValueChangeEvent>;
}

export interface NativeSegmentedControlProps extends ViewProps {
segments: string[];
selectedIndex?: number;
onValueChange?: BubblingEventHandler<SegmentedControlValueChangeEvent>;
}

export interface NativeSearchBarProps extends ViewProps {
placeholder?: string;
text?: string;
onTextChanged?: DirectEventHandler<SearchBarChangeEvent>;
onSearchPressed?: DirectEventHandler<SearchBarChangeEvent>;
onCancelPressed?: DirectEventHandler<{}>;
}

export interface NativeNavigationBarProps extends ViewProps {
title?: string;
translucent?: boolean;
}

// Event carrying icon+title of the bar button that was tapped.
export interface ToolbarButtonPressEvent {
  icon: string;
  title: string;
}

export interface NativeToolbarProps extends ViewProps {
  translucent?: boolean;
  children?: ReactNode;
  /** Fires when a NativeToolbarButton child is pressed. */
  onToolbarButtonPress?: DirectEventHandler<ToolbarButtonPressEvent>;
  /** Fires when a NativeToolbarMenu child action is triggered. */
  onToolbarMenuAction?: DirectEventHandler<ToolbarMenuActionEvent>;
}

export interface NativeToolbarButtonProps extends ViewProps {
icon?: string;
title?: string;
systemItem?: ToolbarSystemItem;
disabled?: boolean;
onPress?: BubblingEventHandler<{}>;
}

export interface NativeToolbarMenuProps extends ViewProps {
icon?: string;
title?: string;
menuItems: ToolbarMenuItem[];
disabled?: boolean;
onMenuAction?: BubblingEventHandler<ToolbarMenuActionEvent>;
}

export interface NativeTabBarProps extends ViewProps {
items: TabBarItem[];
selectedIndex?: number;
translucent?: boolean;
onTabPress?: BubblingEventHandler<TabBarPressEvent>;
}

export interface NativeGroupedContainerProps extends ViewProps {
insetGrouped?: boolean;
}

export interface NativeCardContainerProps extends ViewProps {
cornerRadius?: number;
}

// Stack view types
export type StackAxis = 'vertical' | 'horizontal';
export type StackAlignment = 'fill' | 'leading' | 'trailing' | 'center' | 'firstBaseline' | 'lastBaseline';
export type StackDistribution = 'fill' | 'fillEqually' | 'fillProportionally' | 'equalSpacing' | 'equalCentering';

export interface NativeStackViewProps extends ViewProps {
axis?: StackAxis;
spacing?: number;
alignment?: StackAlignment;
distribution?: StackDistribution;
}
export interface NativeMenuButtonProps extends ViewProps {
  icon?: string;
  tintColorHex?: string;
  menuItems: ToolbarMenuItem[];
  onMenuAction?: DirectEventHandler<ToolbarMenuActionEvent>;
}