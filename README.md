# Liquid-React

## Introduction

**What is Liquid-React?**
Liquid-React is a powerful and flexible React component library that offers native iOS liquid glass components for native iOS applications.
It provides a wide range of customisable components that can be easily integrated into your React projects, allowing you to create stunning user interfaces with ease, each containing many props. Every component is exactly the same as the native iOS liquid glass components.

**Why choose Liquid-React?**
Why should you use liquid-react over other "liquid glass" libraries? Almost all of them are just glass shaders or blur effects that try to mimic the liquid glass effect, but they don't actually use the native iOS liquid glass implementation. 
Our library is a wrapper for the native UIKit liquid glass components and liquid glass material, which means that you get the exact same performance and visual quality in your React native applications as you would on a Swift application.

## Using Liquid-React
To get started with Liquid-React, simply install the library using npm or yarn:

```bash
npm install liquid-react
```
or

```bash
yarn add liquid-react
```

Once you have the library installed, you can import the components you need and start using them in your react application. For example:

```jsx
import { (ENTER NAME OF COMPONENT) } from 'liquid-react';

function App() {
  return (
    <div>
      <(ENTER NAME OF COMPONENT)/>
    </div>
  );
}
```
To use props, simply pass them as you would with any other React component:

```jsx
import { (ENTER NAME OF COMPONENT) } from 'liquid-react';

function App() {
  return (
    <div>
      <(ENTER NAME OF COMPONENT) prop1="value1" prop2="value2" />
    </div>
  );
}
```
Make sure the component you are using supports the props you are passing, and refer to the documentation for more details on available props and their usage.

## Contributing
We welcome contributions to Liquid-React! We try to regularly update the library with new components Apple releases, but because we are also students, we might not always be able to keep up with the pace of Apple's updates. If you want to contribute, please check out our [contributing guidelines](CONTRIBUTING.md) for more information on how to get started.