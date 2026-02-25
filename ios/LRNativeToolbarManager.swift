/**
 * RCT view manager and UIView for NativeToolbar, bridging UIToolbar.
 * Accepts NativeToolbarButton and NativeToolbarMenu as React children.
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
import Foundation
import UIKit
import React

@objc(LRNativeToolbarManager)
class LRNativeToolbarManager: RCTViewManager {

    override func view() -> UIView! {
        return NativeToolbar()
    }

    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeToolbar: UIView {

    private var toolbar: UIToolbar!
    private var buttonContainers: [NativeToolbarButtonContainer] = []
    private var menuContainers: [NativeToolbarMenuContainer] = []

    // Event blocks dispatched from the toolbar (visible view) so RN receives them
    @objc var onToolbarButtonPress: RCTDirectEventBlock?
    @objc var onToolbarMenuAction: RCTDirectEventBlock?

    @objc var translucent: Bool = true {
        didSet {
            toolbar.isTranslucent = translucent
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupToolbar()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupToolbar()
    }

    private func setupToolbar() {
        toolbar = UIToolbar()
        toolbar.isTranslucent = true
        addSubview(toolbar)
    }

    override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
        if let buttonContainer = subview as? NativeToolbarButtonContainer {
            // routes events through the toolbar so RN receives them from the visible view
            buttonContainer.parentToolbar = self
            buttonContainers.append(buttonContainer)
            updateToolbarItems()
        } else if let menuContainer = subview as? NativeToolbarMenuContainer {
            // routes events through the toolbar so RN receives them from the visible view
            menuContainer.parentToolbar = self
            menuContainers.append(menuContainer)
            updateToolbarItems()
        }
    }

    override func removeReactSubview(_ subview: UIView!) {
        if let buttonContainer = subview as? NativeToolbarButtonContainer {
            if let index = buttonContainers.firstIndex(of: buttonContainer) {
                buttonContainers.remove(at: index)
                updateToolbarItems()
            }
        } else if let menuContainer = subview as? NativeToolbarMenuContainer {
            if let index = menuContainers.firstIndex(of: menuContainer) {
                menuContainers.remove(at: index)
                updateToolbarItems()
            }
        }
    }

    func dispatchButtonPress(_ data: [String: Any]) {
        DispatchQueue.main.async { [weak self] in
            self?.onToolbarButtonPress?(data)
        }
    }

    func dispatchMenuAction(_ data: [String: Any]) {
        DispatchQueue.main.async { [weak self] in
            self?.onToolbarMenuAction?(data)
        }
    }

    private func updateToolbarItems() {
        var barButtonItems: [UIBarButtonItem] = []

        for container in buttonContainers {
            barButtonItems.append(container.barButtonItem)
        }

        for container in menuContainers {
            barButtonItems.append(container.barButtonItem)
        }

        toolbar.items = barButtonItems
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        toolbar.frame = bounds
    }
}
