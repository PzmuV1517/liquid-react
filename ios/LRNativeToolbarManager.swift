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
        // Collect button and menu containers
        if let buttonContainer = subview as? NativeToolbarButtonContainer {
            buttonContainers.append(buttonContainer)
            updateToolbarItems()
        } else if let menuContainer = subview as? NativeToolbarMenuContainer {
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
    
    private func updateToolbarItems() {
        var barButtonItems: [UIBarButtonItem] = []
        
        // Add all button items
        for container in buttonContainers {
            barButtonItems.append(container.barButtonItem)
        }
        
        // Add all menu items
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
