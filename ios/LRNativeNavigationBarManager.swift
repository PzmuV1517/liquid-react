import Foundation
import UIKit
import React

@objc(LRNativeNavigationBarManager)
class LRNativeNavigationBarManager: RCTViewManager {
    
    override func view() -> UIView! {
        return NativeNavigationBar()
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeNavigationBar: UIView {
    
    private var navigationBar: UINavigationBar!
    private var navigationItem: UINavigationItem!
    
    @objc var title: NSString = "" {
        didSet {
            navigationItem.title = title as String
        }
    }
    
    @objc var barTintColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }
    
    @objc var translucent: Bool = true {
        didSet {
            navigationBar.isTranslucent = translucent
        }
    }

    @objc var appearanceMode: NSString = "auto" {
        didSet {
            applyAppearanceMode()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNavigationBar()
        applyAppearanceMode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupNavigationBar()
        applyAppearanceMode()
    }
    
    private func setupNavigationBar() {
        navigationBar = UINavigationBar()
        navigationItem = UINavigationItem()
        navigationBar.items = [navigationItem]
        navigationBar.isTranslucent = true
        addSubview(navigationBar)
        updateAppearance()
    }
    
    private func updateAppearance() {
        let appearance = UINavigationBarAppearance()
        
        if let color = barTintColor {
            appearance.backgroundColor = color
        } else {
            appearance.configureWithDefaultBackground()
        }
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }

    private func applyAppearanceMode() {
        lrApplyAppearanceMode(appearanceMode as String, to: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        navigationBar.frame = bounds
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
