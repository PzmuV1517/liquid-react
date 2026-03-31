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

    @objc var appearanceMode: NSString = "auto" {
        didSet {
            applyAppearanceMode()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        applyAppearanceMode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        applyAppearanceMode()
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

    private func applyAppearanceMode() {
        lrApplyAppearanceMode(appearanceMode as String, to: self)
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
