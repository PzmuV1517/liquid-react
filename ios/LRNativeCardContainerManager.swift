import Foundation
import UIKit
import React

@objc(LRNativeCardContainerManager)
class LRNativeCardContainerManager: RCTViewManager {
    
    override func view() -> UIView! {
        return NativeCardContainer()
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeCardContainer: UIView {
    
    @objc var cornerRadius: CGFloat = 10.0 {
        didSet {
            updateAppearance()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        updateAppearance()
    }
    
    private func updateAppearance() {
        // Use system background color (UIKit decides on light/dark)
        backgroundColor = .secondarySystemGroupedBackground
        
        // Use native corner radius
        layer.cornerRadius = cornerRadius
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
    }
}
