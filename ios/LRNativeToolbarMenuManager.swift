import Foundation
import UIKit
import React

@objc(LRNativeToolbarMenuManager)
class LRNativeToolbarMenuManager: RCTViewManager {
    
    override func view() -> UIView! {
        return NativeToolbarMenuContainer()
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeToolbarMenuContainer: UIView {
    
    private(set) var barButtonItem: UIBarButtonItem!
    
    @objc var icon: NSString = "ellipsis" {
        didSet {
            updateButton()
        }
    }
    
    @objc var title: NSString = "" {
        didSet {
            updateButton()
        }
    }
    
    @objc var menuItems: NSArray = [] {
        didSet {
            updateMenu()
        }
    }
    
    @objc var disabled: Bool = false {
        didSet {
            barButtonItem.isEnabled = !disabled
        }
    }
    
    @objc var onMenuAction: RCTBubblingEventBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        self.isHidden = true
        self.frame = CGRect.zero
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        let image = UIImage(systemName: "ellipsis")
        barButtonItem = UIBarButtonItem(image: image, menu: nil)
        updateButton()
    }
    
    private func updateButton() {
        if icon.length > 0 {
            barButtonItem.image = UIImage(systemName: icon as String)
        }
        if title.length > 0 {
            barButtonItem.title = title as String
        }
        barButtonItem.isEnabled = !disabled
    }
    
    private func updateMenu() {
        let menuElements = buildMenuElements(from: menuItems as! [[String: Any]])
        let menu = UIMenu(children: menuElements)
        barButtonItem.menu = menu
    }
    
    private func buildMenuElements(from items: [[String: Any]]) -> [UIMenuElement] {
        var elements: [UIMenuElement] = []
        
        for item in items {
            if let children = item["children"] as? [[String: Any]], !children.isEmpty {
                // This is a submenu
                let title = item["title"] as? String ?? ""
                let image = (item["icon"] as? String).flatMap { UIImage(systemName: $0) }
                let submenuElements = buildMenuElements(from: children)
                let submenu = UIMenu(title: title, image: image, children: submenuElements)
                elements.append(submenu)
            } else {
                // This is a regular action
                let title = item["title"] as? String ?? ""
                let image = (item["icon"] as? String).flatMap { UIImage(systemName: $0) }
                let actionId = item["id"] as? String ?? title
                let isDestructive = item["destructive"] as? Bool ?? false
                let isDisabled = item["disabled"] as? Bool ?? false
                
                var attributes: UIMenuElement.Attributes = []
                if isDestructive {
                    attributes.insert(.destructive)
                }
                if isDisabled {
                    attributes.insert(.disabled)
                }
                
                let action = UIAction(title: title, image: image, attributes: attributes) { [weak self] _ in
                    self?.onMenuAction?(["id": actionId, "title": title])
                }
                elements.append(action)
            }
        }
        
        return elements
    }
}
