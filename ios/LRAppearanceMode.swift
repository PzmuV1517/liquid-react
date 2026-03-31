import Foundation
import UIKit

func lrApplyAppearanceMode(_ mode: String, to view: UIView) {
    switch mode {
    case "light":
        view.overrideUserInterfaceStyle = .light
    case "dark":
        view.overrideUserInterfaceStyle = .dark
    case "system":
        view.overrideUserInterfaceStyle = lrResolvedSystemStyle(for: view)
    default:
        // Keep UIKit's default adaptive behavior.
        view.overrideUserInterfaceStyle = .unspecified
    }
}

private func lrResolvedSystemStyle(for view: UIView) -> UIUserInterfaceStyle {
    if let windowScene = view.window?.windowScene {
        let style = windowScene.traitCollection.userInterfaceStyle
        if style == .light || style == .dark {
            return style
        }
    }

    for scene in UIApplication.shared.connectedScenes {
        guard let windowScene = scene as? UIWindowScene else {
            continue
        }

        let style = windowScene.traitCollection.userInterfaceStyle
        if style == .light || style == .dark {
            return style
        }
    }

    let currentStyle = UITraitCollection.current.userInterfaceStyle
    if currentStyle == .light || currentStyle == .dark {
        return currentStyle
    }

    let fallbackStyle = view.traitCollection.userInterfaceStyle
    if fallbackStyle == .light || fallbackStyle == .dark {
        return fallbackStyle
    }

    return .unspecified
}
