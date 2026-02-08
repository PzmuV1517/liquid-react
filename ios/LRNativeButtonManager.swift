import Foundation
import UIKit
import React

@objc(LRNativeButtonManager)
class LRNativeButtonManager: RCTViewManager {
    
    override func view() -> UIView! {
        return NativeButton()
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeButton: UIView {
    
    private var button: UIButton!
    
    @objc var title: NSString = "" {
        didSet {
            updateButton()
        }
    }
    
    @objc var buttonStyle: NSString = "filled" {
        didSet {
            updateButton()
        }
    }
    
    @objc var onPress: RCTBubblingEventBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        var configuration = UIButton.Configuration.filled()
        button = UIButton(configuration: configuration, primaryAction: nil)
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        button.addTarget(self, action: #selector(handlePress), for: .touchUpInside)
        addSubview(button)
        updateButton()
    }
    
    private func updateButton() {
        var configuration: UIButton.Configuration
        
        switch buttonStyle as String {
        case "filled":
            configuration = .filled()
        case "gray":
            configuration = .gray()
        case "tinted":
            configuration = .tinted()
        case "plain":
            configuration = .plain()
        case "bordered":
            configuration = .bordered()
        case "borderedTinted":
            configuration = .borderedTinted()
        case "borderedProminent":
            configuration = .borderedProminent()
        default:
            configuration = .filled()
        }
        
        configuration.title = title as String
        button.configuration = configuration
    }
    
    @objc private func handlePress() {
        onPress?([:])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = self.bounds
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }
}
