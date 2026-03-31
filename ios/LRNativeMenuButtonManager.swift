import Foundation
import UIKit
import React

@objc(LRNativeMenuButtonManager)
class LRNativeMenuButtonManager: RCTViewManager {

    override func view() -> UIView! {
        return NativeMenuButton()
    }

    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class NativeMenuButton: UIView {

    private var button: UIButton!

    // MARK: – React props

    @objc var icon: NSString = "ellipsis.circle" {
        didSet { updateIcon() }
    }

    @objc var tintColorHex: NSString = "" {
        didSet { updateTintColor() }
    }

    @objc var menuItems: NSArray = [] {
        didSet { updateMenu() }
    }

    @objc var appearanceMode: NSString = "auto" {
        didSet { applyAppearanceMode() }
    }

    @objc var onMenuAction: RCTDirectEventBlock?

    // MARK: – Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        applyAppearanceMode()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
        applyAppearanceMode()
    }

    // MARK: – Setup

    private func setupButton() {
        var cfg = UIButton.Configuration.plain()
        cfg.contentInsets = .zero
        button = UIButton(configuration: cfg, primaryAction: nil)
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        updateIcon()
        updateTintColor()
    }

    // MARK: – Updates

    private func updateIcon() {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        let image = UIImage(systemName: icon as String, withConfiguration: symbolConfig)
        button.setImage(image, for: .normal)
    }

    private func updateTintColor() {
        let hex = tintColorHex as String
        if !hex.isEmpty {
            button.tintColor = UIColor(hexString: hex)
        }
    }

    private func updateMenu() {
        guard let items = menuItems as? [[String: Any]] else { return }
        let elements = buildMenuElements(from: items)
        button.menu = UIMenu(children: elements)
    }

    private func applyAppearanceMode() {
        lrApplyAppearanceMode(appearanceMode as String, to: self)
    }

    // MARK: – Menu builder (same recursive logic as NativeToolbarMenu)

    private func buildMenuElements(from items: [[String: Any]]) -> [UIMenuElement] {
        var elements: [UIMenuElement] = []

        for item in items {
            if let children = item["children"] as? [[String: Any]], !children.isEmpty {
                let title = item["title"] as? String ?? ""
                let image = (item["icon"] as? String).flatMap { UIImage(systemName: $0) }
                let submenuElements = buildMenuElements(from: children)
                let submenu = UIMenu(title: title, image: image, children: submenuElements)
                elements.append(submenu)
            } else {
                let title = item["title"] as? String ?? ""
                let image = (item["icon"] as? String).flatMap { UIImage(systemName: $0) }
                let actionId = item["id"] as? String ?? title
                let isDestructive = item["destructive"] as? Bool ?? false
                let isDisabled = item["disabled"] as? Bool ?? false

                var attributes: UIMenuElement.Attributes = []
                if isDestructive { attributes.insert(.destructive) }
                if isDisabled { attributes.insert(.disabled) }

                let action = UIAction(title: title, image: image, attributes: attributes) { [weak self] _ in
                    self?.onMenuAction?(["id": actionId, "title": title])
                }
                elements.append(action)
            }
        }
        return elements
    }

    // MARK: – Sizing: use React-set bounds, fall back to button intrinsic size

    override var intrinsicContentSize: CGSize {
        let b = bounds.size
        if b.width > 0 && b.height > 0 {
            return b
        }
        return button.intrinsicContentSize
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return intrinsicContentSize
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
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

// MARK: – UIColor hex helper

private extension UIColor {
    convenience init?(hexString: String) {
        var hex = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        if hex.hasPrefix("#") { hex.removeFirst() }
        guard hex.count == 6, let rgb = UInt64(hex, radix: 16) else { return nil }
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255.0,
            green: CGFloat((rgb >> 8) & 0xFF) / 255.0,
            blue: CGFloat(rgb & 0xFF) / 255.0,
            alpha: 1.0
        )
    }
}
