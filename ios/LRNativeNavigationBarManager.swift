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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupNavigationBar()
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        navigationBar.frame = bounds
    }
}
