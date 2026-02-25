/**
 * Registers native UIKit view managers with React Native's requireNativeComponent.
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

// On web, requireNativeComponent doesn't exist - fall back to View.
// eslint-disable-next-line @typescript-eslint/no-explicit-any
const req = Platform.OS === 'web' ? () => View as any : requireNativeComponent;

export const RNNativeMaterialView = req<NativeMaterialViewProps>('LRNativeMaterialView');
export const RNNativeButton = req<NativeButtonProps>('LRNativeButton');
export const RNNativeSwitch = req<NativeSwitchProps>('LRNativeSwitch');
export const RNNativeSegmentedControl = req<NativeSegmentedControlProps>(
  'LRNativeSegmentedControl',
);
export const RNNativeSearchBar = req<NativeSearchBarProps>('LRNativeSearchBar');
export const RNNativeNavigationBar = req<NativeNavigationBarProps>('LRNativeNavigationBar');
export const RNNativeToolbar = req<NativeToolbarProps>('LRNativeToolbar');
export const RNNativeToolbarButton = req<NativeToolbarButtonProps>('LRNativeToolbarButton');
export const RNNativeToolbarMenu = req<NativeToolbarMenuProps>('LRNativeToolbarMenu');
export const RNNativeTabBar = req<NativeTabBarProps>('LRNativeTabBar');
export const RNNativeGroupedContainer = req<NativeGroupedContainerProps>(
  'LRNativeGroupedContainer',
);
export const RNNativeCardContainer = req<NativeCardContainerProps>('LRNativeCardContainer');
export const RNNativeStackView = req<NativeStackViewProps>('LRNativeStackView');
export const RNNativeMenuButton = req<NativeMenuButtonProps>('LRNativeMenuButton');
