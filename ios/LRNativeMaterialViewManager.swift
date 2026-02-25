/**
 * RCT view manager and UIView for NativeMaterialView, bridging UIVisualEffectView with system blur materials.
 * ⚠️ Currently broken — React Native children do not render correctly inside this view.
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

    @objc var onPress: RCTBubblingEventBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.clipsToBounds = true
        setupView()
    }

    private func setupView() {
        let blurEffect = getBlurEffect(for: material as String)
        effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.isUserInteractionEnabled = false
        addSubview(effectView)
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
}
