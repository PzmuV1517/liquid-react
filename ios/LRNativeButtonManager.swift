/**
 * RCT view manager and UIView for NativeButton, bridging UIButton with system button configurations.
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
        button.translatesAutoresizingMaskIntoConstraints = true
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
