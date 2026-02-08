import Foundation
import UIKit
import React

@objc(LRNativeSegmentedControlManager)
class LRNativeSegmentedControlManager: RCTViewManager {
    override func view() -> UIView! {
        return NativeSegmentedControlView()
    }
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeSegmentedControlView: UIView {
        // WARNING: This implementation is currently broken. UIKit liquid glass rendering is not reliable in React Native context.
    private let materialView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    private let segmentedControl = UISegmentedControl()
    
    @objc var segments: NSArray = [] {
        didSet {
            updateSegments()
        }
    }
    @objc var selectedIndex: NSInteger = 0 {
        didSet {
            if segmentedControl.selectedSegmentIndex != selectedIndex {
                segmentedControl.selectedSegmentIndex = selectedIndex
                segmentedControl.setNeedsLayout()
                segmentedControl.layoutIfNeeded()
            }
        }
    }
    @objc var onValueChange: RCTBubblingEventBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        addSubview(materialView)
        materialView.backgroundColor = .clear
        materialView.contentView.backgroundColor = .clear
        materialView.contentView.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(handleValueChange), for: .valueChanged)
        segmentedControl.backgroundColor = nil
        segmentedControl.tintColor = nil
        segmentedControl.selectedSegmentTintColor = nil
    }
    required init?(coder: NSCoder) { fatalError() }
    
    private func updateSegments() {
        segmentedControl.removeAllSegments()
        for (index, segment) in segments.enumerated() {
            if let title = segment as? String {
                segmentedControl.insertSegment(withTitle: title, at: index, animated: false)
            }
        }
        if selectedIndex >= 0 && selectedIndex < segments.count {
            segmentedControl.selectedSegmentIndex = selectedIndex
            segmentedControl.setNeedsLayout()
            segmentedControl.layoutIfNeeded()
        }
    }
    @objc private func handleValueChange() {
        onValueChange?(["selectedIndex": segmentedControl.selectedSegmentIndex])
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        materialView.frame = bounds
        segmentedControl.frame = bounds.insetBy(dx: 4, dy: 4)
        segmentedControl.setNeedsLayout()
        segmentedControl.layoutIfNeeded()
    }
}
