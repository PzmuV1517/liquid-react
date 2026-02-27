Examples
========

Complete, working patterns for common use cases.

.. contents:: On this page
   :local:
   :depth: 1

----

Settings Screen
---------------

A grouped settings layout using ``NativeGroupedContainer``, ``NativeCardContainer``, and native controls.

.. code-block:: tsx

   import React, { useState } from 'react';
   import { ScrollView, Text, StyleSheet } from 'react-native';
   import {
     NativeGroupedContainer,
     NativeCardContainer,
     NativeSwitch,
     NativeSegmentedControl,
   } from 'liquid-react';

   export default function SettingsScreen() {
     const [notifications, setNotifications] = useState(true);
     const [haptics, setHaptics] = useState(false);
     const [theme, setTheme] = useState(0);

     return (
       <ScrollView>
         <NativeGroupedContainer insetGrouped={true} style={styles.section}>

           <NativeCardContainer cornerRadius={10} style={styles.card}>
             <Text style={styles.label}>Notifications</Text>
             <NativeSwitch
               value={notifications}
               onValueChange={(e) => setNotifications(e.nativeEvent.value)}
             />
           </NativeCardContainer>

           <NativeCardContainer cornerRadius={10} style={styles.card}>
             <Text style={styles.label}>Haptics</Text>
             <NativeSwitch
               value={haptics}
               onValueChange={(e) => setHaptics(e.nativeEvent.value)}
             />
           </NativeCardContainer>

         </NativeGroupedContainer>

         <NativeGroupedContainer insetGrouped={true} style={styles.section}>
           <NativeCardContainer cornerRadius={10} style={styles.card}>
             <Text style={styles.label}>Appearance</Text>
             <NativeSegmentedControl
               segments={['Light', 'Dark', 'Auto']}
               selectedIndex={theme}
               onValueChange={(e) => setTheme(e.nativeEvent.selectedIndex)}
               style={{ width: 200 }}
             />
           </NativeCardContainer>
         </NativeGroupedContainer>
       </ScrollView>
     );
   }

   const styles = StyleSheet.create({
     section: { marginTop: 20, marginHorizontal: 16 },
     card: {
       flexDirection: 'row',
       justifyContent: 'space-between',
       alignItems: 'center',
       padding: 12,
       marginBottom: 1,
     },
     label: { fontSize: 17 },
   });

----

Toolbar with Buttons and Menu
------------------------------

A toolbar fixed to the bottom of the screen with a mix of system items and a context menu.

.. code-block:: tsx

   import React from 'react';
   import { View, StyleSheet } from 'react-native';
   import {
     NativeToolbar,
     NativeToolbarButton,
     NativeToolbarMenu,
   } from 'liquid-react';

   export default function EditorScreen() {
     const handleAction = (id: string) => {
       switch (id) {
         case 'share': share(); break;
         case 'duplicate': duplicate(); break;
         case 'delete': confirmDelete(); break;
       }
     };

     return (
       <View style={styles.container}>
         {/* ...main content... */}

         <NativeToolbar
           translucent={true}
           style={styles.toolbar}
         >
           <NativeToolbarButton systemItem="add" onPress={addItem} />
           <NativeToolbarButton systemItem="flexibleSpace" />
           <NativeToolbarButton systemItem="undo" onPress={undo} />
           <NativeToolbarButton systemItem="redo" onPress={redo} />
           <NativeToolbarButton systemItem="flexibleSpace" />
           <NativeToolbarMenu
             icon="ellipsis.circle"
             menuItems={[
               { id: 'share', title: 'Share', icon: 'square.and.arrow.up' },
               { id: 'duplicate', title: 'Duplicate', icon: 'doc.on.doc' },
               { id: 'delete', title: 'Delete', icon: 'trash', destructive: true },
             ]}
             onMenuAction={(e) => handleAction(e.nativeEvent.id)}
           />
         </NativeToolbar>
       </View>
     );
   }

   const styles = StyleSheet.create({
     container: { flex: 1 },
     toolbar: {
       position: 'absolute',
       bottom: 0,
       width: '100%',
     },
   });

----

Tab Bar Navigation
------------------

A native tab bar at the bottom of the screen with controlled tab state.

.. code-block:: tsx

   import React, { useState } from 'react';
   import { View, Text, StyleSheet } from 'react-native';
   import { NativeTabBar } from 'liquid-react';

   const TABS = [
     { title: 'Home', icon: 'house' },
     { title: 'Search', icon: 'magnifyingglass' },
     { title: 'Library', icon: 'books.vertical' },
     { title: 'Profile', icon: 'person.crop.circle' },
   ];

   const SCREENS = ['Home', 'Search', 'Library', 'Profile'];

   export default function RootNavigator() {
     const [tab, setTab] = useState(0);

     return (
       <View style={styles.container}>
         <View style={styles.content}>
           <Text style={styles.heading}>{SCREENS[tab]}</Text>
         </View>

         <NativeTabBar
           items={TABS}
           selectedIndex={tab}
           onTabPress={(e) => setTab(e.nativeEvent.index)}
           translucent={true}
           style={styles.tabBar}
         />
       </View>
     );
   }

   const styles = StyleSheet.create({
     container: { flex: 1 },
     content: { flex: 1, justifyContent: 'center', alignItems: 'center' },
     heading: { fontSize: 28, fontWeight: '700' },
     tabBar: {
       position: 'absolute',
       bottom: 0,
       width: '100%',
       height: 83,
     },
   });

