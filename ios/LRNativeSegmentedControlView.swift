/**
 * RCT view manager and UIView for NativeSegmentedControl, bridging UISegmentedControl.
 * ⚠️ Currently broken — liquid glass selection rendering is unreliable when bridged into React Native.
 *
 *
 * MIT License
 *
 * Copyright (c) 2026 Banu Andrei & Mircea Levin-Constantin
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
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
