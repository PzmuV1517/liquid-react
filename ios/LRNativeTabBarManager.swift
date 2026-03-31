import Foundation
import UIKit
import React

@objc(LRNativeTabBarManager)
class LRNativeTabBarManager: RCTViewManager {
    
    override func view() -> UIView! {
        return NativeTabBar()
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeTabBar: UIView {
            @objc var barHeight: NSNumber? = nil

        override var intrinsicContentSize: CGSize {
            let height = barHeight?.doubleValue ?? 49.0
            return CGSize(width: UIView.noIntrinsicMetric, height: CGFloat(height))
        }
    
    private var tabBar: UITabBar!
    
    @objc var items: NSArray = [] {
        didSet {
            updateItems()
        }
    }
    
    @objc var selectedIndex: NSInteger = 0 {
        didSet {
            if let items = tabBar.items, selectedIndex >= 0 && selectedIndex < items.count {
                tabBar.selectedItem = items[selectedIndex]
            }
        }
    }
    
    @objc var translucent: Bool = true {
        didSet {
            tabBar.isTranslucent = translucent
        }
    }

    @objc var appearanceMode: NSString = "auto" {
        didSet {
            applyAppearanceMode()
        }
    }
    
    @objc var onTabPress: RCTBubblingEventBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabBar()
        applyAppearanceMode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBar()
        applyAppearanceMode()
    }
    
    private func setupTabBar() {
        tabBar = UITabBar()
        tabBar.isTranslucent = true
        tabBar.delegate = self
        addSubview(tabBar)
    }

    private func applyAppearanceMode() {
        lrApplyAppearanceMode(appearanceMode as String, to: self)
    }
    
    private func updateItems() {
        var tabBarItems: [UITabBarItem] = []
        
        for item in items {
            if let itemDict = item as? [String: Any],
               let title = itemDict["title"] as? String {
                
                let tabBarItem = UITabBarItem()
                tabBarItem.title = title
                
                if let systemItem = itemDict["systemItem"] as? String {
                    if let systemTabBarItem = getSystemTabBarItem(systemItem) {
                        tabBarItems.append(systemTabBarItem)
                        continue
                    }
                }
                
                if let iconName = itemDict["icon"] as? String {
                    tabBarItem.image = UIImage(systemName: iconName)
                }
                
                tabBarItems.append(tabBarItem)
            }
        }
        
        tabBar.items = tabBarItems
        
        if selectedIndex >= 0 && selectedIndex < tabBarItems.count {
            tabBar.selectedItem = tabBarItems[selectedIndex]
        }
    }
    
    private func getSystemTabBarItem(_ systemItem: String) -> UITabBarItem? {
        let type: UITabBarItem.SystemItem
        
        switch systemItem {
        case "more":
            type = .more
        case "favorites":
            type = .favorites
        case "featured":
            type = .featured
        case "topRated":
            type = .topRated
        case "recents":
            type = .recents
        case "contacts":
            type = .contacts
        case "history":
            type = .history
        case "bookmarks":
            type = .bookmarks
        case "search":
            type = .search
        case "downloads":
            type = .downloads
        case "mostRecent":
            type = .mostRecent
        case "mostViewed":
            type = .mostViewed
        default:
            return nil
        }
        
        return UITabBarItem(tabBarSystemItem: type, tag: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = barHeight?.doubleValue ?? Double(bounds.height)
        tabBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: CGFloat(height))
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        applyAppearanceMode()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if (appearanceMode as String) == "system" {
            applyAppearanceMode()
        }
    }
}

extension NativeTabBar: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.firstIndex(of: item) {
            onTabPress?(["index": index])
        }
    }
}