----

Search Interface
----------------

A search bar wired to a filtered list.

.. code-block:: tsx

   import React, { useState, useMemo } from 'react';
   import { FlatList, Text, StyleSheet } from 'react-native';
   import { NativeSearchBar } from 'liquid-react';

   const DATA = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig'];

   export default function SearchScreen() {
     const [query, setQuery] = useState('');

     const results = useMemo(
       () => DATA.filter((item) => item.toLowerCase().includes(query.toLowerCase())),
       [query],
     );

     return (
       <>
         <NativeSearchBar
           placeholder="Search fruit..."
           text={query}
           onTextChanged={(e) => setQuery(e.nativeEvent.text)}
           onCancelPressed={() => setQuery('')}
           style={styles.searchBar}
         />
         <FlatList
           data={results}
           keyExtractor={(item) => item}
           renderItem={({ item }) => <Text style={styles.row}>{item}</Text>}
         />
       </>
     );
   }

   const styles = StyleSheet.create({
     searchBar: { width: '100%' },
     row: { padding: 16, fontSize: 17 },
   });

----

Context Menu Button
-------------------

A ``NativeMenuButton`` placed inline (no toolbar needed).

.. code-block:: tsx

   import React from 'react';
   import { View, Text, StyleSheet } from 'react-native';
   import { NativeMenuButton } from 'liquid-react';

   export default function ListItem({ onEdit, onDelete }: Props) {
     const handleAction = (id: string) => {
       if (id === 'edit') onEdit();
       if (id === 'delete') onDelete();
     };

     return (
       <View style={styles.row}>
         <Text style={styles.label}>My Item</Text>
         <NativeMenuButton
           icon="ellipsis"
           menuItems={[
             { id: 'edit', title: 'Edit', icon: 'pencil' },
             { id: 'delete', title: 'Delete', icon: 'trash', destructive: true },
           ]}
           onMenuAction={(e) => handleAction(e.nativeEvent.id)}
           style={styles.button}
         />
       </View>
     );
   }

   const styles = StyleSheet.create({
     row: {
       flexDirection: 'row',
       alignItems: 'center',
       justifyContent: 'space-between',
       paddingHorizontal: 16,
       paddingVertical: 12,
     },
     label: { fontSize: 17 },
     button: { width: 44, height: 44 },
   });

----

Stack Layout
------------

A vertically arranged set of buttons using ``NativeStackView``.

.. code-block:: tsx

   import React from 'react';
   import { NativeStackView, NativeButton } from 'liquid-react';

   export default function ActionSheet() {
     return (
       <NativeStackView
         axis="vertical"
         spacing={8}
         alignment="fill"
         style={{ width: '100%', padding: 16 }}
       >
         <NativeButton title="Save" buttonStyle="filled" onPress={save} />
         <NativeButton title="Save as Draft" buttonStyle="gray" onPress={saveDraft} />
         <NativeButton title="Discard" buttonStyle="plain" onPress={discard} />
       </NativeStackView>
     );
   }

----

Material Types Comparison
--------------------------

All five adaptive materials side by side.

.. code-block:: tsx

   import React from 'react';
   import { View, Text, ImageBackground, StyleSheet } from 'react-native';
   import { NativeMaterialView } from 'liquid-react';

   const MATERIALS = [
     'systemUltraThinMaterial',
     'systemThinMaterial',
     'systemMaterial',
     'systemThickMaterial',
     'systemChromeMaterial',
   ] as const;

   export default function MaterialShowcase() {
     return (
       <ImageBackground source={{ uri: 'https://picsum.photos/400/800' }} style={styles.bg}>
         <View style={styles.grid}>
           {MATERIALS.map((mat) => (
             <NativeMaterialView key={mat} material={mat} style={styles.chip}>
               {/* children broken — label placed outside for now */}
             </NativeMaterialView>
           ))}
         </View>
       </ImageBackground>
     );
   }

   const styles = StyleSheet.create({
     bg: { flex: 1, justifyContent: 'center', alignItems: 'center' },
     grid: { gap: 12 },
     chip: { width: 260, height: 60, borderRadius: 12 },
   });

.. note::

   ``NativeMaterialView`` children are currently broken — child views don't render inside the blur view. The blur itself is visible. Track progress on this at the GitHub issues page.

----

Platform Guard Pattern
-----------------------

Safely rendering liquid-react components only on iOS.

.. code-block:: tsx

   import React from 'react';
   import { Platform, View, StyleSheet } from 'react-native';
   import { NativeButton } from 'liquid-react';

   export default function PlatformAwareButton({ onPress }: { onPress: () => void }) {
     if (Platform.OS !== 'ios') {
       return (
         <View style={styles.fallback}>
           {/* use a cross-platform button here */}
         </View>
       );
     }

     return (
       <NativeButton
         title="Continue"
         buttonStyle="filled"
         onPress={onPress}
         style={{ width: '100%' }}
       />
     );
   }

   const styles = StyleSheet.create({
     fallback: { height: 44, backgroundColor: '#007AFF', borderRadius: 10 },
   });
