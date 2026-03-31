import Foundation
import UIKit
import React

@objc(LRNativeMaterialViewManager)
class LRNativeMaterialViewManager: RCTViewManager {
    
    override func view() -> UIView! {
        return NativeMaterialView()
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeMaterialView: UIView {
        // WARNING: This implementation is currently broken. React Native children do not render correctly.
    
    private var effectView: UIVisualEffectView!
    private var contentView: UIView!
    
    @objc var material: NSString = "systemMaterial" {
        didSet {
            updateMaterial()
        }
    }
    @objc var appearanceMode: NSString = "auto" {
        didSet {
            applyAppearanceMode()
        }
    }
    @objc var onPress: RCTBubblingEventBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        setupView()
        applyAppearanceMode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.clipsToBounds = true
        setupView()
        applyAppearanceMode()
    }
    
    private func setupView() {
        // Create blur effect view at the back
        let blurEffect = getBlurEffect(for: material as String)
        effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.isUserInteractionEnabled = false
        addSubview(effectView)
        // Create a content view for React Native children
        contentView = UIView()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
        addSubview(contentView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
        // MARK: - React Native subview management
        override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
            contentView.insertSubview(subview, at: atIndex)
        }
        override func removeReactSubview(_ subview: UIView!) {
            subview.removeFromSuperview()
        }
        override func reactSubviews() -> [UIView]! {
            return contentView.subviews
        }
        override func didUpdateReactSubviews() {
            contentView.setNeedsLayout()
        }
    
    private func updateMaterial() {
        let blurEffect = getBlurEffect(for: material as String)
        effectView.effect = blurEffect
    }

    private func applyAppearanceMode() {
        lrApplyAppearanceMode(appearanceMode as String, to: self)
    }
    
    private func getBlurEffect(for material: String) -> UIBlurEffect {
        let style: UIBlurEffect.Style
        
        switch material {
        case "systemUltraThinMaterial":
            style = .systemUltraThinMaterial
        case "systemThinMaterial":
            style = .systemThinMaterial
        case "systemMaterial":
            style = .systemMaterial
        case "systemThickMaterial":
            style = .systemThickMaterial
        case "systemChromeMaterial":
            style = .systemChromeMaterial
        case "systemUltraThinMaterialLight":
            style = .systemUltraThinMaterialLight
        case "systemThinMaterialLight":
            style = .systemThinMaterialLight
        case "systemMaterialLight":
            style = .systemMaterialLight
        case "systemThickMaterialLight":
            style = .systemThickMaterialLight
        case "systemChromeMaterialLight":
            style = .systemChromeMaterialLight
        case "systemUltraThinMaterialDark":
            style = .systemUltraThinMaterialDark
        case "systemThinMaterialDark":
            style = .systemThinMaterialDark
        case "systemMaterialDark":
            style = .systemMaterialDark
        case "systemThickMaterialDark":
            style = .systemThickMaterialDark
        case "systemChromeMaterialDark":
            style = .systemChromeMaterialDark
        default:
            style = .systemMaterial
        }
        
        return UIBlurEffect(style: style)
    }
    
    @objc private func handleTap() {
        onPress?([:])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        effectView.frame = bounds
        contentView.frame = bounds
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
