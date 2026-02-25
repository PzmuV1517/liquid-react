/**
 * RCT view manager and UIView for NativeTabBar, bridging UITabBar.
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

    @objc var onTabPress: RCTBubblingEventBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabBar()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBar()
    }

    private func setupTabBar() {
        tabBar = UITabBar()
        tabBar.isTranslucent = true
        tabBar.delegate = self
        addSubview(tabBar)
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
}

extension NativeTabBar: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.firstIndex(of: item) {
            onTabPress?(["index": index])
        }
    }
}
