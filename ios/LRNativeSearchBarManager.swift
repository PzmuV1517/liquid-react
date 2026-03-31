import Foundation
import UIKit
import React

@objc(LRNativeSearchBarManager)
class LRNativeSearchBarManager: RCTViewManager {
    
    override func view() -> UIView! {
        return NativeSearchBar()
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeSearchBar: UIView, UISearchBarDelegate {
    
    private var searchBar: UISearchBar!
    
    @objc var placeholder: NSString = "" {
        didSet {
            searchBar.placeholder = placeholder as String
        }
    }
    
    @objc var text: NSString = "" {
        didSet {
            if searchBar.text != text as String {
                searchBar.text = text as String
            }
        }
    }

    @objc var appearanceMode: NSString = "auto" {
        didSet {
            applyAppearanceMode()
        }
    }
    
    @objc var onTextChanged: RCTDirectEventBlock?
    @objc var onSearchPressed: RCTDirectEventBlock?
    @objc var onCancelPressed: RCTDirectEventBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
        backgroundColor = .clear
        applyAppearanceMode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSearchBar()
        backgroundColor = .clear
        applyAppearanceMode()
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
        addSubview(searchBar)
    }

    private func applyAppearanceMode() {
        lrApplyAppearanceMode(appearanceMode as String, to: self)
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        onTextChanged?(["text": searchText])
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        onSearchPressed?(["text": searchBar.text ?? ""])
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        onCancelPressed?([:])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        applyAppearanceMode()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if (appearanceMode as String) == "system" {
            applyAppearanceMode()
        }
    }
}
