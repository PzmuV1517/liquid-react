import Foundation
import UIKit
import React

@objc(LRNativeGroupedContainerManager)
class LRNativeGroupedContainerManager: RCTViewManager {
    
    override func view() -> UIView! {
        return NativeGroupedContainer()
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeGroupedContainer: UIView {
    
    @objc var insetGrouped: Bool = true {
        didSet {
            updateBackground()
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
        updateBackground()
    }
    
    private func updateBackground() {
        if insetGrouped {
            backgroundColor = .systemGroupedBackground
        } else {
            backgroundColor = .systemBackground
        }
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
