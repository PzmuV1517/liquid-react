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
        case "flexibleSpace": type = .flexibleSpace
        case "fixedSpace": type = .fixedSpace
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
