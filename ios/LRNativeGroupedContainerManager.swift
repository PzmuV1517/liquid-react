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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
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
}
