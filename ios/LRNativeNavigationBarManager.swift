/**
 * RCT view manager and UIView for NativeNavigationBar, bridging UINavigationBar.
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

@objc(LRNativeNavigationBarManager)
class LRNativeNavigationBarManager: RCTViewManager {

    override func view() -> UIView! {
        return NativeNavigationBar()
    }

    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeNavigationBar: UIView {

    private var navigationBar: UINavigationBar!
    private var navigationItem: UINavigationItem!

    @objc var title: NSString = "" {
        didSet {
            navigationItem.title = title as String
        }
    }

    @objc var barTintColor: UIColor? {
        didSet {
            updateAppearance()
        }
    }

    @objc var translucent: Bool = true {
        didSet {
            navigationBar.isTranslucent = translucent
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNavigationBar()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationBar = UINavigationBar()
        navigationItem = UINavigationItem()
        navigationBar.items = [navigationItem]
        navigationBar.isTranslucent = true
        addSubview(navigationBar)
        updateAppearance()
    }

    private func updateAppearance() {
        let appearance = UINavigationBarAppearance()

        if let color = barTintColor {
            appearance.backgroundColor = color
        } else {
            appearance.configureWithDefaultBackground()
        }

        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        navigationBar.frame = bounds
    }
}
