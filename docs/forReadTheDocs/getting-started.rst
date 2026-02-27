Getting Started
===============

Requirements
------------

- macOS with Xcode 11+
- React Native 0.65.0+
- iOS deployment target 13.0+
- CocoaPods

Installation
------------

.. code-block:: bash

   npm install liquid-react
   # or
   yarn add liquid-react

Then link the native module:

.. code-block:: bash

   cd ios && pod install

Rebuild your app after pod install:

.. code-block:: bash

   npm run ios

That's it. No extra native configuration needed.

First Component
---------------

.. code-block:: tsx

   import React from 'react';
   import { SafeAreaView, StyleSheet } from 'react-native';
   import { NativeButton } from 'liquid-react';

   export default function App() {
     return (
       <SafeAreaView style={styles.container}>
         <NativeButton
           title="Hello, UIKit"
           buttonStyle="filled"
           onPress={() => console.log('pressed')}
           style={{ width: 200 }}
         />
       </SafeAreaView>
     );
   }

   const styles = StyleSheet.create({
     container: { flex: 1, justifyContent: 'center', alignItems: 'center' },
   });

iOS Version Behavior
--------------------

All components work on iOS 13+, but visual rendering depends on the iOS version:

- **iOS 26+** — full Liquid Glass rendering, identical to Apple's own apps
- **iOS 13-18** — real native UIKit components, system appearance for that iOS version (no Liquid Glass, but still authentic native rendering)

The library never simulates anything. Whatever iOS renders is what you get.

Platform Guard
--------------

liquid-react is iOS-only. If your project targets multiple platforms, guard usage:

.. code-block:: tsx

   import { Platform } from 'react-native';

   function MyComponent() {
     if (Platform.OS !== 'ios') {
       return <View style={styles.fallback} />;
     }
     return <NativeMaterialView material="systemMaterial" style={{ flex: 1 }} />;
   }

Or use React Native's platform file extensions (``MyComponent.ios.tsx``, ``MyComponent.android.tsx``).

Troubleshooting
---------------

**Module not found / symbols not linked**
   Run ``cd ios && pod install``, then rebuild.

**Build errors after updating**
   Clean the pods and reinstall:

   .. code-block:: bash

      cd ios
      rm -rf Pods Podfile.lock
      pod install

**Blur not visible**
   Make sure the parent view has a non-zero frame and you're running on a simulator or device (not just doing a type check). ``NativeMaterialView`` requires a real rendering context.

**npm install peer dependency errors**
   If you're on React Native 0.84+ with ``@types/react@18``, use:

   .. code-block:: bash

      npm install --legacy-peer-deps
