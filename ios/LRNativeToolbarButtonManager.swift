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
        self.isHidden = true
        self.frame = CGRect.zero
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
        onPress?([:])
    }
}
