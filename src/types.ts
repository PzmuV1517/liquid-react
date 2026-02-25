/**
 * TypeScript prop types and event payload types for all liquid-react native components.
 *
 *
 * MIT License
 *
 * Copyright (c) 2026 Banu Andrei & Mircea Levin-Constantin
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
import { ViewProps } from 'react-native';
import type {
  BubblingEventHandler,
  DirectEventHandler,
} from 'react-native/Libraries/Types/CodegenTypes';

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
  onPress?: BubblingEventHandler<Record<string, never>>;
}

export interface NativeButtonProps extends ViewProps {
  title: string;
  buttonStyle?: ButtonStyle;
  onPress?: BubblingEventHandler<Record<string, never>>;
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
  onCancelPressed?: DirectEventHandler<Record<string, never>>;
}

export interface NativeNavigationBarProps extends ViewProps {
  title?: string;
  translucent?: boolean;
}

export interface NativeToolbarProps extends ViewProps {
  translucent?: boolean;
  children?: React.ReactNode;
}

export interface NativeToolbarButtonProps extends ViewProps {
  icon?: string;
  title?: string;
  systemItem?: ToolbarSystemItem;
  disabled?: boolean;
  onPress?: BubblingEventHandler<Record<string, never>>;
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
export type StackAlignment =
  | 'fill'
  | 'leading'
  | 'trailing'
  | 'center'
  | 'firstBaseline'
  | 'lastBaseline';
export type StackDistribution =
  | 'fill'
  | 'fillEqually'
  | 'fillProportionally'
  | 'equalSpacing'
  | 'equalCentering';

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
