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
            // Wire the button to call our onButtonPress instead of its own
            buttonContainer.parentToolbar = self
            buttonContainers.append(buttonContainer)
            updateToolbarItems()
        } else if let menuContainer = subview as? NativeToolbarMenuContainer {
            // Wire the menu to call our onMenuAction instead of its own
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
    
    // Called by child NativeToolbarButtonContainer
    func dispatchButtonPress(_ data: [String: Any]) {
        DispatchQueue.main.async { [weak self] in
            self?.onToolbarButtonPress?(data)
        }
    }
    
    // Called by child NativeToolbarMenuContainer
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
