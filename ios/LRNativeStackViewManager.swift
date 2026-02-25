/**
 * RCT view manager and UIView for NativeStackView, bridging UIStackView for axis-based child layout.
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.clipsToBounds = false
        setupStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
        self.clipsToBounds = false
        setupStackView()
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
        let height = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
}