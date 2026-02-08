import { requireNativeComponent } from 'react-native';
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
} from './types';

// Native component registration
export const RNNativeMaterialView = requireNativeComponent<NativeMaterialViewProps>('LRNativeMaterialView');
export const RNNativeButton = requireNativeComponent<NativeButtonProps>('LRNativeButton');
export const RNNativeSwitch = requireNativeComponent<NativeSwitchProps>('LRNativeSwitch');
export const RNNativeSegmentedControl = requireNativeComponent<NativeSegmentedControlProps>('LRNativeSegmentedControl');
export const RNNativeSearchBar = requireNativeComponent<NativeSearchBarProps>('LRNativeSearchBar');
export const RNNativeNavigationBar = requireNativeComponent<NativeNavigationBarProps>('LRNativeNavigationBar');
export const RNNativeToolbar = requireNativeComponent<NativeToolbarProps>('LRNativeToolbar');
export const RNNativeToolbarButton = requireNativeComponent<NativeToolbarButtonProps>('LRNativeToolbarButton');
export const RNNativeToolbarMenu = requireNativeComponent<NativeToolbarMenuProps>('LRNativeToolbarMenu');
export const RNNativeTabBar = requireNativeComponent<NativeTabBarProps>('LRNativeTabBar');
export const RNNativeGroupedContainer = requireNativeComponent<NativeGroupedContainerProps>('LRNativeGroupedContainer');
export const RNNativeCardContainer = requireNativeComponent<NativeCardContainerProps>('LRNativeCardContainer');
export const RNNativeStackView = requireNativeComponent<NativeStackViewProps>('LRNativeStackView');
