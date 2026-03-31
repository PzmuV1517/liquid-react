import React, { createContext, useContext } from 'react';
import type { ReactNode } from 'react';
import type { AppearanceMode } from './types';

const LiquidReactAppearanceContext = createContext<AppearanceMode>('auto');

export interface LiquidReactAppearanceProviderProps {
  mode?: AppearanceMode;
  children?: ReactNode;
}

export const LiquidReactAppearanceProvider: React.FC<LiquidReactAppearanceProviderProps> = ({
  mode = 'auto',
  children,
}) => {
  return (
    <LiquidReactAppearanceContext.Provider value={mode}>
      {children}
    </LiquidReactAppearanceContext.Provider>
  );
};

export function useLiquidReactAppearanceMode(): AppearanceMode {
  return useContext(LiquidReactAppearanceContext);
}

export function resolveLiquidReactAppearanceMode(
  localMode: AppearanceMode | undefined,
  inheritedMode: AppearanceMode,
): AppearanceMode {
  return localMode ?? inheritedMode;
}
