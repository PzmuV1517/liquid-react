/**
 * React component wrappers around native UIKit bridges.
 * Each component applies default sizing and passes props to the native layer.
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

/** Wraps UIVisualEffectView with system blur materials. ⚠️ Currently broken — RN children don't render inside it. */
export const NativeMaterialView: React.FC<NativeMaterialViewProps> = (props) => {
  return <RNNativeMaterialView {...props} style={[styles.defaultContainer, props.style]} />;
};

/** Wraps UIButton with system button configurations. */
export const NativeButton: React.FC<NativeButtonProps> = (props) => {
  return <RNNativeButton {...props} style={[styles.defaultButton, props.style]} />;
};

/** Wraps UISwitch. */
export const NativeSwitch: React.FC<NativeSwitchProps> = (props) => {
  return <RNNativeSwitch {...props} style={props.style} />;
};

/** Wraps UISegmentedControl. Note: liquid glass selection rendering is unreliable when bridged into React Native. */
export const NativeSegmentedControl: React.FC<NativeSegmentedControlProps> = (props) => {
  return (
    <RNNativeSegmentedControl {...props} style={[styles.defaultSegmentedControl, props.style]} />
  );
};

/** Wraps UISearchBar. */
export const NativeSearchBar: React.FC<NativeSearchBarProps> = (props) => {
  return <RNNativeSearchBar {...props} style={[styles.defaultSearchBar, props.style]} />;
};

/** Wraps UINavigationBar. */
export const NativeNavigationBar: React.FC<NativeNavigationBarProps> = (props) => {
  return <RNNativeNavigationBar {...props} style={[styles.defaultNavigationBar, props.style]} />;
};

/** Wraps UIToolbar. Use NativeToolbarButton and NativeToolbarMenu as children. */
export const NativeToolbar: React.FC<NativeToolbarProps> = (props) => {
  return <RNNativeToolbar {...props} style={[styles.defaultToolbar, props.style]} />;
};

/** Wraps UIBarButtonItem. Must be a direct child of NativeToolbar. */
export const NativeToolbarButton: React.FC<NativeToolbarButtonProps> = (props) => {
  return <RNNativeToolbarButton {...props} style={props.style} />;
};

/** Wraps UIBarButtonItem with UIMenu. Supports nested submenus. Must be a direct child of NativeToolbar. */
export const NativeToolbarMenu: React.FC<NativeToolbarMenuProps> = (props) => {
  return <RNNativeToolbarMenu {...props} style={props.style} />;
};

/** Wraps UITabBar. Set height explicitly via the style prop. */
export const NativeTabBar: React.FC<NativeTabBarProps> = (props) => {
  return <RNNativeTabBar {...props} style={[styles.defaultTabBar, props.style]} />;
};

/** UIView with systemGroupedBackground color. */
export const NativeGroupedContainer: React.FC<NativeGroupedContainerProps> = (props) => {
  return <RNNativeGroupedContainer {...props} style={[styles.defaultContainer, props.style]} />;
};

/** UIView with secondary system grouped background and continuous corner radius. */
export const NativeCardContainer: React.FC<NativeCardContainerProps> = (props) => {
  return <RNNativeCardContainer {...props} style={[styles.defaultCard, props.style]} />;
};

/** Wraps UIStackView. Arranges children along a vertical or horizontal axis. */
export const NativeStackView: React.FC<NativeStackViewProps> = (props) => {
  return <RNNativeStackView {...props} style={[styles.defaultStack, props.style]} />;
};

/** Standalone UIButton that shows a UIMenu on press. Works anywhere — no NativeToolbar required. */
export const NativeMenuButton: React.FC<NativeMenuButtonProps> = (props) => {
  return <RNNativeMenuButton {...props} style={props.style} />;
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
    // layout is fully prop-driven
  },
});
