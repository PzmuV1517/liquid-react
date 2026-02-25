/**
 * RCT view manager and UIView for NativeToolbarButton, bridging UIBarButtonItem.
 * Must be used as a direct child of NativeToolbar.
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

@objc(LRNativeToolbarButtonManager)
class LRNativeToolbarButtonManager: RCTViewManager {

    override func view() -> UIView! {
        return NativeToolbarButtonContainer()
    }

    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeToolbarButtonContainer: UIView {

    private(set) var barButtonItem: UIBarButtonItem!
    weak var parentToolbar: NativeToolbar?

    @objc var icon: NSString = "" {
        didSet {
            updateButton()
        }
    }

    @objc var title: NSString = "" {
        didSet {
            updateButton()
        }
    }

    @objc var systemItem: NSString = "" {
        didSet {
            updateButton()
        }
    }

    @objc var disabled: Bool = false {
        didSet {
            barButtonItem.isEnabled = !disabled
        }
    }

    @objc var onPress: RCTBubblingEventBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        // Keep the view in the hierarchy (not hidden) so RCTBubblingEventBlock
        // can dispatch events to JS. Make it invisible instead.
        self.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        self.clipsToBounds = true
        self.alpha = 0
        self.isUserInteractionEnabled = false
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        barButtonItem = UIBarButtonItem()
        barButtonItem.target = self
        barButtonItem.action = #selector(handlePress)
        updateButton()
    }

    private func updateButton() {
        if systemItem.length > 0 {
            if let item = createSystemItem(systemItem as String) {
                barButtonItem = item
                barButtonItem.target = self
                barButtonItem.action = #selector(handlePress)
            }
        } else if icon.length > 0 {
            barButtonItem.image = UIImage(systemName: icon as String)
            barButtonItem.title = nil
        } else if title.length > 0 {
            barButtonItem.title = title as String
            barButtonItem.image = nil
        }

        barButtonItem.isEnabled = !disabled
    }

    private func createSystemItem(_ systemItem: String) -> UIBarButtonItem? {
        let type: UIBarButtonItem.SystemItem

        switch systemItem {
        case "done": type = .done
        case "cancel": type = .cancel
        case "edit": type = .edit
        case "save": type = .save
        case "add": type = .add
        case "compose": type = .compose
        case "reply": type = .reply
        case "action": type = .action
        case "organize": type = .organize
        case "bookmarks": type = .bookmarks
        case "search": type = .search
        case "refresh": type = .refresh
        case "stop": type = .stop
        case "camera": type = .camera
        case "trash": type = .trash
        case "play": type = .play
        case "pause": type = .pause
        case "rewind": type = .rewind
        case "fastForward": type = .fastForward
        case "undo": type = .undo
        case "redo": type = .redo
        case "close": type = .close
        default: return nil
        }

        return UIBarButtonItem(barButtonSystemItem: type, target: self, action: #selector(handlePress))
    }

    @objc private func handlePress() {
        let data: [String: Any] = ["icon": icon as String, "title": title as String]
        // Dispatch through parent toolbar (visible view) so RN receives the event
        if let toolbar = parentToolbar {
            toolbar.dispatchButtonPress(data)
        } else {
            onPress?(data)
        }
    }
}
