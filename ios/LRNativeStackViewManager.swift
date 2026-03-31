import Foundation
import UIKit
import React

@objc(LRNativeStackViewManager)
class LRNativeStackViewManager: RCTViewManager {
    
    override func view() -> UIView! {
        return NativeStackView()
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeStackView: UIView {
    
    private var stackView: UIStackView!
    
    @objc var axis: NSString = "vertical" {
        didSet {
            updateAxis()
        }
    }
    
    @objc var spacing: NSNumber = 8 {
        didSet {
            stackView.spacing = CGFloat(truncating: spacing)
        }
    }
    
    @objc var alignment: NSString = "fill" {
        didSet {
            updateAlignment()
        }
    }
    
    @objc var distribution: NSString = "fill" {
        didSet {
            updateDistribution()
        }
    }

    @objc var appearanceMode: NSString = "auto" {
        didSet {
            applyAppearanceMode()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.clipsToBounds = false
        setupStackView()
        applyAppearanceMode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
        self.clipsToBounds = false
        setupStackView()
        applyAppearanceMode()
    }
    
    private func setupStackView() {
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func updateAxis() {
        stackView.axis = (axis as String) == "horizontal" ? .horizontal : .vertical
    }
    
    private func updateAlignment() {
        switch alignment as String {
        case "leading":
            stackView.alignment = .leading
        case "trailing":
            stackView.alignment = .trailing
        case "center":
            stackView.alignment = .center
        case "fill":
            stackView.alignment = .fill
        case "firstBaseline":
            stackView.alignment = .firstBaseline
        case "lastBaseline":
            stackView.alignment = .lastBaseline
        default:
            stackView.alignment = .fill
        }
    }
    
    private func updateDistribution() {
        switch distribution as String {
        case "fill":
            stackView.distribution = .fill
        case "fillEqually":
            stackView.distribution = .fillEqually
        case "fillProportionally":
            stackView.distribution = .fillProportionally
        case "equalSpacing":
            stackView.distribution = .equalSpacing
        case "equalCentering":
            stackView.distribution = .equalCentering
        default:
            stackView.distribution = .fill
        }
    }

    private func applyAppearanceMode() {
        lrApplyAppearanceMode(appearanceMode as String, to: self)
    }
    
    override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
        if atIndex >= stackView.arrangedSubviews.count {
            stackView.addArrangedSubview(subview)
        } else {
            stackView.insertArrangedSubview(subview, at: atIndex)
        }
        invalidateIntrinsicContentSize()
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    override func removeReactSubview(_ subview: UIView!) {
        stackView.removeArrangedSubview(subview)
        subview.removeFromSuperview()
        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }
    
    override func didUpdateReactSubviews() {
        super.didUpdateReactSubviews()
        invalidateIntrinsicContentSize()
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        // Calculate total height from all arranged subviews
        let height = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
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
