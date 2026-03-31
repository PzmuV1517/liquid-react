import React from 'react';
import { StyleSheet } from 'react-native';
import {
  RNNativeMaterialView,
  RNNativeButton,
  RNNativeSwitch,
  RNNativeSegmentedControl,
  RNNativeSearchBar,
  RNNativeNavigationBar,
  RNNativeToolbar,
  RNNativeToolbarButton,
  RNNativeToolbarMenu,
  RNNativeTabBar,
  RNNativeGroupedContainer,
  RNNativeCardContainer,
  RNNativeStackView,
  RNNativeMenuButton,
} from './nativeComponents';
import {
  resolveLiquidReactAppearanceMode,
  useLiquidReactAppearanceMode,
} from './appearance';
import type {
  AppearanceMode,
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

function useResolvedAppearanceMode(appearanceMode: AppearanceMode | undefined): AppearanceMode {
  const inheritedAppearanceMode = useLiquidReactAppearanceMode();
  return resolveLiquidReactAppearanceMode(appearanceMode, inheritedAppearanceMode);
}

/**
 * NativeMaterialView - Exposes UIVisualEffectView with system materials
 * 
 * Uses Apple's blur, vibrancy, and depth rendering pipeline.
 * All visual properties controlled by iOS.
 */
export const NativeMaterialView: React.FC<NativeMaterialViewProps> = (props) => {
  const appearanceMode = useResolvedAppearanceMode(props.appearanceMode);
  return <RNNativeMaterialView {...props} appearanceMode={appearanceMode} style={[styles.defaultContainer, props.style]} />;
};

/**
 * NativeButton - Exposes UIButton with system configurations
 * 
 * Uses native button styles and animations.
 */
export const NativeButton: React.FC<NativeButtonProps> = (props) => {
  const appearanceMode = useResolvedAppearanceMode(props.appearanceMode);
  return <RNNativeButton {...props} appearanceMode={appearanceMode} style={[styles.defaultButton, props.style]} />;
};

/**
 * NativeSwitch - Exposes UISwitch
 * 
 * Native iOS toggle control.
 */
export const NativeSwitch: React.FC<NativeSwitchProps> = (props) => {
  const appearanceMode = useResolvedAppearanceMode(props.appearanceMode);
  return <RNNativeSwitch {...props} appearanceMode={appearanceMode} style={props.style} />;
};

/**
 * NativeSegmentedControl - Exposes UISegmentedControl
 * 
 * Native segmented control with system styling.
 */
export const NativeSegmentedControl: React.FC<NativeSegmentedControlProps> = (props) => {
  const appearanceMode = useResolvedAppearanceMode(props.appearanceMode);
  return <RNNativeSegmentedControl {...props} appearanceMode={appearanceMode} style={[styles.defaultSegmentedControl, props.style]} />;
};

/**
 * NativeSearchBar - Exposes UISearchBar
 * 
 * Native search bar with minimal style.
 */
export const NativeSearchBar: React.FC<NativeSearchBarProps> = (props) => {
  const appearanceMode = useResolvedAppearanceMode(props.appearanceMode);
  return <RNNativeSearchBar {...props} appearanceMode={appearanceMode} style={[styles.defaultSearchBar, props.style]} />;
};

/**
 * NativeNavigationBar - Exposes UINavigationBar
 * 
 * Native navigation bar with translucent material.
 */
export const NativeNavigationBar: React.FC<NativeNavigationBarProps> = (props) => {
  const appearanceMode = useResolvedAppearanceMode(props.appearanceMode);
  return <RNNativeNavigationBar {...props} appearanceMode={appearanceMode} style={[styles.defaultNavigationBar, props.style]} />;
};

/**
 * NativeToolbar - Exposes UIToolbar
 * 
 * Native toolbar with support for buttons and menus as children.
 * Use with NativeToolbarButton and NativeToolbarMenu components.
 */
export const NativeToolbar: React.FC<NativeToolbarProps> = (props) => {
  const appearanceMode = useResolvedAppearanceMode(props.appearanceMode);
  return <RNNativeToolbar {...props} appearanceMode={appearanceMode} style={[styles.defaultToolbar, props.style]} />;
};

/**
 * NativeToolbarButton - Exposes UIBarButtonItem
 * 
 * Native toolbar button. Must be used as a child of NativeToolbar.
 */
export const NativeToolbarButton: React.FC<NativeToolbarButtonProps> = (props) => {
  return <RNNativeToolbarButton {...props} style={props.style} />;
};

/**
 * NativeToolbarMenu - Exposes UIBarButtonItem with UIMenu
 * 
 * Native toolbar menu button with nested menu support.
 * Automatically handles cascading menus, animations, and platform differences.
 * Must be used as a child of NativeToolbar.
 */
export const NativeToolbarMenu: React.FC<NativeToolbarMenuProps> = (props) => {
  return <RNNativeToolbarMenu {...props} style={props.style} />;
};

/**
 * NativeTabBar - Exposes UITabBar
 * 
 * Native tab bar with system styling.
 */
export const NativeTabBar: React.FC<NativeTabBarProps> = (props) => {
  const appearanceMode = useResolvedAppearanceMode(props.appearanceMode);
  return <RNNativeTabBar {...props} appearanceMode={appearanceMode} style={[styles.defaultTabBar, props.style]} />;
};

/**
 * NativeGroupedContainer - UIView with system grouped background
 * 
 * Uses system background colors for grouped list style.
 */
export const NativeGroupedContainer: React.FC<NativeGroupedContainerProps> = (props) => {
  const appearanceMode = useResolvedAppearanceMode(props.appearanceMode);
  return <RNNativeGroupedContainer {...props} appearanceMode={appearanceMode} style={[styles.defaultContainer, props.style]} />;
};

/**
 * NativeCardContainer - UIView with continuous corner radius
 * 
 * System background with native corner curve.
 */
export const NativeCardContainer: React.FC<NativeCardContainerProps> = (props) => {
  const appearanceMode = useResolvedAppearanceMode(props.appearanceMode);
  return <RNNativeCardContainer {...props} appearanceMode={appearanceMode} style={[styles.defaultCard, props.style]} />;
};

/**
 * NativeStackView - Exposes UIStackView for automatic layout
 * 
 * Native iOS stack layout with axis, spacing, alignment, and distribution.
 * Automatically arranges child views without manual positioning.
 */
export const NativeStackView: React.FC<NativeStackViewProps> = (props) => {
  const appearanceMode = useResolvedAppearanceMode(props.appearanceMode);
  return <RNNativeStackView {...props} appearanceMode={appearanceMode} style={[styles.defaultStack, props.style]} />;
};

/**
 * NativeMenuButton - Standalone UIButton with UIMenu pull-down
 * 
 * Shows a native iOS pull-down menu anchored to the button.
 * Works anywhere (no UIToolbar parent required).
 */
export const NativeMenuButton: React.FC<NativeMenuButtonProps> = (props) => {
  const appearanceMode = useResolvedAppearanceMode(props.appearanceMode);
  return <RNNativeMenuButton {...props} appearanceMode={appearanceMode} style={props.style} />;
};

const styles = StyleSheet.create({
  defaultContainer: {
    overflow: 'hidden',
  },
  defaultButton: {
    height: 44,
  },
  defaultSegmentedControl: {
    height: 32,
  },
  defaultSearchBar: {
    height: 56,
  },
  defaultNavigationBar: {
    height: 44,
  },
  defaultToolbar: {
    height: 44,
  },
  defaultTabBar: {
    height: 49,
  },
  defaultCard: {
    overflow: 'hidden',
  },
  defaultStack: {
    // No default styling - controlled by axis, spacing, alignment, distribution props
  },
});
