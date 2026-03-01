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
    
    @objc var onMenuAction: RCTDirectEventBlock?
    weak var parentToolbar: NativeToolbar?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        // Keep the view in the hierarchy (not hidden) so RCTDirectEventBlock
        // can dispatch events to JS. Make it invisible instead.
        self.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        self.clipsToBounds = true
        self.alpha = 0
        self.isUserInteractionEnabled = false
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
        guard let items = menuItems as? [[String: Any]] else { return }
        let menuElements = buildMenuElements(from: items)
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
                    let data: [String: Any] = ["id": actionId, "title": title]
                    // Dispatch through parent toolbar (visible view) so RN receives the event
                    if let toolbar = self?.parentToolbar {
                        toolbar.dispatchMenuAction(data)
                    } else {
                        self?.onMenuAction?(data)
                    }
                }
                elements.append(action)
            }
        }
        
        return elements
    }
}
