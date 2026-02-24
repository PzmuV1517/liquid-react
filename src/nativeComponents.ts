import { Platform, requireNativeComponent, View } from 'react-native';
import type {
  NativeMaterialViewProps,
  NativeButtonProps,
  NativeSwitchProps,
  NativeSegmentedControlProps,
  NativeSearchBarProps,
  NativeNavigationBarProps,
  NativeToolbarProps,
  NativeToolbarButtonProps,
  NativeToolbarMenuProps,
  NativeTabBarProps,
  NativeGroupedContainerProps,
  NativeCardContainerProps,
  NativeStackViewProps,
  NativeMenuButtonProps,
} from './types';

// On web, requireNativeComponent doesn't exist — fall back to View.
const req = Platform.OS === 'web'
  ? () => View as unknown
  : requireNativeComponent;

// Native component registration
export const RNNativeMaterialView = req<NativeMaterialViewProps>('LRNativeMaterialView');
export const RNNativeButton = req<NativeButtonProps>('LRNativeButton');
export const RNNativeSwitch = req<NativeSwitchProps>('LRNativeSwitch');
export const RNNativeSegmentedControl = req<NativeSegmentedControlProps>('LRNativeSegmentedControl');
export const RNNativeSearchBar = req<NativeSearchBarProps>('LRNativeSearchBar');
export const RNNativeNavigationBar = req<NativeNavigationBarProps>('LRNativeNavigationBar');
export const RNNativeToolbar = req<NativeToolbarProps>('LRNativeToolbar');
export const RNNativeToolbarButton = req<NativeToolbarButtonProps>('LRNativeToolbarButton');
export const RNNativeToolbarMenu = req<NativeToolbarMenuProps>('LRNativeToolbarMenu');
export const RNNativeTabBar = req<NativeTabBarProps>('LRNativeTabBar');
export const RNNativeGroupedContainer = req<NativeGroupedContainerProps>('LRNativeGroupedContainer');
export const RNNativeCardContainer = req<NativeCardContainerProps>('LRNativeCardContainer');
export const RNNativeStackView = req<NativeStackViewProps>('LRNativeStackView');
export const RNNativeMenuButton = req<NativeMenuButtonProps>('LRNativeMenuButton');
