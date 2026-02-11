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
    
    @objc var onTextChanged: RCTDirectEventBlock?
    @objc var onSearchPressed: RCTDirectEventBlock?
    @objc var onCancelPressed: RCTDirectEventBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSearchBar()
        backgroundColor = .clear
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
        addSubview(searchBar)
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
}
