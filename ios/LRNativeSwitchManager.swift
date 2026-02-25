/**
 * RCT view manager and UIView for NativeSwitch, bridging UISwitch.
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
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(switchControl)
    }

    @objc private func handleValueChange() {
        onValueChange?(["value": switchControl.isOn])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
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
