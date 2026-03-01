import React from 'react';
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

/**
 * Safely resolves a native component by name.
 * On iOS/Android it delegates to requireNativeComponent.
 * On web (Expo Web / react-native-web) no native modules exist, so
 * we fall back to a plain View to avoid a hard crash at module load time.
 */
// eslint-disable-next-line @typescript-eslint/no-explicit-any
function createNativeComponent<T>(name: string): React.ComponentType<T> {
  if (Platform.OS === 'web') {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    return View as unknown as React.ComponentType<T>;
  }
  // HostComponent<T> is React.ComponentClass<T> at runtime; the cast resolves
  // dual-React-types version conflicts between the library and the host app.
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return requireNativeComponent<T>(name) as unknown as React.ComponentType<T>;
}

// Native component registration
export const RNNativeMaterialView = createNativeComponent<NativeMaterialViewProps>('LRNativeMaterialView');
export const RNNativeButton = createNativeComponent<NativeButtonProps>('LRNativeButton');
export const RNNativeSwitch = createNativeComponent<NativeSwitchProps>('LRNativeSwitch');
export const RNNativeSegmentedControl = createNativeComponent<NativeSegmentedControlProps>('LRNativeSegmentedControl');
export const RNNativeSearchBar = createNativeComponent<NativeSearchBarProps>('LRNativeSearchBar');
export const RNNativeNavigationBar = createNativeComponent<NativeNavigationBarProps>('LRNativeNavigationBar');
export const RNNativeToolbar = createNativeComponent<NativeToolbarProps>('LRNativeToolbar');
export const RNNativeToolbarButton = createNativeComponent<NativeToolbarButtonProps>('LRNativeToolbarButton');
export const RNNativeToolbarMenu = createNativeComponent<NativeToolbarMenuProps>('LRNativeToolbarMenu');
export const RNNativeTabBar = createNativeComponent<NativeTabBarProps>('LRNativeTabBar');
export const RNNativeGroupedContainer = createNativeComponent<NativeGroupedContainerProps>('LRNativeGroupedContainer');
export const RNNativeCardContainer = createNativeComponent<NativeCardContainerProps>('LRNativeCardContainer');
export const RNNativeStackView = createNativeComponent<NativeStackViewProps>('LRNativeStackView');
export const RNNativeMenuButton = createNativeComponent<NativeMenuButtonProps>('LRNativeMenuButton');
