import Foundation
import UIKit
import React

@objc(LRNativeSegmentedControlManager)
class LRNativeSegmentedControlManager: RCTViewManager {
    
    override func view() -> UIView! {
        return NativeSegmentedControl()
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeSegmentedControl: UIView {
    
    private var segmentedControl: UISegmentedControl!
    
    @objc var segments: NSArray = [] {
        didSet {
            updateSegments()
        }
    }
    
    @objc var selectedIndex: NSInteger = 0 {
        didSet {
            if segmentedControl.selectedSegmentIndex != selectedIndex {
                segmentedControl.selectedSegmentIndex = selectedIndex
            }
        }
    }
    
    @objc var onValueChange: RCTBubblingEventBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSegmentedControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSegmentedControl()
    }
    
    private func setupSegmentedControl() {
        segmentedControl = UISegmentedControl()
        segmentedControl.addTarget(self, action: #selector(handleValueChange), for: .valueChanged)
        segmentedControl.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(segmentedControl)
    }
    
    private func updateSegments() {
        segmentedControl.removeAllSegments()
        
        for (index, segment) in segments.enumerated() {
            if let title = segment as? String {
                segmentedControl.insertSegment(withTitle: title, at: index, animated: false)
            }
        }
        
        if selectedIndex >= 0 && selectedIndex < segments.count {
            segmentedControl.selectedSegmentIndex = selectedIndex
        }
    }
    
    @objc private func handleValueChange() {
        onValueChange?(["selectedIndex": segmentedControl.selectedSegmentIndex])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        segmentedControl.frame = bounds
    }
}
