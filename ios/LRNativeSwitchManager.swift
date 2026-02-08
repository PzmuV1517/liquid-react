import Foundation
import UIKit
import React

@objc(LRNativeSwitchManager)
class LRNativeSwitchManager: RCTViewManager {
    
    override func view() -> UIView! {
        return NativeSwitch()
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeSwitch: UIView {
    
    private var switchControl: UISwitch!
    
    @objc var value: Bool = false {
        didSet {
            if switchControl.isOn != value {
                switchControl.setOn(value, animated: true)
            }
        }
    }
    
    @objc var onTintColor: UIColor? {
        didSet {
            switchControl.onTintColor = onTintColor
        }
    }
    
    @objc var thumbTintColor: UIColor? {
        didSet {
            switchControl.thumbTintColor = thumbTintColor
        }
    }
    
    @objc var disabled: Bool = false {
        didSet {
            switchControl.isEnabled = !disabled
        }
    }
    
    @objc var onValueChange: RCTBubblingEventBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSwitch()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSwitch()
    }
    
    private func setupSwitch() {
        switchControl = UISwitch()
        switchControl.addTarget(self, action: #selector(handleValueChange), for: .valueChanged)
        addSubview(switchControl)
    }
    
    @objc private func handleValueChange() {
        onValueChange?(["value": switchControl.isOn])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Center the switch within this view's bounds
        let switchSize = switchControl.intrinsicContentSize
        switchControl.frame = CGRect(
            x: (bounds.width - switchSize.width) / 2,
            y: (bounds.height - switchSize.height) / 2,
            width: switchSize.width,
            height: switchSize.height
        )
    }
    
    override var intrinsicContentSize: CGSize {
        return switchControl.intrinsicContentSize
    }
}
